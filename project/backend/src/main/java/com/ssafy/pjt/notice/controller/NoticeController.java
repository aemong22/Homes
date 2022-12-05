package com.ssafy.pjt.notice.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.pjt.member.dto.MemberDto;
import com.ssafy.pjt.notice.dto.NoticeDto;
import com.ssafy.pjt.notice.model.service.NoticeService;

@RestController
@RequestMapping("/notice")
@CrossOrigin("*")
public class NoticeController {

	private NoticeService noticeService;

	@Autowired
	public NoticeController(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	// 공지 사항 - selectAll
	@GetMapping("/list")
	public ResponseEntity<?> noticeList() {
		List<NoticeDto> notices = noticeService.getNotices();

		try {
			if (notices != null && !notices.isEmpty()) {
				return new ResponseEntity<List<NoticeDto>>(notices, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 공지사항 - 추가
	@PostMapping("/write")
	public ResponseEntity<?> write(@RequestBody NoticeDto notice) {
		int success = noticeService.write(notice);
		List<NoticeDto> notices = noticeService.getNotices();
		try {
			if (notices != null && !notices.isEmpty()) {
				return new ResponseEntity<List<NoticeDto>>(notices, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}
	
	// 공자사항 - 수정 페이지 이동
	@GetMapping("/edit/{id}")
	public ModelAndView showNoticeEditPage() {
		ModelAndView mav = new ModelAndView("notice_modify");
		return mav;
	}
	
	// 공자사항 - 수정 
	@PutMapping("/edit")
	public ResponseEntity<?> editMypageInfo(@RequestBody NoticeDto notice ){
			noticeService.editNotice(notice);
			return new ResponseEntity<Void>(HttpStatus.OK);
	}

	// 공지사항 - 삭제
	@DeleteMapping("/remove/{id}")
	public ResponseEntity<?> deleteNotice(@PathVariable("id") String id){
		noticeService.deleteNotice(id);
		List<NoticeDto> notices = noticeService.getNotices();

		try {
			if (notices != null && !notices.isEmpty()) {
				return new ResponseEntity<List<NoticeDto>>(notices, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
}
