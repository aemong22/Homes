package com.ssafy.pjt.concern.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.pjt.concern.dto.ConcernDto;
import com.ssafy.pjt.concern.model.mapper.ConcernDao;
import com.ssafy.pjt.houseInfo.model.service.HashTable;
@Service
public class ConcernServiceImpl implements ConcernService{
	
	private ConcernDao concernDao;
	private HashTable hashTable;
	
	@Autowired
	public ConcernServiceImpl(ConcernDao concernDao) {
		this.concernDao = concernDao;
		
		hashTable = new HashTable();
		hashTable.put("대형마트","MT1");
		hashTable.put("편의점", "CS2");
		hashTable.put("유치원", "PS3");
		hashTable.put("학교", "SC4");
		hashTable.put("학원", "AC5");
		hashTable.put("주차장", "PK6");
		hashTable.put("주유소", "OL7");
		hashTable.put("지하철역", "SW8");
		hashTable.put("은행", "BK9");
		hashTable.put("문화시설", "CT1");
		hashTable.put("중개업소", "AG2");
		hashTable.put("공공기관", "PO3");
		hashTable.put("관광명소", "AT4");
		hashTable.put("숙박", "AD5");
		hashTable.put("음식점", "FD6");
		hashTable.put("카페", "CE7");
		hashTable.put("병원", "HP8");
		hashTable.put("약국", "PM9");
	}

	@Override
	public boolean register(Map<String, Object> map) {
		return concernDao.register(map) == 1;
	}

	@Override
	public List<ConcernDto> getlist(String userId) {
		return concernDao.getlist(userId);
	}

	@Override
	public int countlist(String userId) {
		return concernDao.countlist(userId);
	}

	@Override
	public int deleteAll(String userId) {
		return concernDao.deleteAll(userId);
	}

	@Override
	public int countlistAll() {
		return concernDao.countlistAll();
	}
	
	@Override
	public String hashShop(String name) {
		System.out.println((String) hashTable.get(name));
		return (String) hashTable.get(name);
	}

	@Override
	public boolean ckConcern(Map<String, Object> map) {
		return concernDao.ckConcern(map) == 1;
	}

	@Override
	public boolean deleteConcern(Map<String, Object> map) {
		return concernDao.deleteConcern(map) == 1;
	}


}
