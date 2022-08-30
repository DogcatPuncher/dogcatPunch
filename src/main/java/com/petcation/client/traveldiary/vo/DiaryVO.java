package com.petcation.client.traveldiary.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.petcation.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data 
@EqualsAndHashCode(callSuper=false)
public class DiaryVO extends CommonVO{ 
	
	private int d_no;
	private int user_no;
	private String user_id;
	private String d_title = "";
	private String d_content = "";
	private Date d_regdate;
	private int d_readcnt;
	private MultipartFile file;
	private String d_thumb;
	private String d_file;
}
