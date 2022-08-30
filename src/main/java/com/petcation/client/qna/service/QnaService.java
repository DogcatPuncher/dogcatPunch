package com.petcation.client.qna.service;

import java.util.List;

import com.petcation.client.qna.vo.QnaVO;

public interface QnaService {
	public List<QnaVO> qnaList(QnaVO qvo);
	public int qnaListCnt(QnaVO qvo);
	public int qnaWrite(QnaVO qvo) throws Exception;
	public QnaVO qnaDetail(QnaVO qvo);
	public int pwdConfirm(QnaVO qvo);
	public QnaVO updateForm(QnaVO qvo);
	public int qnaUpdate(QnaVO qvo) throws Exception;
	public int qnaDelete(QnaVO qvo) throws Exception;
	public int replyCnt(int b_num);
	public QnaVO adminReplyForm(QnaVO qvo) throws Exception;
	public int replyInsert(QnaVO qvo) throws Exception;
	public int makeReply(QnaVO qvo) throws Exception;
}

