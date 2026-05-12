package com.demo01.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 자유게시판 게시글 모델
 * 
 * [설명]
 * - 이 클래스는 게시판에 작성되는 '글'을 나타냅니다.
 * - 예를 들어, 사용자가 '제목', '내용', '작성자'를 입력해 글을 올리면
 *   이 객체에 정보가 저장됩니다.
 * - 각 글은唯一的(고유)한 번호(id)를 가지고 있고, 언제 작성했는지(createdAt)
 *  记录的等信息도 저장합니다.
 * - 첨부파일 목록(attachments)과 댓글 목록(comments)도 함께 관리합니다.
 * 
 * [주요 속성]
 * - id: 글의 고유 번호 (데이터베이스에서 자동 증가)
 * - title: 글 제목
 * - author: 글 작성자 (비회원이 이름을 입력하거나 회원 아이디)
 * - content: 글 내용
 * - createdAt: 글 작성일시
 * - attachments: 첨부파일 경로 목록
 * - comments: 이 글에 달린 댓글 목록
 * 
 * [사용 방법]
 * - 새 글을 작성할 때는 'new BoardPost()'로 객체를 만들고
 *   setTitle(), setContent(), setAuthor() 등의 메서드로 값을 채운 뒤 저장합니다.
 * - 이미 저장된 글은 id로 찾아서 정보를 조회하거나 수정할 수 있습니다.
 */
public class BoardPost {
    // 글의 고유 번호 (데이터베이스에서 자동으로 부여됨)
    private long id;
    
    // 글 작성자 (비회원이 이름을 입력하거나 회원 아이디)
    private String author;
    
    // 글 제목
    private String title;
    
    // 글 내용 (본문)
    private String content;
    
    // 글 작성 일시 (예: 2026-05-11 19:00:00)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime createdAt;
    
    // 이 글에 첨부된 파일 목록 (파일 경로를 문자열로 저장)
    private List<String> attachments = new ArrayList<>();
    
    // 이 글에 달린 댓글 목록
    private List<Comment> comments = new ArrayList<>();

    // 기본 생성자 (빈 객체 생성)
    public BoardPost() {}

    // 파라미터가 있는 생성자 (글을 한 번에 만들어 사용할 때 convenient)
    public BoardPost(long id, String title, String content, LocalDateTime createdAt) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
    }

    // Getter와 Setter 메서드들
    // Getter: 값을 읽어오는 메서드
    // Setter: 값을 설정하는 메서드
    
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public List<String> getAttachments() { return attachments; }
    public void setAttachments(List<String> attachments) { this.attachments = attachments; }
    
    public List<Comment> getComments() { return comments; }
    public void setComments(List<Comment> comments) { this.comments = comments; }
}
