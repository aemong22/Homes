package com.ssafy.pjt.notice.model.service;

import java.util.List;

import com.ssafy.pjt.notice.dto.NoticeDto;

public interface NoticeService {

	int write(NoticeDto notice);

	List<NoticeDto> getNotices();

	int deleteNotice(String id);

	int editNotice(NoticeDto notice);

}
