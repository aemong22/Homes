package com.ssafy.pjt.concern.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.pjt.concern.dto.ConcernDto;
import com.ssafy.pjt.concern.model.service.ConcernService;
import com.ssafy.pjt.houseInfo.controller.DongCodeController;
import com.ssafy.pjt.houseInfo.dto.HouseCombDto;
import com.ssafy.pjt.member.dto.MemberDto;

@RestController
@RequestMapping("/concern")
@CrossOrigin("*")
public class ConcernController {
	private static final Logger logger = LoggerFactory.getLogger(DongCodeController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	private ConcernService concernService;

	@Autowired
	public ConcernController(ConcernService concernService) {
		this.concernService = concernService;
	}

	// 관심지역 등록 확인
	@GetMapping("/ckConcern/{userId}/{dongCode}")
	public ResponseEntity<?> ckConcern(@PathVariable("userId") String userId,
			@PathVariable("dongCode") String dongCode) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("dongCode", dongCode);
		logger.debug("ckConcern: map ", map);

		boolean isConcern = concernService.ckConcern(map);

		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		if (isConcern)
			resultMap.put("message", SUCCESS);
		else
			resultMap.put("message", FAIL);
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

	// 관심지역 등록
	@PostMapping()
	public ResponseEntity<?> registerConcern(@RequestBody Map<String, Object> map) {
		logger.debug("registerConcern map : {}", map);
		boolean isInsert = concernService.register(map);

		try {
			if (isInsert) {
				return new ResponseEntity<Void>(HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 관심지역 삭제
	@DeleteMapping("/{userId}/{dongCode}")
	public ResponseEntity<?> deleteConcern(@PathVariable("userId") String userId,
			@PathVariable("dongCode") String dongCode) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("dongCode", dongCode);
		logger.debug("ckConcern: map ", map);
		logger.debug("deleteConcern map : {}", map);
		boolean isDelete = concernService.deleteConcern(map);

		try {
			if (isDelete) {
				return new ResponseEntity<Void>(HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 관심지역 목록 가져오기
	@GetMapping("/{userId}")
	public ResponseEntity<?> getConcernList(@PathVariable("userId") String userId) {

		logger.debug("getConcernList: userId ", userId);

		List<ConcernDto> concernlist = concernService.getlist(userId);
		logger.debug("concernlist: " + concernlist);

		try {
			if (concernlist != null) {
				return new ResponseEntity<List<ConcernDto>>(concernlist, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 관심목록 개수 가져오기
	@GetMapping("/count/{userId}")
	public ResponseEntity<?> getConcernListCount(@PathVariable("userId") String userId) {

		logger.debug("getConcernList: userId ", userId);

		int count = concernService.countlist(userId);

		try {
			return new ResponseEntity<Integer>(count, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
