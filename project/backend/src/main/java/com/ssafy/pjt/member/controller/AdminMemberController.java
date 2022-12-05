package com.ssafy.pjt.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.pjt.member.dto.MemberDto;
import com.ssafy.pjt.member.model.service.MemberService;

@RestController
@RequestMapping("/admin")
@CrossOrigin("*")
public class AdminMemberController {
	
	private MemberService memberService;

	@Autowired
	public AdminMemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	@GetMapping("/user")
	public ResponseEntity<?> userList() {
		List<MemberDto> users = memberService.getUsers();
		System.out.println("여기여"+ users);

		try {
			if (users != null && !users.isEmpty()) {
				return new ResponseEntity<List<MemberDto>>(users, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	
	// 회원가입
	@PostMapping("/join")
	public ResponseEntity<?> join (@RequestBody MemberDto member) {
		int success = memberService.join(member);
		return new ResponseEntity<Integer>(success,HttpStatus.OK);
	}
	
	
	// 관리자 : 회원 수정
	@PutMapping("/edit")
	public ResponseEntity<?> editMypageInfo(@RequestBody MemberDto member, HttpSession session){
		try {
			memberService.editUserInfo(member);
			
			// 새로운 회원 정보 받아오기
			List<MemberDto> users = memberService.getUsers();
			return new ResponseEntity<List<MemberDto>>(users, HttpStatus.OK);
			
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	// 관리자 : 회원 삭제
	@DeleteMapping("/delete/{userId}")
	public ResponseEntity<?> deleteMember(@PathVariable("userId") String userId, HttpSession session){
		int success = memberService.deleteMember(userId);
		
		// 새로운 회원 정보 받아오기
		
		try {
			if (success == 1) {
				return new ResponseEntity<Void>(HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 관리자 : 회원 찾기
	
	@GetMapping("/search/{userId}")
	public ResponseEntity<?> getMypageInfo(@PathVariable("userId") String userId) {
		try {
			List<MemberDto> users = memberService.searchUsers(userId);
			if (users != null) {
				return new ResponseEntity<List<MemberDto>>(users, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		}
		catch (Exception e) {
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
}
