package com.petcation.client.traveldiary.service;

import java.util.List;

import com.petcation.client.traveldiary.vo.DiaryVO;
import com.petcation.common.vo.CommonVO;

public interface DiaryService {
	public List<DiaryVO> diaryList(DiaryVO dvo);
	
	/* public List<DiaryVO> diaryList(CommonVO cvo); */
	
	public int diaryInsert(DiaryVO dvo) throws Exception;
	
	public DiaryVO diaryDetail(DiaryVO dvo);
	
	public int diaryDelete(DiaryVO dvo) throws Exception;
	
	public DiaryVO updateForm(DiaryVO dvo);
	
	public int diaryUpdate(DiaryVO dvo) throws Exception;
	
	public int diaryListCnt(DiaryVO dvo);
	
}
