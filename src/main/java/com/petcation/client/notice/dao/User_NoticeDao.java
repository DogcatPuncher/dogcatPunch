package com.petcation.client.notice.dao;

import java.util.List;

import com.petcation.admin.notice.vo.NoticeVO;

public interface User_NoticeDao {
	public List<NoticeVO> noticeList(NoticeVO unvo);

	public NoticeVO noticeDetail(NoticeVO unvo);
	
	public int noticeListCnt(NoticeVO unvo);
	
	/* public NoticeVO readCntUpdate(NoticeVO unvo); */
}
