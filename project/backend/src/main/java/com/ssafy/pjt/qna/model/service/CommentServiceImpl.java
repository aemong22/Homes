package com.ssafy.pjt.qna.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.pjt.qna.dto.Comment;
import com.ssafy.pjt.qna.model.mapper.CommentDao;


@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;

	@Override
	public List<Comment> list(int qnaNo) {
		return commentDao.list(qnaNo);
	}

	@Override
	public boolean create(Comment commentDto) {
		return commentDao.create(commentDto) == 1;
	}

	@Override
	public boolean modify(Comment commentDto) {
		return commentDao.modify(commentDto) == 1;
	}

	@Override
	public boolean delete(int commentNo) {
		return commentDao.delete(commentNo) == 1;
	}
}
