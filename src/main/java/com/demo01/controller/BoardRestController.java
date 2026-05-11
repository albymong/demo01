package com.demo01.controller;

import com.demo01.dao.BoardCommentDao;
import com.demo01.dao.BoardPostDao;
import com.demo01.model.BoardPost;
import com.demo01.model.Comment;
import com.demo01.util.FileUploadUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * 자유게시판 REST API 컨트롤러
 * 
 * [설명]
 * - 게시판의 데이터를 JSON 형태로 제공하는 API 엔드포인트입니다.
 * - AJAX로 호출되어 비동기로 데이터를 가져오거나 저장합니다.
 * - 예: 글 목록 조회, 글 작성, 수정, 삭제, 댓글管理等
 * 
 * [엔드포인트]
 * - GET  /api/board/posts       : 전체 게시글 목록
 * - GET  /api/board/posts/{id} : 특정 게시글 (댓글 포함)
 * - POST /api/board/posts      : 새 게시글 작성
 * - PUT  /api/board/posts/{id} : 게시글 수정
 * - DELETE /api/board/posts/{id} : 게시글 삭제
 * - POST /api/board/posts/{id}/comments : 댓글 작성
 * - DELETE /api/board/comments/{commentId} : 댓글 삭제
 */
@RestController  // REST API 컨트롤러 (JSON 반환)
@RequestMapping("/api/board")
public class BoardRestController {

    // 로그	logger (SLF4J)
    private static final Logger logger = LoggerFactory.getLogger(BoardRestController.class);

    @Autowired
    private BoardPostDao boardPostDao;

    @Autowired
    private BoardCommentDao boardCommentDao;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * [GET] 전체 게시글 목록 조회
     * - DB에서 모든 게시글을 가져와서 JSON 배열로 반환
     */
    @GetMapping("/posts")
    public List<BoardPost> getAllPosts() {
        logger.info("전체 게시글 목록 요청");
        List<BoardPost> posts = boardPostDao.findAll();
        logger.info("조회된 게시글 수: {}", posts.size());
        return posts;
    }

    /**
     * [GET] 특정 게시글 조회 (게시글 + 댓글)
     * - path variable로 글 ID를 받아 해당 게시글 정보와 댓글 목록을 반환
     */
    @GetMapping("/posts/{id}")
    public Map<String, Object> getPost(@PathVariable(name = "id") long id) {
        BoardPost post = boardPostDao.findById(id);
        List<Comment> comments = boardCommentDao.findByPostId(id);
        
        Map<String, Object> result = new HashMap<>();
        result.put("post", post);
        result.put("comments", comments);
        return result;
    }

    /**
     * [POST] 새 게시글 작성 (JSON)
     */
    @PostMapping("/posts")
    public Map<String, Object> createPost(@RequestBody BoardPost post) {
        return createPostInternal(post, null);
    }
    
    /**
     * [POST] 새 게시글 작성 (파일 업로드 포함)
     * - multipart/form-data 형식으로 제목, 내용, 작성자, 파일을 전송
     */
    @PostMapping(value = "/posts/upload", consumes = "multipart/form-data")
    public Map<String, Object> createPostWithFiles(
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam("author") String author,
            @RequestParam(value = "files", required = false) MultipartFile[] files) {
        
        BoardPost post = new BoardPost();
        post.setTitle(title);
        post.setContent(content);
        post.setAuthor(author);
        
        return createPostInternal(post, files);
    }
    
