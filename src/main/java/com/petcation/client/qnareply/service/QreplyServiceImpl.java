package com.petcation.client.qnareply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.dao.QreplyDAO;
import com.petcation.client.qnareply.vo.QreplyVO;

import lombok.Setter;

@Service
public class QreplyServiceImpl implements QreplyService {
	
	@Setter(onMethod_=@Autowired) 
	private QreplyDAO replyDao;
	
	@Override
	public List<QreplyVO> replyList(Integer b_num){
		List<QreplyVO> list = null;
		
		list = replyDao.replyList(b_num);
		return list;
	}
	
	@Override
	public int replyInsert(QreplyVO rvo) {
		int result = 0;
		result = replyDao.replyInsert(rvo);
		return result;
	}
	
	@Override
	public int replyDelete(Integer r_num) {
		int result = 0;
		result = replyDao.replyDelete(r_num);
		return result;
	}
	
	@Override
	public int replyUpdate(QreplyVO rvo) {
		int result = 0;
		result = replyDao.replyUpdate(rvo);
		return result;
	}

}
