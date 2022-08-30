package com.petcation.admin.notice.service;

import java.util.List;

import com.petcation.admin.notice.vo.NoticeVO;

public interface AdminNoticeService {
	public List<NoticeVO> noticeList(NoticeVO anvo);

	public NoticeVO noticeDetail(NoticeVO anvo);

	public int noticeInsert(NoticeVO anvo) throws Exception;

	public int noticeDelete(NoticeVO anvo);

	public NoticeVO updateForm(NoticeVO anvo);

	public int noticeUpdate(NoticeVO anvo);
	
	public int noticeListCnt(NoticeVO anvo);
}
