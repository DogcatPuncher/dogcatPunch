package com.petcation.client.qnareply.vo;

import lombok.Data;

@Data
public class QreplyVO {
	private int		r_num		=0;
	private int		q_num		=0;
	private String r_name		="";
	private String r_content	="";
	private String r_date		="";
	private String r_pwd		="";
	private String a_id;
	private int	   admin_Qna_today=0;
	private int    admin_Qna_yet =0;
}
