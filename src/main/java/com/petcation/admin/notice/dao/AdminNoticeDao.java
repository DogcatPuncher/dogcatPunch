package com.petcation.admin.notice.dao;

import java.util.List;

import com.petcation.admin.notice.vo.NoticeVO;

public interface AdminNoticeDao {

	List<NoticeVO> noticeList(NoticeVO anvo);

	NoticeVO noticeDetail(NoticeVO anvo);

	int noticeInsert(NoticeVO anvo);

	int noticeDelete(NoticeVO anvo);

	int noticeUpdate(NoticeVO anvo);
	
	int readCntUpdate(NoticeVO anvo);

	int noticeListCnt(NoticeVO anvo);
}
