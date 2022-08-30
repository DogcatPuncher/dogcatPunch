package com.petcation.admin.login.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcation.admin.login.dao.AdminLoginDao;
import com.petcation.admin.login.vo.AdminLoginVO;
import com.petcation.admin.member.vo.MemberVO;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.vo.QreplyVO;
import com.petcation.client.reservation.vo.ReservVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AdminLoginServiceImpl implements AdminLoginService {

	private AdminLoginDao adminLoginDao;
	
	@Override
	public AdminLoginVO loginProcess(AdminLoginVO login) {
		AdminLoginVO adminLogin = adminLoginDao.loginProcess(login);
		
		return adminLogin;
	}

	@Override
	public QreplyVO QnaList() {
		QreplyVO Qna = adminLoginDao.QnaList();
		return Qna;
	}

	@Override
	public QreplyVO Qna_Not() {
		QreplyVO Qna = adminLoginDao.QnaNot();
		return Qna;
	}
	
	@Override
	public List<NoticeVO> NoticeList(NoticeVO nvo) {
		List<NoticeVO> noticeList = null;
		noticeList = adminLoginDao.noticeList(nvo); 
		return noticeList;
	}

	@Override
	public ReservVO  reserv_cnt() {
		ReservVO reserv_cnt = adminLoginDao.reserv_cnt();
		System.out.println("당일 예약 건수 service " + reserv_cnt);
		return reserv_cnt;
	}
	
	@Override
	public ReservVO reserv_pay_cnt() {
		ReservVO reserv_pay_cnt = adminLoginDao.reserv_pay_cnt();
		System.out.println("당일 예약 금액 service " +  reserv_pay_cnt);
		return reserv_pay_cnt;
	}

	@Override
	public MemberVO memberToday() {
		MemberVO member_join_today = adminLoginDao.member_today();
		System.out.println("오늘 가입한 회원 수 : " + member_join_today);
		return member_join_today;
	}

	@Override
	public MemberVO allMember() {
		MemberVO allMember = adminLoginDao.allMember();
		System.out.println("모든 회원 수: " + allMember);
		return allMember;
	}



}
