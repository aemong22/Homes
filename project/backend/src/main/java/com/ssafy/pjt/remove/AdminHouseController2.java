package com.ssafy.pjt.remove;
//package com.ssafy.pjt.houseinfo.controller;
//
//import java.io.IOException;
//import java.sql.SQLException;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import com.ssafy.pjt.houseinfo.HouseCombDto;
//import com.ssafy.pjt.houseinfo.model.service.HouseInfoService;
//
//@WebServlet("/adminHouse")
//public class AdminHouseController extends HttpServlet {
//	
//	private static final long serialVersionUID = 1L;
//	
//	private HouseInfoService houseInfoService;
//	
//	@Override
//	public void init() throws ServletException {
//		houseInfoService = HouseInfoService.getConcernService();
//	}
//	
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		String act = req.getParameter("act");
//
//		String path = "/index.jsp";
//		
//		if ("aptDetail".equals(act)) {
//			path = selectApt(req,resp);
//			forward(req, resp, path);
//		}
//		else if ("aptEdit".equals(act)) {
//			path = aptEdit(req,resp);
//			forward(req, resp, path);
//		}
//		else if ("aptDelete".equals(act)) {
//			path = aptDelete(req,resp);
//			forward(req, resp, path);
//		}
//	}
//
//	private String aptDelete(HttpServletRequest req, HttpServletResponse resp) {
//		HttpSession session = req.getSession();
//		HouseCombDto apt = (HouseCombDto) session.getAttribute("selectApt");
//		long no = apt.getNo();
//		try {
//			int cnt = houseInfoService.aptDelete(no);
//			if(cnt == 0) {
//				throw new SQLException();
//			}
//		}
//		catch(SQLException e) {
//			e.printStackTrace();
//			return"/error/error.jsp";
//		}
//		return "/admin_apt.jsp";
//	}
//
//	private String aptEdit(HttpServletRequest req, HttpServletResponse resp) {
//		HttpSession session = req.getSession();
//		HouseCombDto apt = (HouseCombDto) session.getAttribute("selectApt");
//		String deal = req.getParameter("deal");
//		long no = apt.getNo();
//		try {
//			int cnt = houseInfoService.aptEdit(apt.getNo(),deal);
//			if(cnt == 0) {
//				throw new SQLException();
//			}
//		}
//		catch(SQLException e) {
//			e.printStackTrace();
//			return"/error/error.jsp";
//		}
//		return "/admin_apt.jsp";
//	}
//
//
//
//	private String selectApt(HttpServletRequest req, HttpServletResponse resp) {
//		HttpSession session = req.getSession();
//		String aptno = req.getParameter("aptno");
//		try {
//			HouseCombDto apt = houseInfoService.selectApt(aptno);
//			session.setAttribute("selectApt", apt);
//			System.out.println(apt+"here");
//		}
//		catch(SQLException e) {
//			e.printStackTrace();
//			return"/error/error.jsp";
//		}
//		return "/admin_aptEdit.jsp";
//		
//	}
//
//	private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws IOException, ServletException {
//		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
//		dispatcher.forward(request, response);
//	}
//
//	private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
//		response.sendRedirect(request.getContextPath() + path);
//	}
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setCharacterEncoding("utf-8");
//		doGet(request, response);
//	}
//}
