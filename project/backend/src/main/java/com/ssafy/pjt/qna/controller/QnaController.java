package com.ssafy.pjt.qna.controller;

import java.util.List;


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

import com.ssafy.pjt.qna.dto.QnaDto;
import com.ssafy.pjt.qna.model.service.QnaService;

@RestController
@RequestMapping("/qna")
@CrossOrigin("*")
public class QnaController {

	private QnaService qnaService;

	@Autowired
	public QnaController(QnaService qnaService) {
		this.qnaService = qnaService;
	}

	// QnA - selectAll
	@GetMapping("/list")
	public ResponseEntity<?> qList() {
		List<QnaDto> QnaLists = qnaService.getLists();

		try {
			if (QnaLists != null && !QnaLists.isEmpty()) {
				return new ResponseEntity<List<QnaDto>>(QnaLists, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// QnA - selectAll
	@GetMapping("/count/{userId}")
	public ResponseEntity<?> qCountList(@PathVariable("userId") String userId) {
		int count = qnaService.getCountQ(userId);
		try {
			return new ResponseEntity<Integer>(count, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	

	// QnA - 등록
	@PostMapping("/write")
	public ResponseEntity<?> write(@RequestBody QnaDto qna) {
		int success = qnaService.write(qna);
		if (success == 1) {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}
		else {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 공자사항 - 수정 
	@PutMapping("/modify")
	public ResponseEntity<?> editQna(@RequestBody QnaDto qna ){
		int success = qnaService.editQna(qna);
		if(success == 1) {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}
		else {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR); 
		}
	}

	// QnA - 삭제
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<?> deleteNotice(@PathVariable("id") String id){
		int success = qnaService.deleteQna(id);

		if(success == 1) {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}
		else {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR); 
		}
	}
	
	// QnA - 검색
	@GetMapping("/search/{search}")
	public ResponseEntity<?> searchQList(@PathVariable("search") String search) {
		List<QnaDto> QnaLists = qnaService.getSearch(search);

		try {
			if (QnaLists != null && !QnaLists.isEmpty()) {
				return new ResponseEntity<List<QnaDto>>(QnaLists, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
