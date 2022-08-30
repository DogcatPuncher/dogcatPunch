package com.petcation.client.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcation.client.notice.dao.User_NoticeDao;
import com.petcation.admin.notice.vo.NoticeVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class User_NoticeServiceImpl implements User_NoticeService {

	private User_NoticeDao noticeDao;
		
	@Override
	public List<NoticeVO> noticeList(NoticeVO unvo) {
		List<NoticeVO> list = null;
		list = noticeDao.noticeList(unvo);
		return list;
	}

	
	@Override 
	public NoticeVO noticeDetail(NoticeVO unvo) { 
		NoticeVO detail = noticeDao.noticeDetail(unvo); 
		//noticeDao.readCntUpdate(unvo); 
		if(detail != null) { 
			detail.setN_content(detail.getN_content().toString().replace("\n", "<br/>")); 
			} 
		return detail; 
		}
	
	@Override
	public int noticeListCnt(NoticeVO unvo) {
		return noticeDao.noticeListCnt(unvo);
	}

}

