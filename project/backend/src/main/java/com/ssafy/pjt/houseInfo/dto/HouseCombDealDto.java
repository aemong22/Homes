package com.ssafy.pjt.houseInfo.dto;

public class HouseCombDealDto extends HouseCombDto{
	String dealYear;
	String dealMonth;
	String dealDay;
	
	public HouseCombDealDto() {	}

	public HouseCombDealDto(String dealYear, String dealMonth, String dealDay) {
		super();
		this.dealYear = dealYear;
		this.dealMonth = dealMonth;
		this.dealDay = dealDay;
	}

	public String getDealYear() {
		return dealYear;
	}

	public void setDealYear(String dealYear) {
		this.dealYear = dealYear;
	}

	public String getDealMonth() {
		return dealMonth;
	}

	public void setDealMonth(String dealMonth) {
		this.dealMonth = dealMonth;
	}

	public String getDealDay() {
		return dealDay;
	}

	public void setDealDay(String dealDay) {
		this.dealDay = dealDay;
	}
}
