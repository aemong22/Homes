package com.ssafy.pjt.remove;
//package com.ssafy.pjt.notice.controller;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.ssafy.pjt.notice.model.NoticeDto;
//import com.ssafy.pjt.notice.model.service.NoticeService;
//
//@WebServlet("/notice")
//public class NoticeController extends HttpServlet{
//	private static final long serialVersionUID = 1L;
//
//	private NoticeService noticeService;
//	
//	@Override
//	public void init() throws ServletException {
//		noticeService = NoticeService.getNoticeService();
//	}
//	
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		//공지글 조회. 다 처리해야함
//		List<NoticeDto> notices;
//		String act = req.getParameter("act");
//		if(act == null ) {
//			try {
//				notices = noticeService.getlist();
//				req.setAttribute("notices", notices);
//				
//				forward(req, resp, "/notice.jsp");
//				
//			} catch (SQLException e) {
//				e.printStackTrace();
//				redirect(req,resp,"/error/error.jsp");
//			}
//		}
//		//삭제
//		else if(act.equals("delete")) {
//			String noticeNo = req.getParameter("noticeNo");
//			
//			try {
//				noticeService.delete(noticeNo);
//				redirect(req,resp,"/notice");
//			} catch (SQLException e) {
//				e.printStackTrace();
//				redirect(req,resp,"/error/error.jsp");
//			} 
//		}
//		else if(act.equals("search")) {
//			String word = req.getParameter("word");
//			
//			try {
//				//KMP 알고리즘
//				notices=noticeService.search(word);
//				req.setAttribute("search", word);
//				req.setAttribute("notices", notices);
//				
//				forward(req, resp, "/notice.jsp");
//			} catch (SQLException e) {
//				e.printStackTrace();
//				redirect(req,resp,"/error/error.jsp");
//			}
//			
//		}
//		else if(act.equals("modify")) {
//			String noticeNo = req.getParameter("noticeNo");
//			NoticeDto noticeDto;
//			try {
//				noticeDto = noticeService.getNotice(noticeNo);
//				
//				//notice가 null이면 에러
//				if(noticeDto==null) {
//					throw new SQLException();
//				}
//				req.setAttribute("notice", noticeDto);
//				forward(req,resp, "/notice_modify.jsp");
//			} catch (SQLException e) {
//				e.printStackTrace();
//				redirect(req,resp,"/error/error.jsp");
//			}
//			
//		}
//		//다른 act가 들어오면 notice로 redirect
//		else {
//			redirect(req,resp,"/notice");
//		}
//	}
//	
//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		req.setCharacterEncoding("utf-8");
//		
//		String act = req.getParameter("act");
//		
//		if(act.equals("post")) {
//			String userId = req.getParameter("userId");
//			String subject = req.getParameter("subject");
//			String content = req.getParameter("content");
//
//			NoticeDto noticeDto = new NoticeDto();
//			noticeDto.setUserId(userId);
//			noticeDto.setSubject(subject);
//			noticeDto.setContent(content);
//			
//			try {
//				noticeService.write(noticeDto);
//				
//				redirect(req, resp, "/notice");
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//				//req.setAttribute("msg","글 작성 중 에러가 발생했습니다.");
//				redirect(req,resp,"/error/error.jsp");
//			}
//			
//		}
//		
//		else if(act.equals("put")) {
//			//수정
//			String noticeNo = req.getParameter("noticeNo");
//			String subject = req.getParameter("subject");
//			String content = req.getParameter("content");
//
//			NoticeDto noticeDto = new NoticeDto();
//			noticeDto.setNoticeNo(Integer.parseInt(noticeNo));
//			noticeDto.setSubject(subject);
//			noticeDto.setContent(content);
//			
//			try {
//				noticeService.modify(noticeDto);
//				
//				redirect(req, resp, "/notice");
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//				redirect(req,resp,"/error/error.jsp");
//			}
//		}
//		else redirect(req,resp,"/notice");
//		
//	}
//	
//	private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
//		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
//		dispatcher.forward(request, response);
//	}
//	
//	private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
//		response.sendRedirect(request.getContextPath() + path);
//	}
//}
