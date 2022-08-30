package com.petcation.client.member.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.join.vo.MemberVO;
import com.petcation.client.member.dao.MyMemberDao;
import com.petcation.client.reservation.vo.ReservVO;
import com.petcation.client.traveldiary.vo.DiaryVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MyMemberServiceImpl implements MyMemberService{
	
	private MyMemberDao memberDao;
	
	@Override
	public MemberVO mypageMain(MemberVO mvo) {
		MemberVO member = null;
		member = memberDao.mypageMain(mvo);
		
		return member;
	}
	//��й�ȣ Ȯ�� ����
	/*
	 * @Override public int pwdCheck(MemberVO mvo) { int result = 0; result =
	 * memberDao.pwdCheck(mvo);
	 * 
	 * return result; }
	 */
	
	@Override
	public int pwdCheck(String user_pw) {
		return memberDao.pwdCheck(user_pw);
	}
	//ȸ������ ���� �� ����
	@Override
	public MemberVO updateInfoForm(MemberVO mvo) {
		MemberVO updateInfo = null;
		updateInfo = memberDao.mypageMain(mvo);
			
		return updateInfo;
	}
	
	//ȸ������ ���� ����
	@Override
	public int updateInfo(MemberVO mvo) {
		int result = 0;
		
		result = memberDao.updateInfo(mvo);
		
		return result;
	}
	@Override
	public List<ReservVO> reservList(MemberVO mvo) {
		List<ReservVO> reservList = null;
		reservList = memberDao.reservList(mvo);
		return reservList;
	}
	
	@Override
	public List<CommunityBoardVO> communityBoardList(MemberVO mvo) {
		List<CommunityBoardVO> communityBoardList = null;
		communityBoardList = memberDao.communityBoardList(mvo);
		return communityBoardList;
	}
	
	@Override
	public List<DiaryVO> diaryList(MemberVO mvo){
		List<DiaryVO> diaryList = null;
		diaryList = memberDao.diaryList(mvo);
		return diaryList;
	}

	@Override
	public List<ReservVO> checkin(MemberVO mvo) {
		List<ReservVO> checkin = null;
		checkin = memberDao.checkin(mvo);
		return checkin;
	}

	@Override
	public int reservComplete() {
		int reservComplete = memberDao.reservComplete();
		return reservComplete;
	}

	@Override
	public int memberDelete(MemberVO vo) {
		int result = memberDao.memberDelete(vo);
		return result;
	}

	@Override
	public int reservListCnt(ReservVO rvo) {
		int result = memberDao.reservListCnt(rvo);
		return result;
	}
	
	@Override
	public int diaryListCnt(DiaryVO dvo) {
		return memberDao.diaryListCnt(dvo);
	}

	@Override
	public int communityBoardListCnt(CommunityBoardVO cbvo) {
		return memberDao.communityBoardListCnt(cbvo);
	}


}
