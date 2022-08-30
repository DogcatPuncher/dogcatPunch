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
	
	//���̵� �ߺ��˻�
	@Override
	public int idCheck(String user_id) throws Exception {
		
		return dao.idCheck(user_id);
	}
	
	// �̸��� �ߺ� �˻�
	@Override
	public int emailCheck(String user_email) throws Exception {
		return dao.emailCheck(user_email);
	}
	
	// �ڵ�����ȣ �ߺ� �˻�
	@Override
	public int phoneCheck(String user_phone) throws Exception {
		return dao.phoneCheck(user_phone);
	}
	
	// �α��� 
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        
        return dao.memberLogin(member);
    }
    
    //�̸� �ڵ��� ��ȣ�� ��ġ�ϴ� DB �����ϴ��� Ȯ��
    @Override
    public MemberVO searchPhone(MemberVO member) throws Exception {
    	return dao.searchPhone(member);
    }

    //�̸� ���̵� ��ġ�ϴ� DB �����ϴ��� Ȯ��
    @Override
    public MemberVO searchEmail(MemberVO member) throws Exception {
    	return dao.searchEmail(member);
    }
    
    //�ӽ� ��� ������Ʈ
    @Override
    public void updatePw(MemberVO member) throws Exception {
    	dao.updatePw(member);
    }
    
    //���̹��� ������ ȸ������ ã�� =>[���Ե� �̸���] �Ǵ� [���̹� ������ȣid]�� ��ȸ�Ͽ� ��
    @Override
    public MemberVO naverChk(MemberVO member) throws Exception{
    	return dao.naverChk(member);
    }
    
    //2-1 ���Ե� ������ ���̹� ���� ����
    @Override
    public void updateN(MemberVO member) throws Exception {
    	dao.updateN(member);
    }
    
}