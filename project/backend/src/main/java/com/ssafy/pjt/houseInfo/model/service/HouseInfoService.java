package com.ssafy.pjt.houseInfo.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.pjt.houseInfo.dto.HouseCombDealDto;
import com.ssafy.pjt.houseInfo.dto.HouseCombDto;
import com.ssafy.pjt.houseInfo.dto.HouseInfoDto;

public interface HouseInfoService {
	Map<String, Object> getJutaek(String code, String dealYM) throws Exception;
	List<HouseCombDto> getHouseDeal(Map<String, Object> map);
	HouseCombDto selectApt(long no);

	List<HouseInfoDto> selectHouseInfolist();
	HouseInfoDto selectHouseInfoOne(long aptCode);

	List<HouseCombDealDto> getAptDealHistory(String aptCode);
	List<Map<String, Object>> getAvgDealBydealYear();
	List<Map<String, Object>> getAvgDealBydealYearConcern(List<String> list);
}
