package com.ssafy.pjt.notice.model.mapper;

import java.util.List;

import com.ssafy.pjt.notice.dto.NoticeDto;

public interface NoticeDao {

	List<NoticeDto> selectAll();

	int insert(NoticeDto notice);

	int delete(String id);

	int update(NoticeDto notice);

}
