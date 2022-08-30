package com.petcation.client.diaryreply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.diaryreply.dao.diaryReplyDao;
import com.petcation.client.diaryreply.vo.diaryReplyVO;

import lombok.Setter;

@Service
public class diaryReplyServiceImpl implements diaryReplyService{
	@Setter(onMethod_=@Autowired)
	private diaryReplyDao diaryreplyDao;
	
	@Override
	public List<diaryReplyVO> diaryReplyList(Integer d_no){
		List<diaryReplyVO> list = null;
		list = diaryreplyDao.diaryReplyList(d_no);
		return list;
	}
	
	@Override
	public int replyInsert(diaryReplyVO drvo) {
		int result = 0;
		result = diaryreplyDao.replyInsert(drvo);
		return result;
	}
	
	@Override
	public int replyDelete(Integer diary_rno) {
		int result = 0;
		result = diaryreplyDao.replyDelete(diary_rno);
		return result;
	}
	
	@Override
	public int replyUpdate(diaryReplyVO drvo) {
		int result = 0;
		result = diaryreplyDao.replyUpdate(drvo);
		return result;
	}
	
}
