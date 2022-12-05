package com.ssafy.pjt.houseInfo.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.pjt.houseInfo.dto.HouseCombDealDto;
import com.ssafy.pjt.houseInfo.dto.HouseCombDto;
import com.ssafy.pjt.houseInfo.dto.HouseInfoDto;

public interface HouseInfoDao {
	List<HouseCombDto> getHouseDeal(Map<String, Object> map);
	HouseCombDto selectApt(long no);
	
	// 아파트 정보 SELECT
	List<HouseInfoDto> selectHouseInfolist();
	HouseInfoDto selectHouseInfoOne(long aptCode);
	
	// 아파트 거래 히스토리 (역사) (line chart 도표용)
	List<HouseCombDealDto> getAptDealHistory(String aptCode);
	List<Map<String, Object>> getAvgDealBydealYear();
	List<Map<String, Object>> getAvgDealBydealYearConcern(List<String> list);
}
