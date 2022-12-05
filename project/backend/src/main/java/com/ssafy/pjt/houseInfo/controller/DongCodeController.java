package com.ssafy.pjt.houseInfo.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.pjt.houseInfo.model.service.DongCodeService;

@RestController
@RequestMapping("/rest/house/")
@CrossOrigin("*")
public class DongCodeController {
	
	private static final Logger logger = LoggerFactory.getLogger(DongCodeController.class);
	
	private DongCodeService dongCodeService;
	
	@Autowired
	public DongCodeController(DongCodeService dongCodeService) {
		this.dongCodeService = dongCodeService;
	}
	
	@GetMapping("/sido")
	public ResponseEntity<?> getSidoNames() {
		List<Map<String, Object>> sidoNames = dongCodeService.getSidoNames();
		
		try {
			if (sidoNames != null && !sidoNames.isEmpty()) {
				return new ResponseEntity<List<Map<String, Object>>>(sidoNames, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/gugun")
	public ResponseEntity<?> getGugunNames(@RequestParam("sidoCode") String sidoCode) {
		
		List<Map<String, Object>> gugunNames = dongCodeService.getGugunNames(sidoCode);
		
		//logger.debug("gugnNames: " + gugunNames);
		try {
			if (gugunNames != null && !gugunNames.isEmpty()) {
				return new ResponseEntity<List<Map<String, Object>>>(gugunNames, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/dong")
	public ResponseEntity<?> getDongNames(@RequestParam("gugunCode") String gugunCode) {
		
		List<Map<String, Object>> dongNames = dongCodeService.getDongNames(gugunCode);		
		try {
			if (dongNames != null && !dongNames.isEmpty()) {
				return new ResponseEntity<List<Map<String, Object>>>(dongNames, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
}
