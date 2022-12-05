package com.ssafy.pjt.notice.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.pjt.notice.dto.NoticeDto;
import com.ssafy.pjt.notice.model.mapper.NoticeDao;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	private final NoticeDao noticeDao;
	
	@Autowired
	public NoticeServiceImpl(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}

	@Override
	public List<NoticeDto> getNotices() {
		return noticeDao.selectAll();
	}

	@Override
	public int write(NoticeDto notice) {
		return noticeDao.insert(notice);
	}

	@Override
	public int deleteNotice(String id) {
		return noticeDao.delete(id);
	}

	@Override
	public int editNotice(NoticeDto notice) {
		return noticeDao.update(notice);
	}

}
