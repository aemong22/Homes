package com.ssafy.pjt.remove;
//package com.ssafy.pjt.houseinfo.controller;
//
//import java.io.IOException;
//import java.io.PrintWriter;
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
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.ssafy.pjt.houseinfo.HouseCombDto;
//import com.ssafy.pjt.houseinfo.model.service.HouseInfoService;
//
//
//@WebServlet("/houseInfoSort/*")
//public class HouseInfoSortController extends HttpServlet{
//	private static final long serialVersionUID = 1L;
//
//	private HouseInfoService houseInfoService;
//
//	private ObjectMapper mapper = new ObjectMapper();
//
//	@Override
//	public void init() throws ServletException {
//		houseInfoService = HouseInfoService.getConcernService();
//	}
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//
//
//		if(req.getPathInfo() == null || req.getPathInfo().equals("/")) {
//			String code = req.getParameter("code");
//			String year = req.getParameter("year");
//			String month = req.getParameter("month");
//			String sort = req.getParameter("sort");
//			String deal = req.getParameter("user_deal");
//
//
//			try {
//				List<HouseCombDto> lists= houseInfoService.getHouseInfoSort(code, year, month,sort, deal);
//
//				//응답 헤더 작성하기
//				resp.addHeader("Content-Type", "application/json; charset=UTF-8");
//
//				//응답 payload 작성
//				//1. 객체를 JSON 문자열로 직렬화
//				String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(lists);
//				//2. 직렬화 한 문자열을 응답
//				PrintWriter writer= resp.getWriter();
//				writer.write(json);
//
//			} catch (SQLException e) {
//				e.printStackTrace();
//				redirect(req, resp, "/error/error.jsp");
//			}
//			return;
//		}
//		else if(req.getPathInfo().equals("/jutaek")) {
//			String code= req.getParameter("code");
//			String dealYM = req.getParameter("dealYM");
//
//			Object obj = houseInfoService.getJutaek(code, dealYM);
//			//응답 헤더 작성하기
//			resp.addHeader("Content-Type", "application/json; charset=UTF-8");
//
//			//응답 payload 작성
//			//1. 객체를 JSON 문자열로 직렬화
//			String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);
//
//			//2. 직렬화 한 문자열을 응답
//			PrintWriter writer= resp.getWriter();
//			writer.write(json);
//		}
//
//	}
//
//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");
//		super.doPost(req, resp);
//	}
//
//	private void forward(HttpServletRequest request, HttpServletResponse response, String path)
//			throws ServletException, IOException {
//		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
//		dispatcher.forward(request, response);
//	}
//
//	private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
//		response.sendRedirect(request.getContextPath() + path);
//	}
//}
