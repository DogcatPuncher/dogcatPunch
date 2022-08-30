package com.petcation.client.member.vo;


import com.petcation.common.vo.CommonVO;

import lombok.Data;

@Data
public class MyMemberVO extends CommonVO {
	private int user_no = 0;
	private String user_name = "";
	private String user_phone = "";
	private String user_email = "";
	private String user_id = "";
	private String user_pw = "";
	private String user_date = "";
}
