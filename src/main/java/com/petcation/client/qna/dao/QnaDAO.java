package com.petcation.client.qna.dao;

import java.util.List;

import com.petcation.client.qna.vo.QnaVO;

public interface QnaDAO {

public List<QnaVO> qnaList(QnaVO qvo);
	
	public int qnaListCnt(QnaVO qvo);
	
	public int qnaWrite(QnaVO qvo);
	
	public QnaVO qnaDetail(QnaVO qvo);
	
	public int readCntUpdate(QnaVO qvo);
	
	public int pwdConfirm(QnaVO qvo);
	
	public QnaVO updateForm(QnaVO qvo);
	
	public int qnaUpdate(QnaVO qvo);
	
	public int qnaDelete(int q_num);
	
	public QnaVO adminReplyForm(QnaVO qvo);

	public int replyInsert(QnaVO qvo);
	public int makeReply(QnaVO qvo);
	
	
	
}