    private Map<String, Object> createPostInternal(BoardPost post, MultipartFile[] files) {
        if (post.getAuthor() == null || post.getAuthor().trim().isEmpty()) {
            post.setAuthor("익명");
        }
        
        try {
            // 파일 업로드
            if (files != null && files.length > 0) {
                List<String> filenames = FileUploadUtil.uploadFiles(files);
                post.setAttachments(filenames);
            }
            
            int result = boardPostDao.insert(post);
            
            Map<String, Object> response = new HashMap<>();
            if (result > 0) {
                response.put("success", true);
                response.put("message", "게시글이 등록되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "게시글 등록에 실패했습니다.");
            }
            return response;
        } catch (Exception e) {
            logger.error("파일 업로드 또는 게시글 등록 오류", e);
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
            return response;
        }
    }

    /**
     * [PUT] 게시글 수정
     * - 글쓴이가 동일하거나 관리자(admin)라면 수정 허용
     * - 여기서는 간단하게 author가 동일하면 수정 가능하도록 구현
     */
    @PutMapping("/posts/{id}")
    public Map<String, Object> updatePost(@PathVariable(name = "id") long id, 
                                          @RequestBody BoardPost post,
                                          @RequestParam(name = "admin", required = false) String admin) {
        BoardPost existing = boardPostDao.findById(id);
        
        // 기존 글이 없으면 오류
        if (existing == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "게시글이 존재하지 않습니다.");
            return error;
        }

        // 관리자이거나 작성자가 동일하면 수정 허용
        // (실제 운영에서는 세션이나 권한 체크 필요)
        boolean isAdmin = "true".equals(admin);
        boolean isOwner = post.getAuthor() != null && post.getAuthor().equals(existing.getAuthor());

        if (!isAdmin && !isOwner) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "수정 권한이 없습니다.");
            return error;
        }

        // id 설정 후 업데이트
        post.setId(id);
        int result = boardPostDao.update(post);
        
        Map<String, Object> response = new HashMap<>();
        if (result > 0) {
            response.put("success", true);
            response.put("message", "게시글이 수정되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "게시글 수정에 실패했습니다.");
        }
        return response;
    }
    
    /**
     * [POST] 게시글 수정 (파일 업로드 포함)
     */
    @PostMapping("/posts/{id}/edit")
    public Map<String, Object> updatePostWithFiles(
            @PathVariable(name = "id") long id,
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam("author") String author,
            @RequestParam(value = "files", required = false) MultipartFile[] files) {
        
        BoardPost existing = boardPostDao.findById(id);
        
        if (existing == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "게시글이 존재하지 않습니다.");
            return error;
        }
        
        BoardPost post = new BoardPost();
        post.setId(id);
        post.setTitle(title);
        post.setContent(content);
        post.setAuthor(author);
        
        try {
            if (files != null && files.length > 0) {
                List<String> filenames = FileUploadUtil.uploadFiles(files);
                post.setAttachments(filenames);
                
                for (String filename : filenames) {
                    String sql = "INSERT INTO board_attachment (post_id, file_path) VALUES (?, ?)";
                    jdbcTemplate.update(sql, id, filename);
                }
            }
            
            int result = boardPostDao.update(post);
            
            Map<String, Object> response = new HashMap<>();
            if (result > 0) {
                response.put("success", true);
                response.put("message", "게시글이 수정되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "게시글 수정에 실패했습니다.");
            }
            return response;
        } catch (Exception e) {
            logger.error("게시글 수정 오류", e);
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
            return response;
        }
    }

    /**
     * [DELETE] 게시글 삭제
     * - 작성자가 동일하거나 관리자(admin)라면 삭제 허용
     */
    @DeleteMapping("/posts/{id}")
    public Map<String, Object> deletePost(@PathVariable(name = "id") long id,
                                         @RequestParam(name = "author", required = false) String author,
                                         @RequestParam(name = "admin", required = false) String admin) {
        BoardPost existing = boardPostDao.findById(id);
        
        if (existing == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "게시글이 존재하지 않습니다.");
            return error;
        }

        boolean isAdmin = "true".equals(admin);
        boolean isOwner = author != null && author.equals(existing.getAuthor());

        if (!isAdmin && !isOwner) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "삭제 권한이 없습니다.");
            return error;
        }

        int result = boardPostDao.delete(id);
        
        Map<String, Object> response = new HashMap<>();
        if (result > 0) {
            response.put("success", true);
            response.put("message", "게시글이 삭제되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "게시글 삭제에 실패했습니다.");
        }
        return response;
    }

    /**
     * [POST] 댓글 작성
     * - 특정 게시글에 댓글을 추가
     */
    @PostMapping("/posts/{postId}/comments")
    public Map<String, Object> createComment(@PathVariable(name = "postId") long postId, @RequestBody Comment comment) {
        // author가 비어있으면 "익명"으로 설정
        if (comment.getAuthor() == null || comment.getAuthor().trim().isEmpty()) {
            comment.setAuthor("익명");
        }
        
        int result = boardCommentDao.insert(postId, comment);
        
        Map<String, Object> response = new HashMap<>();
        if (result > 0) {
            response.put("success", true);
            response.put("message", "댓글이 등록되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "댓글 등록에 실패했습니다.");
        }
        return response;
    }

    /**
     * [DELETE] 댓글 삭제
     */
    @DeleteMapping("/comments/{commentId}")
    public Map<String, Object> deleteComment(@PathVariable(name = "commentId") long commentId) {
        int result = boardCommentDao.delete(commentId);
        
        Map<String, Object> response = new HashMap<>();
        if (result > 0) {
            response.put("success", true);
            response.put("message", "댓글이 삭제되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "댓글 삭제에 실패했습니다.");
        }
        return response;
    }
    
    /**
     * [GET] 파일 다운로드
     */
    @GetMapping("/files/{filename}")
    public ResponseEntity<Resource> downloadFile(@PathVariable(name = "filename") String filename) throws IOException {
        String uploadDir = "D:/uploads/board";
        Path filePath = Paths.get(uploadDir, filename);
        
        if (!Files.exists(filePath)) {
            return ResponseEntity.notFound().build();
        }
        
        Resource resource = new FileSystemResource(filePath);
        
        String contentType = Files.probeContentType(filePath);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .body(resource);
    }
}