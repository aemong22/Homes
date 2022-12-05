package com.ssafy.pjt.houseInfo.dto;

public class HouseCombDto {
	private long no;
	private long aptCode;
	private String apartmentName;
	private int buildYear;
	private String dong;
	private String jibun;
	private String dealAmount;
	private String floor;
	private String area;
	
	public String getDealAmount() {
		return dealAmount;
	}

	public void setDealAmount(String dealAmount) {
		this.dealAmount = dealAmount;
	}
	
	
	public HouseCombDto() {
		
	}
	
	public HouseCombDto(long no, long aptCode, String apartmentName, int buildYear, String dong, String jibun,
			String floor, String area, String dealAmount) {
		super();
		this.no = no;
		this.aptCode = aptCode;
		this.apartmentName = apartmentName;
		this.buildYear = buildYear;
		this.dong = dong;
		this.jibun = jibun;
		this.floor = floor;
		this.area = area;
		this.dealAmount=dealAmount;
	}
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public long getAptCode() {
		return aptCode;
	}
	public void setAptCode(long aptCode) {
		this.aptCode = aptCode;
	}
	public String getApartmentName() {
		return apartmentName;
	}
	public void setApartmentName(String apartmentName) {
		this.apartmentName = apartmentName;
	}
	public int getBuildYear() {
		return buildYear;
	}
	public void setBuildYear(int buildYear) {
		this.buildYear = buildYear;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}

	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("HouseCombDto [no=");
		builder.append(no);
		builder.append(", aptCode=");
		builder.append(aptCode);
		builder.append(", apartmentName=");
		builder.append(apartmentName);
		builder.append(", buildYear=");
		builder.append(buildYear);
		builder.append(", dong=");
		builder.append(dong);
		builder.append(", jibun=");
		builder.append(jibun);
		builder.append(", dealAmount=");
		builder.append(dealAmount);
		builder.append(", floor=");
		builder.append(floor);
		builder.append(", area=");
		builder.append(area);
		builder.append("]");
		return builder.toString();
	}
}
