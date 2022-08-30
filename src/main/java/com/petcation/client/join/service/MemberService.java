package com.petcation.client.join.service;

import com.petcation.client.join.vo.MemberVO;


public interface MemberService {

	//ȸ������
	public void memberJoin(MemberVO member) throws Exception;
	
	// ���̵� �ߺ� �˻�
	public int idCheck(String user_id) throws Exception;

	// �̸��� �ߺ� �˻�
	public int emailCheck(String user_email) throws Exception;

	// �ڵ�����ȣ �ߺ� �˻�
	public int phoneCheck(String user_phone) throws Exception;
	
    // �α��� 
    public MemberVO memberLogin(MemberVO member) throws Exception;

    //�̸� ���̵� ��ġ�ϴ� DB �����ϴ��� Ȯ��
    public MemberVO searchEmail(MemberVO member) throws Exception;

    //�̸� �ڵ�����ȣ�� ��ġ�ϴ� DB �����ϴ��� Ȯ��
    public MemberVO searchPhone(MemberVO member) throws Exception;
    
    //�ӽ� ��� ������Ʈ
    public void updatePw(MemberVO member) throws Exception;
    
    //���̹��� ������ ȸ������ ã�� =>[���Ե� �̸���] �Ǵ� [���̹� ������ȣid]�� ��ȸ�Ͽ� ��
    public MemberVO naverChk(MemberVO member) throws Exception;
    
    //2-1 ���Ե� ������ ���̹� ���� ����
    public void updateN(MemberVO member) throws Exception;
}
