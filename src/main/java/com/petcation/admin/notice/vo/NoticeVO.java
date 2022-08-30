package com.petcation.admin.notice.vo;

import com.petcation.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class NoticeVO extends CommonVO {
	private int n_no;
	private String n_title;
	private String n_content;
	private String n_date;
	private int n_readcnt;
	private String a_id;
	private String a_name;
}
