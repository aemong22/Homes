package com.ssafy.pjt.qna.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "CommentDto : 도서 상세정보에 작성하는 도서평에 대한 글정보")

public class Comment {

	@ApiModelProperty(value = "글번호")
	private int commentNo;
	@ApiModelProperty(value = "작성자아이디")
	private String userId;
	@ApiModelProperty(value = "도서평")
	private String comment;
	@ApiModelProperty(value = "작성시각")
	private String commentTime;
	@ApiModelProperty(value = "책고유번호", example = "111-111-1111")
	private int qnaNo;

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}


	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getCommentTime() {
		return commentTime;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}



	public void setCommentTime(String commentTime) {
		this.commentTime = commentTime;
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Comment [commentNo=");
		builder.append(commentNo);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", comment=");
		builder.append(comment);
		builder.append(", commentTime=");
		builder.append(commentTime);
		builder.append(", qnaNo=");
		builder.append(qnaNo);
		builder.append("]");
		return builder.toString();
	}
	






}
