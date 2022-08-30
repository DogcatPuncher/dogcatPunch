package com.petcation.client.comreply.service;

import java.util.List;

import com.petcation.client.comreply.vo.comReplyVO;

public interface comReplyService {
	public List<comReplyVO> replyList(Integer b_no);
	public int replyInsert(comReplyVO crvo);
	public int replyDelete(Integer com_rno);
	public int replyUpdate(comReplyVO crvo);
	
}
