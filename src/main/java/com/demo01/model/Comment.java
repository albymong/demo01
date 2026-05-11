package com.demo01.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;

/**
 * 게시글 댓글 모델
 * 
 * [설명]
 * - 이 클래스는 게시글에 달리는 '댓글'을 나타냅니다.
 * - 예를 들어, 어떤 글에 "좋은 글입니다" 같은 comment를 달면
 *   이 객체에 정보가 저장됩니다.
 * - 각 댓글도 고유 번호(id)를 가지고 있고, 언제 작성했는지 기록합니다.
 * 
 * [주요 속성]
 * - id: 댓글의 고유 번호 (데이터베이스에서 자동 증가)
 * - author: 댓글 작성자 (비회원이 이름을 입력하거나 회원 아이디)
 * - text: 댓글 내용 (글 내용)
 * - createdAt: 댓글 작성 일시
 * 
 * [사용 방법]
 * - 새 댓글을 작성할 때는 'new Comment()'로 객체를 만들고
 *   setAuthor(), setText() 등으로 값을 채운 뒤 저장합니다.
 */
public class Comment {
    // 댓글 고유 번호 (데이터베이스에서 자동 증가)
    private long id;
    
    // 댓글 작성자 (누가 댓글을 썼는지)
    private String author;
    
    // 댓글 내용 (댓글의 본문)
    @JsonProperty("commentText")
    private String text;
    
    // 댓글 작성 일시 (언제 댓글을 썼는지)
    private LocalDateTime createdAt;

    // 기본 생성자 (빈 객체 생성)
    public Comment() {}

    // 파라미터가 있는 생성자 (한 번에 댓글 정보를 설정)
    public Comment(long id, String author, String text, LocalDateTime createdAt) {
        this.id = id;
        this.author = author;
        this.text = text;
        this.createdAt = createdAt;
    }

    // Getter와 Setter 메서드들
    // Getter: 값을 읽어오는 메서드
    // Setter: 값을 설정하는 메서드
    
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public String getText() { return text; }
    public void setText(String text) { this.text = text; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
