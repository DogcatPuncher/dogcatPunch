package com.petcation.client.join.dao;


import com.petcation.client.join.vo.MemberVO;

public interface MemberDAO {
	// 회원가입
		public void memberJoin(MemberVO member);
		
	// 아이디 중복 검사
		public int idCheck(String user_id);

	// 이메일 중복 검사
		public int emailCheck(String user_email);

	// 핸드폰 번호 중복 검사
		public int phoneCheck(String user_phone);
	
	// 로그인 
		public MemberVO memberLogin(MemberVO member);
	
	//이름 아이디가 일치하는 DB 존재하는지 확인
		public MemberVO searchPhone(MemberVO member);
	
	//이름 아이디가 일치하는 DB 존재하는지 확인
	    public MemberVO searchEmail(MemberVO member);
	    
	//임시 비번 업데이트
	    public void updatePw(MemberVO member);
	    
	//네아 로그인
	    public MemberVO read(String username);
	    
	//네이버로 연동된 회원정보 찾기 =>[가입된 이메일] 또는 [네이버 고유번호id]를 조회하여 비교    
	    public MemberVO naverChk(MemberVO member);
		
	//2-1 가입된 계정에 네이버 연동 진행
	    public void updateN(MemberVO member);
}
