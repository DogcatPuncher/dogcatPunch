package com.petcation.client.community.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.petcation.common.vo.CommonVO;

import lombok.Data;

@Data
public class CommunityBoardVO extends CommonVO{
	private int b_no;
	private int c_no;
	private int user_no;
	private String user_id;
	private String b_title;
	private String b_content;
	private Date b_regdate;
	private int b_readcnt;
	private int com_rcnt;
	private MultipartFile file; //���� ���ε带 ���� �ʵ�
	private String b_thumb = ""; //���� ������ ������ ����� �̹��� ���ϸ�
	private String b_file = ""; // ���������� ������ ���ϸ�
	private String c_name;
}
