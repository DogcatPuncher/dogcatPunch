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
	private MultipartFile file; //파일 업로드를 위한 필드
	private String b_thumb = ""; //실제 서버에 저장할 썸네일 이미지 파일명
	private String b_file = ""; // 실제서버에 저장할 파일명
	private String c_name;
}
