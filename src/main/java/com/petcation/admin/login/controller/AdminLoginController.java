package com.petcation.admin.login.controller;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petcation.admin.login.service.AdminLoginService;
import com.petcation.admin.login.vo.AdminLoginVO;
import com.petcation.admin.member.vo.MemberVO;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.vo.QreplyVO;
import com.petcation.client.reservation.vo.ReservVO;

import lombok.AllArgsConstructor;

@Controller
/* @SessionAttributes 占식띰옙占쏙옙庫占� 占쏙옙占쏙옙占쏙옙 占싱몌옙占쏙옙 占쏙옙占쏙옙 占싱몌옙占쏙옙
 * @ModelAttribute占쏙옙 占쏙옙占쏙옙占실억옙 占쏙옙占쏙옙 占쏙옙占� 占쌨쇽옙占썲가 占쏙옙환占실댐옙 占쏙옙占쏙옙 占쏙옙占실울옙 占쏙옙占쏙옙홱占�.*/
@SessionAttributes("adminLogin")
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminLoginController {
	
	private AdminLoginService adminLoginService;
	
	@ModelAttribute
	public AdminLoginVO adminLogin() {
		return new AdminLoginVO();
	}
	
	@GetMapping("/main")
	public String loginForm() {
		
		return "admin/main";
	}
	
	@RequestMapping("/login")
	public String loginProcess(AdminLoginVO login, QnaVO qvo, NoticeVO nvo, Model model, RedirectAttributes ras) {
		String url = "";
		AdminLoginVO adminLogin = adminLoginService.loginProcess(login);
		
		if(adminLogin != null) {
			model.addAttribute("adminLogin", adminLogin);
			url = "/admin/mainPage";
 		}else {
 			ras.addFlashAttribute("errorMsg", "로그인 실패");
 			url = "/admin/main";
 		}
		
		
		return "redirect:"+url;
	}
	
	@RequestMapping("/mainPage")	
	public String mainPage(AdminLoginVO adminLogin, QnaVO qvo, NoticeVO nvo, Model model, RedirectAttributes ras) {	
		String url = "";
		System.out.println(adminLogin.getA_name());
		
		if(adminLogin != null) {
			model.addAttribute("adminLogin", adminLogin);
			System.out.println("관리자 메인페이지 호출 성공");
			
			QreplyVO qna_comple = adminLoginService.QnaList();
			model.addAttribute("qna_comple",qna_comple);
			
			System.out.println("오늘 답변한 qna" + qna_comple);
			
			QreplyVO qna_notcomple = adminLoginService.Qna_Not();
			model.addAttribute("qna_notcomple",qna_notcomple);
			
			ReservVO reserv_cnt = adminLoginService.reserv_cnt();
			model.addAttribute("reserv_cnt",reserv_cnt);
			
			ReservVO reserv_pay_cnt = adminLoginService.reserv_pay_cnt();
			model.addAttribute("reserv_pay_cnt", reserv_pay_cnt);
			
			System.out.println("당일 예약 건수 컨트롤러 : " + reserv_cnt);
			System.out.println("당일 예약 금액 컨트롤러 : " + reserv_pay_cnt);
			
			MemberVO member_join_today = adminLoginService.memberToday();
			model.addAttribute("member_join_today",member_join_today);
			
			MemberVO member = adminLoginService.allMember(); 
			model.addAttribute("allMember",member);
			
			System.out.println("오늘 가입한 이용자 수 : " + member_join_today);
			System.out.println("모든 회원 수 : " + member);
			
			System.out.println("답변 해야할 qna" + qna_notcomple);
			
			
			
			// 공지사항
			List<NoticeVO> noticeList = adminLoginService.NoticeList(nvo);
			model.addAttribute("noticeList",noticeList);
			
			System.out.println("관리자 공지사항 " + noticeList);
			
			url = "admin/mainLayout";
		}else {
			ras.addFlashAttribute("errorMsg", "아이디, 비밀번호를 확인해주세요");
			url = "/admin/main";
		}
		return url;  
	}
	
	
	@RequestMapping("/logout")
	public String logout(SessionStatus sessionStatus) {
		sessionStatus.setComplete();
		return "redirect:/admin/main";
	}
}
