package com.petcation.client.qnareply.dao;

import java.util.List;

import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.vo.QreplyVO;


public interface QreplyDAO {
	public List<QreplyVO> replyList(Integer q_num);
	public int replyInsert(QreplyVO rvo);
	public int replyDelete(Integer r_num);
	public int replyUpdate(QreplyVO rvo);
	public int replyCnt(int q_num);
}