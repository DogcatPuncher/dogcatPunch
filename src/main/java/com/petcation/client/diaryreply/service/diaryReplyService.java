package com.petcation.client.diaryreply.service;

import java.util.List;

import com.petcation.client.diaryreply.vo.diaryReplyVO;

public interface diaryReplyService {
	public List<diaryReplyVO> diaryReplyList(Integer d_no);
	public int replyInsert(diaryReplyVO drvo);
	public int replyDelete(Integer diary_rno);
	public int replyUpdate(diaryReplyVO drvo);
}
