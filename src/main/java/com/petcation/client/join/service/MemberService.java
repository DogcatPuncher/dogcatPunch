package com.petcation.client.join.service;

import com.petcation.client.join.vo.MemberVO;


public interface MemberService {

	//회원가입
	public void memberJoin(MemberVO member) throws Exception;
	
	// 아이디 중복 검사
	public int idCheck(String user_id) throws Exception;

	// 이메일 중복 검사
	public int emailCheck(String user_email) throws Exception;

	// 핸드폰번호 중복 검사
	public int phoneCheck(String user_phone) throws Exception;
	
    // 로그인 
    public MemberVO memberLogin(MemberVO member) throws Exception;

    //이름 아이디가 일치하는 DB 존재하는지 확인
    public MemberVO searchEmail(MemberVO member) throws Exception;

    //이름 핸드폰번호가 일치하는 DB 존재하는지 확인
    public MemberVO searchPhone(MemberVO member) throws Exception;
    
    //임시 비번 업데이트
    public void updatePw(MemberVO member) throws Exception;
    
    //네이버로 연동된 회원정보 찾기 =>[가입된 이메일] 또는 [네이버 고유번호id]를 조회하여 비교
    public MemberVO naverChk(MemberVO member) throws Exception;
    
    //2-1 가입된 계정에 네이버 연동 진행
    public void updateN(MemberVO member) throws Exception;
}
