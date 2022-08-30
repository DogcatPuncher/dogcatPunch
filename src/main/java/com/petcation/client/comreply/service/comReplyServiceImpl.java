package com.petcation.client.comreply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.comreply.dao.comReplyDao;
import com.petcation.client.comreply.vo.comReplyVO;

import lombok.Setter;

@Service
public class comReplyServiceImpl implements comReplyService{
	@Setter(onMethod_=@Autowired)
	private comReplyDao comreplyDao;
	
	@Override
	public List<comReplyVO> replyList(Integer b_no){
		List<comReplyVO> list = null;
		list = comreplyDao.replyList(b_no);
		return list;
	}

	@Override
	public int replyInsert(comReplyVO crvo) {
		int result = 0;
		result = comreplyDao.replyInsert(crvo);
		return result;
	}
	
	@Override
	public int replyDelete(Integer com_rno) {
		int result = 0;
		result = comreplyDao.replyDelete(com_rno);
		return result;
	}
	

	@Override
	public int replyUpdate(comReplyVO crvo) {
		int result = 0;
		result = comreplyDao.replyUpdate(crvo);
		return result;
	}
	
}
