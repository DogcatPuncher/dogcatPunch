package com.petcation.client.notice.service;

import java.util.List;

import com.petcation.admin.notice.vo.NoticeVO;


public interface User_NoticeService {
	public List<NoticeVO> noticeList(NoticeVO unvo);

	public NoticeVO noticeDetail(NoticeVO unvo); 
	
	public int noticeListCnt(NoticeVO unvo);
}
