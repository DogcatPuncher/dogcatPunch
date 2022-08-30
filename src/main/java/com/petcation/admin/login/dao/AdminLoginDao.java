package com.petcation.admin.login.dao;

import java.util.List;

import com.petcation.admin.login.vo.AdminLoginVO;
import com.petcation.admin.member.vo.MemberVO;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.client.qnareply.vo.QreplyVO;
import com.petcation.client.reservation.vo.ReservVO;

public interface AdminLoginDao {
	public AdminLoginVO loginProcess(AdminLoginVO login);

	public QreplyVO QnaList();

	public List<NoticeVO> noticeList(NoticeVO nvo);

	public QreplyVO QnaNot();

	public ReservVO reserv_cnt();
	
	public ReservVO reserv_pay_cnt();

	public MemberVO allMember();

	public MemberVO member_today();
}

