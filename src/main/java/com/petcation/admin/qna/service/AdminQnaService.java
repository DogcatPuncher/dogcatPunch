package com.petcation.admin.qna.service;

import java.util.List;

import com.petcation.client.qna.vo.QnaVO;

public interface AdminQnaService {
	public List<QnaVO> qnaList(QnaVO qvo);
	public QnaVO aQnaDetail(QnaVO qvo);
	public int aQnaDelete(QnaVO qvo) throws Exception;
	public int aQnaListCnt(QnaVO qvo);
}
