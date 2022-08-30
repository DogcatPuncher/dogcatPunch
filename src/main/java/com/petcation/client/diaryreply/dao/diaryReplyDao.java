package com.petcation.client.diaryreply.dao;

import java.util.List;

import com.petcation.client.diaryreply.vo.diaryReplyVO;

public interface diaryReplyDao {
	public List<diaryReplyVO> diaryReplyList(Integer d_no);
	public int replyInsert(diaryReplyVO drvo);
	public int replyDelete(Integer diary_rno);
	public int replyUpdate(diaryReplyVO drvo);
	public int replyCnt(int d_no);
}
