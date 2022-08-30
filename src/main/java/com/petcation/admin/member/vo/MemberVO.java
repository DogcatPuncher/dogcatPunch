package com.petcation.admin.member.vo;

import com.petcation.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class MemberVO extends CommonVO{
	private int user_no = 0;
	private String user_name = "";
	private String user_phone = "";
	private String user_email = "";
	private String user_id = "";
	private String user_pw = "";
	private String user_date = "";
	
	private int c_no;
	private String c_name;
	private int all_member;
	private int member_today;
	 
}
