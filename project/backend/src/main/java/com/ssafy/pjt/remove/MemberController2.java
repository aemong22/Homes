package com.ssafy.pjt.remove;
//package com.ssafy.pjt.member.controller;
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
//import javax.servlet.http.HttpSession;
//
//import com.ssafy.pjt.member.MemberDto;
//import com.ssafy.pjt.member.model.service.MemberService2;
//
//@WebServlet("/user")
//public class MemberController2 extends HttpServlet {
//
//	private static final long serialVersionUID = 1L;
//
//	private MemberService2 memberService = new MemberService2();
//
//
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String act = request.getParameter("act");
//
//		String path = "/index.jsp";
//		if ("mvjoin".equals(act)) { 완료
//			path = "/user/join.jsp";
//			redirect(request, response, path);
//		}
//		else if ("idcheck".equals(act)) { 완료
//			int cnt = idCheck(request, response);
//			response.setContentType("text/plain; charset=utf-8");
//			PrintWriter out = response.getWriter();
//			out.println(cnt);
//		}
//		else if ("join".equals(act)) { 완료
//			path = join(request, response);
//			forward(request, response, path);
//		}
//		else if ("mvlogin".equals(act)) { 완료
//			path = "/user/login.jsp";
//			redirect(request, response, path);
//		}
//		else if ("login".equals(act)) { 완료
//			path = login(request, response);
//			forward(request, response, path);
//		}
//		else if ("logout".equals(act)) { 완료
//			path = logout(request, response);
//			forward(request, response, path);
//		}
//		else if  ("mypage".equals(act)) { 완료
//			path = mypage(request, response);
//			forward(request, response, path);
//		}
//		else if ("resign".equals(act)) { 완료
//			path = resign(request,response);
//			forward(request, response, path);
//		}
//		else if("profileEdit".equals(act)) { 완료
//			path = edit(request, response);
//			forward(request, response, path);
//		}
//		else if("member-management".equals(act)) {
//			path = mm(request,response);
//			forward(request,response,path);
//		}
//		else if("m-delete".equals(act)) {
//			path = memberDelete(request,response);
//			forward(request,response,path);
//		}
//		else if("m-add".equals(act)) {
//			path = "/user/admin_join.jsp";
//			redirect(request, response, path);
//		}
//		else if("m-modify".equals(act)) {
//			path = memberSelect(request,response);
//			forward(request, response, path);
//		}
//		else if("add-member".equals(act)) {
//			path = memberAdd(request,response);
//			forward(request,response,path);
//		}
//		else if("memberEdit".equals(act)) {
//			path = memberEdit(request,response);
//			forward(request,response,path);
//		}
//		else {
//			redirect(request, response, path);
//		}
//
//	}
//
//
//	private String memberEdit(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		MemberDto temp = (MemberDto) session.getAttribute("selectMember");
//
//		MemberDto memberDto = new MemberDto();
//		memberDto.setUserId(temp.getUserId());
//		memberDto.setUserName(request.getParameter("name"));
//		memberDto.setUserPwd(request.getParameter("password"));
//		memberDto.setEmailId(request.getParameter("emailid"));
//		memberDto.setEmailDomain(request.getParameter("emaildomain"));
//		memberDto.setPhonenumber(request.getParameter("phone"));
//		memberDto.setAddress(request.getParameter("address"));
//
//		try {
//			memberService.editProfile(memberDto);
//			mm(request,response);
//			session.removeAttribute("selectMember");
//			return "/user/member_management.jsp";
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "회원 가입 처리중 에러 발생!!!");
//			return "/error/error.jsp";
//		}
//	}
//
//
//	private String memberSelect(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		String selectMember = request.getParameter("userId");
//		try {
//			MemberDto select= memberService.mypage(selectMember);
//			session.setAttribute("selectMember", select);
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//			return "/error/error.jsp";
//		}
//		return "/user/admin_edit.jsp";
//	}
//
//
//	// 관리자 -> 회원 추가
//	private String memberAdd(HttpServletRequest request, HttpServletResponse response) {
//		MemberDto addMember = new MemberDto();
//		addMember.setUserId(request.getParameter("id"));
//		addMember.setUserName(request.getParameter("name"));
//		addMember.setUserPwd(request.getParameter("password"));
//		addMember.setEmailId(request.getParameter("emailid"));
//		addMember.setEmailDomain(request.getParameter("emaildomain"));
//		addMember.setPhonenumber(request.getParameter("phone"));
//		addMember.setAddress(request.getParameter("address"));
//
//		try {
//			memberService.joinMember(addMember);
//			System.out.println("가입완료");
//			mm(request,response);
//			return "/user/member_management.jsp";
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "회원 가입 처리중 에러 발생!!!");
//			return "/error/error.jsp";
//		}
//	}
//
//
//	// 관리자 -> 회원 탈퇴
//	private String memberDelete(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		String deleteUserId = request.getParameter("userId");
//		
//		try {
//			memberService.delete(deleteUserId);
//			mm(request,response);
//			
//		}
//		catch(SQLException e) {
//			e.printStackTrace();
//			return "/error/error.jsp";
//		}
//		return "/user/member_management.jsp";
//	}
//	
//	// mm : member management , 관리자 -> 회원 관리 페이지 -> 회원 list 뽑아오기
//	private String mm(HttpServletRequest request, HttpServletResponse response) {
//		List<MemberDto> members;
//		
//		try {
//			members = memberService.getlist();
//			request.setAttribute("members", members);
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//			return "/error/error.jsp";
//		}
//		return "/user/member_management.jsp";
//	}
//
//
//	private String edit(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		MemberDto id = (MemberDto) session.getAttribute("userinfo");
//		MemberDto memberDto = new MemberDto();
//		memberDto.setUserId(id.getUserId());
//		memberDto.setUserName(request.getParameter("name"));
//		memberDto.setUserPwd(request.getParameter("password"));
//		memberDto.setEmailId(request.getParameter("emailid"));
//		memberDto.setEmailDomain(request.getParameter("emaildomain"));
//		memberDto.setPhonenumber(request.getParameter("phone"));
//		memberDto.setAddress(request.getParameter("address"));
//		
//		try {
//			memberService.editProfile(memberDto);
//			memberDto = memberService.loginMember(memberDto.getUserId(),memberDto.getUserPwd());
//			session.setAttribute("userinfo", memberDto);
//			return "/index.jsp";
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "회원 가입 처리중 에러 발생!!!");
//			return "/error/error.jsp";
//		}
//
//	}
//
//
//
//	private String resign(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
//		try {
//			memberService.delete(memberDto.getUserId());
//			session.removeAttribute("userinfo");
//		}
//		catch(SQLException e) {
//			e.printStackTrace();
//			return "/error/error.jsp";
//		}
//		return "/index.jsp";
//	}
//
//
//
//	private String mypage(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
//		try {
//			MemberDto current = memberService.mypage(memberDto.getUserId());
//			request.setAttribute("profile", current);
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//			return "/error/error.jsp";
//		}
//		return "/user/profile.jsp";
//	}
//
//
//
//	private String logout(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		session.removeAttribute("userinfo");
//		//session.invalidate();
//		return "/index.jsp";
//	}
//
//	private String login(HttpServletRequest request, HttpServletResponse response) {
//		String userId = request.getParameter("userId");
//		String userPwd = request.getParameter("userPassword");
//		try {
//			MemberDto memberDto = memberService.loginMember(userId, userPwd);
//
//			if (memberDto != null) {  // 로그인 성공 (id, pwd 일치!!!)
//				HttpSession session = request.getSession();
//				
//				session.setAttribute("userinfo", memberDto);
//				return "/index.jsp";
//			}
//			else {  // 로그인 실패 (id, pwd 불일치!!!)
//				request.setAttribute("msg", "아이디 또는 비밀번호 확인 후 다시 로그인!");
//				return "/user/login.jsp";
//			}
//		}
//		catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "로그인 처리중 에러 발생!!!");
//			return "/error/error.jsp";
//		}
//		
//	}
//
//	private int idCheck(HttpServletRequest request, HttpServletResponse response) {
//		String userId = request.getParameter("userid");
//		try {
//			int count = memberService.idCheck(userId);
//			return count;
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return 500;
//	}
//
//
//	private String join(HttpServletRequest request, HttpServletResponse response) {
//		MemberDto memberDto = new MemberDto();
//		memberDto.setUserId(request.getParameter("id"));
//		memberDto.setUserName(request.getParameter("name"));
//		memberDto.setUserPwd(request.getParameter("password"));
//		memberDto.setEmailId(request.getParameter("emailid"));
//		memberDto.setEmailDomain(request.getParameter("emaildomain"));
//		memberDto.setPhonenumber(request.getParameter("phone"));
//		memberDto.setAddress(request.getParameter("address"));
//
//		try {
//			memberService.joinMember(memberDto);
//			System.out.println("가입완료");
//			return "/user?act=mvlogin";
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "회원 가입 처리중 에러 발생!!!");
//			return "/error/error.jsp";
//		}
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
//
//
//}
