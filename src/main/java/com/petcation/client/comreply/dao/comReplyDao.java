package com.petcation.client.comreply.dao;

import java.util.List;

import com.petcation.client.comreply.vo.comReplyVO;

public interface comReplyDao {
	public List<comReplyVO> replyList(Integer b_no);
	public int replyInsert(comReplyVO crvo);
	public int replyDelete(Integer com_rno);
	public int replyUpdate(comReplyVO crvo);
	public int replyCnt(int b_no);
}
