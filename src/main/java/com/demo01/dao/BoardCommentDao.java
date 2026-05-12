package com.demo01.dao;

import com.demo01.mapper.BoardCommentMapper;
import com.demo01.model.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 자유게시판 댓글 DAO
 * 
 * [설명]
 * - 데이터베이스의 board_comment 테이블과 연동하여 댓글을 관리합니다.
 * - MyBatis Mapper를 사용하여 SQL을 실행합니다.
 * 
 * [주요 기능]
 * - 특정 게시글의 댓글 목록 조회 (findByPostId)
 * - 댓글 등록 (insert)
 * - 댓글 삭제 (delete)
 */
@Repository
public class BoardCommentDao {

    @Autowired
    private BoardCommentMapper boardCommentMapper;

    public List<Comment> findByPostId(long postId) {
        return boardCommentMapper.findByPostId(postId);
    }

    public int insert(long postId, Comment comment) {
        return boardCommentMapper.insert(postId, comment);
    }

    public int delete(long commentId) {
        return boardCommentMapper.delete(commentId);
    }
}