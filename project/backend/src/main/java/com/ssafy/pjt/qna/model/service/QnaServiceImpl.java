package com.ssafy.pjt.qna.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.pjt.notice.model.mapper.NoticeDao;
import com.ssafy.pjt.qna.dto.QnaDto;
import com.ssafy.pjt.qna.model.mapper.QnADao;

@Service
public class QnaServiceImpl implements QnaService{
	private final QnADao qnaDao;
	
	@Autowired
	public QnaServiceImpl(QnADao qnaDao) {
		this.qnaDao = qnaDao;
	}
	@Override
	public List<QnaDto> getLists() {
		return qnaDao.selectAll();
	}
	@Override
	public int write(QnaDto qna) {
		return qnaDao.insert(qna);
	}
	@Override
	public int editQna(QnaDto qna) {
		return qnaDao.update(qna);
	}
	@Override
	public int deleteQna(String id) {
		return qnaDao.delete(id);
	}

	@Override
	public List<QnaDto> getSearch(String search) {
		return qnaDao.search(search);
	}
	@Override
	public int getCountQ(String userId) {
		return qnaDao.getCountQ(userId);
	}
	

}
