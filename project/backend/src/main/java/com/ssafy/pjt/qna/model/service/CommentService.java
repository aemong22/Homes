package com.ssafy.pjt.qna.model.service;

import java.util.List;

import com.ssafy.pjt.qna.dto.Comment;


public interface CommentService {

	List<Comment> list(int qnaNo);

	boolean create(Comment commentDto);

	boolean modify(Comment commentDto);

	boolean delete(int commentNo);

}
