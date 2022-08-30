package com.petcation.client.diaryreply.vo;

import lombok.Data;

@Data
public class diaryReplyVO {
	private int diary_rno = 0;
	private int d_no = 0;
	private String diary_rcontent;
	private String diary_rdate;
	private String user_id;
	
}
