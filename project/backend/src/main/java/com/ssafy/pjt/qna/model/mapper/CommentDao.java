package com.ssafy.pjt.qna.model.mapper;

import java.util.List;

import com.ssafy.pjt.qna.dto.Comment;

public interface CommentDao {

	List<Comment> list(int qnaNo);

	int create(Comment commentDto);

	int modify(Comment commentDto);

	int delete(int commentNo);
	
}
