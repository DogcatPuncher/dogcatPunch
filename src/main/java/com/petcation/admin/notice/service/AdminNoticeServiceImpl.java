package com.petcation.admin.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcation.admin.notice.dao.AdminNoticeDao;
import com.petcation.admin.notice.vo.NoticeVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AdminNoticeServiceImpl implements AdminNoticeService {

	private AdminNoticeDao noticeDao;
	
	@Override
	public List<NoticeVO> noticeList(NoticeVO anvo) {
		List<NoticeVO> list = null;
		list = noticeDao.noticeList(anvo);
		return list;
	}

	@Override
	public NoticeVO noticeDetail(NoticeVO anvo) {
		NoticeVO detail = noticeDao.noticeDetail(anvo);
		
		noticeDao.readCntUpdate(anvo);
		
		if(detail != null) {
			detail.setN_content(detail.getN_content().toString().replace("\n", "<br/>"));
		}
		return detail;
	}

	@Override
	public int noticeInsert(NoticeVO anvo) throws Exception {
		int result = 0;
		result = noticeDao.noticeInsert(anvo);
		return result;
	}

	@Override
	public int noticeDelete(NoticeVO anvo) {
		int result = 0;
		result = noticeDao.noticeDelete(anvo);
		return result;
	}

	@Override
	public NoticeVO updateForm(NoticeVO anvo) {
		NoticeVO detail = null;
		detail = noticeDao.noticeDetail(anvo);
		return detail;
	}

	@Override
	public int noticeUpdate(NoticeVO anvo) {
		int result = 0;
		result = noticeDao.noticeUpdate(anvo);
		return result;
	}

	@Override
	public int noticeListCnt(NoticeVO anvo) {
		return noticeDao.noticeListCnt(anvo);
	}

}
