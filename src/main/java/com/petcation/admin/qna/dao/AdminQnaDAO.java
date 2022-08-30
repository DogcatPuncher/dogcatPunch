package com.petcation.admin.qna.dao;

import java.util.List;

import com.petcation.client.qna.vo.QnaVO;

public interface AdminQnaDAO {
	public List<QnaVO> qnaList(QnaVO qvo);
	
	public QnaVO aQnaDetail(QnaVO qvo);
	
	public int aQnaDelete(int q_num);
	
	public int aQnaListCnt(QnaVO qvo);
}
