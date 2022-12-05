package com.ssafy.pjt.houseInfo.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.pjt.houseInfo.model.mapper.DongCodeDao;

@Service
public class DongCodeServiceImpl implements DongCodeService{

	private DongCodeDao dongCodeDao;

	@Autowired
	public DongCodeServiceImpl(DongCodeDao dongCodeDao) {
		this.dongCodeDao = dongCodeDao;
	}

	@Override
	public List<Map<String, Object>> getSidoNames() {
		return dongCodeDao.getSidoNames();
	}

	@Override
	public List<Map<String, Object>> getGugunNames(String sidoCode) {
		sidoCode = sidoCode.substring(0,2);
		return dongCodeDao.getGugunNames(sidoCode);
	}

	@Override
	public List<Map<String, Object>> getDongNames(String gugunCode) {
		gugunCode = gugunCode.substring(0, 5);
		return dongCodeDao.getDongNames(gugunCode);
	}

}
