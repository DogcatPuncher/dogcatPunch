package com.petcation.client.traveldiary.dao;

import java.util.List;

import com.petcation.client.traveldiary.vo.DiaryVO;
import com.petcation.common.vo.CommonVO;

public interface DiaryDao {
	public List<DiaryVO> diaryList(DiaryVO dvo);
	
	/* public List<DiaryVO> diaryList(CommonVO cvo); */
	
	public int diaryInsert(DiaryVO dvo);
	
	public DiaryVO diaryDetail(DiaryVO dvo);
	
	public int diaryDelete(int d_no);
	
	public int diaryUpdate(DiaryVO dvo);
	
	public int readCntUpdate(DiaryVO dvo);
	
	public int diaryListCnt(DiaryVO dvo);
}
