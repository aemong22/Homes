package com.ssafy.pjt.houseInfo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.pjt.houseInfo.dto.HouseCombDealDto;
import com.ssafy.pjt.houseInfo.dto.HouseCombDto;
import com.ssafy.pjt.houseInfo.model.service.HouseInfoService;

@RestController
@RequestMapping("/houseInfo")
@CrossOrigin("*")
public class HouseInfoController {
	private static final Logger logger = LoggerFactory.getLogger(DongCodeController.class);
	
	private HouseInfoService houseInfoService;
	
	@Autowired
	public HouseInfoController(HouseInfoService houseInfoService) {
		this.houseInfoService = houseInfoService;
	}
	
	@GetMapping()
	public ResponseEntity<?> getHouseDeal(@RequestParam("code") String code, @RequestParam("year") String year,
											@RequestParam("month") String month) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("year", year);
		month = month.replaceFirst("^0+(?!$)", "");
		map.put("month", month);
		
		List<HouseCombDto> houseinfo = houseInfoService.getHouseDeal(map);
		
		logger.debug("houseinfo: "+houseinfo);
		
		try {
			if (houseinfo != null) {
				return new ResponseEntity<List<HouseCombDto>>(houseinfo, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping(value = {"/jutaek"})
	public ResponseEntity<?> getJutaek(@RequestParam("code") String code, @RequestParam("dealYM") String dealYM) throws Exception {
		
		Map<String, Object> jutaekinfo = houseInfoService.getJutaek(code, dealYM);
		
		logger.debug("jutaekinfo: "+jutaekinfo);

		try {
			if (jutaekinfo != null) {
				return new ResponseEntity<Map<String, Object>>(jutaekinfo, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping(value= {"/aptdealhistory/{aptCode}"})
	public ResponseEntity<?> getAptDealHistory(@PathVariable("aptCode") String aptCode) throws Exception {
		
		List<HouseCombDealDto> aptdealhistory = houseInfoService.getAptDealHistory(aptCode);
		
		logger.debug("AptDealHistory: "+aptdealhistory);

		try {
			if (aptdealhistory != null) {
				return new ResponseEntity<List<HouseCombDealDto>>(aptdealhistory, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping(value= {"/aptdealYear"})
	public ResponseEntity<?> getAvgDealBydealYear() throws Exception {
		
		List<Map<String, Object>> getAvgDealBydealYear = houseInfoService.getAvgDealBydealYear();
		
		logger.debug("getAvgDealBydealYear: "+getAvgDealBydealYear);

		try {
			if (getAvgDealBydealYear != null) {
				return new ResponseEntity<List<Map<String, Object>>>(getAvgDealBydealYear, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping(value= {"/aptdealYear"})
	public ResponseEntity<?> getAvgDealBydealYearConcern(@RequestBody List<String> dongCodelist) throws Exception {
		
		logger.debug("dongCodelist: "+dongCodelist);
		List<Map<String, Object>> list = houseInfoService.getAvgDealBydealYearConcern(dongCodelist);
		
		logger.debug("DealBydealYearConcern: "+list);

		try {
			if (list != null) {
				return new ResponseEntity<List<Map<String, Object>>>(list, HttpStatus.OK);
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
