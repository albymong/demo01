package com.demo01.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.demo01.model.BoardPost;

@Mapper
public interface BoardPostMapper {
    List<BoardPost> findAll();
    BoardPost findById(@Param("id") long id);
    int insert(BoardPost post);
    int update(BoardPost post);
    int delete(@Param("id") long id);
    List<String> findAttachmentsByPostId(@Param("id") long id);
    void insertAttachment(@Param("postId") long postId, @Param("filename") String filename);
    void deleteAttachmentsByPostId(@Param("postId") long postId);
}