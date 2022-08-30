package com.petcation.client.join.dao;


import com.petcation.client.join.vo.MemberVO;

public interface MemberDAO {
	// ȸ������
		public void memberJoin(MemberVO member);
		
	// ���̵� �ߺ� �˻�
		public int idCheck(String user_id);

	// �̸��� �ߺ� �˻�
		public int emailCheck(String user_email);

	// �ڵ��� ��ȣ �ߺ� �˻�
		public int phoneCheck(String user_phone);
	
	// �α��� 
		public MemberVO memberLogin(MemberVO member);
	
	//�̸� ���̵� ��ġ�ϴ� DB �����ϴ��� Ȯ��
		public MemberVO searchPhone(MemberVO member);
	
	//�̸� ���̵� ��ġ�ϴ� DB �����ϴ��� Ȯ��
	    public MemberVO searchEmail(MemberVO member);
	    
	//�ӽ� ��� ������Ʈ
	    public void updatePw(MemberVO member);
	    
	//�׾� �α���
	    public MemberVO read(String username);
	    
	//���̹��� ������ ȸ������ ã�� =>[���Ե� �̸���] �Ǵ� [���̹� ������ȣid]�� ��ȸ�Ͽ� ��    
	    public MemberVO naverChk(MemberVO member);
		
	//2-1 ���Ե� ������ ���̹� ���� ����
	    public void updateN(MemberVO member);
}
