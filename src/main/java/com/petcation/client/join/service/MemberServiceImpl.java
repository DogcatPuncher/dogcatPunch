package com.petcation.client.join.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.join.dao.MemberDAO;
import com.petcation.client.join.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDAO dao;

	@Override
	public void memberJoin(MemberVO member) throws Exception {
		
		dao.memberJoin(member);
		
	}
	
	//아이디 중복검사
	@Override
	public int idCheck(String user_id) throws Exception {
		
		return dao.idCheck(user_id);
	}
	
	// 이메일 중복 검사
	@Override
	public int emailCheck(String user_email) throws Exception {
		return dao.emailCheck(user_email);
	}
	
	// 핸드폰번호 중복 검사
	@Override
	public int phoneCheck(String user_phone) throws Exception {
		return dao.phoneCheck(user_phone);
	}
	
	// 로그인 
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        
        return dao.memberLogin(member);
    }
    
    //이름 핸드폰 번호가 일치하는 DB 존재하는지 확인
    @Override
    public MemberVO searchPhone(MemberVO member) throws Exception {
    	return dao.searchPhone(member);
    }

    //이름 아이디가 일치하는 DB 존재하는지 확인
    @Override
    public MemberVO searchEmail(MemberVO member) throws Exception {
    	return dao.searchEmail(member);
    }
    
    //임시 비번 업데이트
    @Override
    public void updatePw(MemberVO member) throws Exception {
    	dao.updatePw(member);
    }
    
    //네이버로 연동된 회원정보 찾기 =>[가입된 이메일] 또는 [네이버 고유번호id]를 조회하여 비교
    @Override
    public MemberVO naverChk(MemberVO member) throws Exception{
    	return dao.naverChk(member);
    }
    
    //2-1 가입된 계정에 네이버 연동 진행
    @Override
    public void updateN(MemberVO member) throws Exception {
    	dao.updateN(member);
    }
    
}