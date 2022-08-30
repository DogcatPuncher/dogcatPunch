package com.petcation.client.join.vo;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;

import com.petcation.common.vo.CommonVO;

import lombok.Data;

@Data
public class MemberVO extends CommonVO{
	private int user_no;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private String user_email;
	private String user_date;
	private String naverLogin;
	private List<GrantedAuthority> authList;
	
}
