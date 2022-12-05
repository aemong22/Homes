package com.ssafy.pjt.qna.dto;

public class QnaDto {
	private int QnaNo;
	private String userId;
	private String subject;
	private String content;
	
	public QnaDto() {}

	public int getQnaNo() {
		return QnaNo;
	}

	public void setQnaNo(int qnaNo) {
		QnaNo = qnaNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "QnaDto [QnaNo=" + QnaNo + ", userId=" + userId + ", subject=" + subject + ", content=" + content
				+ ", registerTime=" + "]";
	};
	
	
	
	
}
