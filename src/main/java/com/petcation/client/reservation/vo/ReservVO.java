package com.petcation.client.reservation.vo;

import com.petcation.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ReservVO extends CommonVO {
	private	int		reserv_no 		= 0; 	// �����ȣ
	private String	reserv_name 	= ""; 	// �����ڸ�
	private String 	reserv_phone 	= "";	// ������ �ڵ��� ��ȣ
	private int		reserv_people 	= 0;	// �����ο�
	private int 	reserv_status 	= 0;	// ���� ���� (1:������ 2:�̿�Ϸ� 3: �������)
	private String	checkin			= "";	// üũ�� ��¥
	private String	checkout		= ""; 	// üũ�ƿ� ��¥
	private int 	reserv_price	= 0;	// ���� ����
	private String	reserv_date		= "";	// ������
	private	String	merchant_uid	= "";	// ������ȣ
	private int		user_no			= 0;	// ȸ�� �Ϸù�ȣ
	private String	hotel_no		= ""; 	// ���� �Ϸù�ȣ
	private String 	hotel_name;
	private String 	reserv_etc;
	private String 	user_id			= "";   // ȸ�� ���̵�
	
	private int		reserv_status_val = 0;
	private int		reserv_cnt 		= 0; 	// ���� ���� �Ǽ�
	private int		reserv_pay_cnt 	= 0;	// ���� ���� �ݾ�
	
}