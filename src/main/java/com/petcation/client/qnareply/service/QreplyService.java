package com.petcation.client.qnareply.service;

import java.util.List;

import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.vo.QreplyVO;


public interface QreplyService {
	public List<QreplyVO> replyList(Integer b_num);
	public int replyInsert(QreplyVO rvo);
	public int replyDelete(Integer r_num);
	public int replyUpdate(QreplyVO rvo);
}
