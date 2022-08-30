package com.petcation.client.qna.vo;
import org.springframework.web.multipart.MultipartFile;

import com.petcation.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class QnaVO extends CommonVO { 
	private int 	q_num		=0;
	private int 	user_no		=0;
	private String q_name		="";
	private String q_title		="";
	private String q_content	=""; 
	private String q_date;
	private String q_pwd		="";
	private int		readcnt 	=0;
	private int		r_cnt		=0;
	
	private MultipartFile file; //파일 업로드를 위한 필드
	private String q_thumb =""; //실제서버에 저장할 썸네일 이미지 파일명
	private String q_file =""; //실제서버에 저장할 파일명
}
