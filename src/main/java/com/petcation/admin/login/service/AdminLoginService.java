package com.petcation.admin.login.service;


import java.util.List;

import com.petcation.admin.login.vo.AdminLoginVO;
import com.petcation.admin.member.vo.MemberVO;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.vo.QreplyVO;
import com.petcation.client.reservation.vo.ReservVO;

public interface AdminLoginService {
	public AdminLoginVO loginProcess(AdminLoginVO login);

	public QreplyVO QnaList();

	public List<NoticeVO> NoticeList(NoticeVO nvo);

	public QreplyVO Qna_Not();

	public ReservVO reserv_cnt();
	
	public ReservVO reserv_pay_cnt();

	public MemberVO memberToday();

	public MemberVO allMember();
}
