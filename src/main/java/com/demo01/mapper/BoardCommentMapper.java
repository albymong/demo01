package com.demo01.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.demo01.model.Comment;

@Mapper
public interface BoardCommentMapper {
    List<Comment> findByPostId(@Param("postId") long postId);
    int insert(@Param("postId") long postId, @Param("comment") Comment comment);
    int delete(@Param("id") long id);
}