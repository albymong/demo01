package com.demo01.dao;

import com.demo01.mapper.BoardPostMapper;
import com.demo01.model.BoardPost;
import com.demo01.util.FileUploadUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 자유게시판 게시글 DAO
 * 
 * [설명]
 * - 데이터베이스의 board_post 테이블과 연동하여 게시글을 관리합니다.
 * - MyBatis Mapper를 사용하여 SQL을 실행합니다.
 * - 이 클래스는 데이터 접근 계층(DAO)입니다.
 * 
 * [주요 기능]
 * - 전체 게시글 조회 (findAll)
 * - 특정 게시글 조회 (findById)
 * - 게시글 등록 (insert)
 * - 게시글 수정 (update)
 * - 게시글 삭제 (delete)
 */
@Repository
public class BoardPostDao {

    private static final Logger logger = LoggerFactory.getLogger(BoardPostDao.class);

    @Autowired
    private BoardPostMapper boardPostMapper;

    public List<BoardPost> findAll() {
        logger.info("DB에서 전체 게시글 조회 시작");
        List<BoardPost> result = boardPostMapper.findAll();
        logger.info("조회된 게시글 수: {}", result.size());
        return result;
    }

    public BoardPost findById(long id) {
        BoardPost post = boardPostMapper.findById(id);
        if (post != null) {
            List<String> attachments = boardPostMapper.findAttachmentsByPostId(id);
            post.setAttachments(attachments);
        }
        return post;
    }

    public int insert(BoardPost post) {
        int result = boardPostMapper.insert(post);
        
        if (result > 0 && post.getAttachments() != null && !post.getAttachments().isEmpty()) {
            for (String filename : post.getAttachments()) {
                boardPostMapper.insertAttachment(post.getId(), filename);
            }
        }
        
        return result;
    }

    public int update(BoardPost post) {
        return boardPostMapper.update(post);
    }

    public int delete(long id) {
        // 첨부파일 물리 파일 삭제
        List<String> attachments = boardPostMapper.findAttachmentsByPostId(id);
        for (String filename : attachments) {
            FileUploadUtil.deleteFile(filename);
        }
        
        return boardPostMapper.delete(id);
    }
}