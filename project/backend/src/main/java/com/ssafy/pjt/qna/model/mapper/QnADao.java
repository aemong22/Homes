package com.ssafy.pjt.qna.model.mapper;

import java.util.List;

import com.ssafy.pjt.qna.dto.QnaDto;

public interface QnADao {

	List<QnaDto> selectAll();

	int insert(QnaDto qna);

	int update(QnaDto qna);

	int delete(String id);

	List<QnaDto> search(String search);

	int getCountQ(String userId);

}
