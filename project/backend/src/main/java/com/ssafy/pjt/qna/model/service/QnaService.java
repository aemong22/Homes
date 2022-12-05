package com.ssafy.pjt.qna.model.service;

import java.util.List;

import com.ssafy.pjt.qna.dto.QnaDto;

public interface QnaService {
	List<QnaDto> getLists();

	int write(QnaDto qna);

	int editQna(QnaDto qna);

	int deleteQna(String id);

	List<QnaDto> getSearch(String search);

	int getCountQ(String userId);

}
