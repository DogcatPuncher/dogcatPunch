package com.petcation.client.traveldiary.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.diaryreply.dao.diaryReplyDao;
import com.petcation.client.traveldiary.dao.DiaryDao;
import com.petcation.client.traveldiary.vo.DiaryVO;
import com.petcation.common.file.FileUploadUtil;
import com.petcation.common.vo.CommonVO;

import lombok.Setter;

@Service
public class DiaryServiceImpl implements DiaryService {

	@Setter(onMethod_ = @Autowired)
	private DiaryDao diaryDao;

	@Setter(onMethod_ = @Autowired)
	private diaryReplyDao diaryreplyDao;

	
	 @Override public List<DiaryVO> diaryList(DiaryVO dvo){ 
		 List<DiaryVO> list =null; 
		 list = diaryDao.diaryList(dvo); 
		 return list; 
	 }
	  
	 /** @Override public List<DiaryVO> diaryList(CommonVO cvo){ List<DiaryVO> list =
	 * null; list = diaryDao.diaryList(cvo); return list; }
	 */

	@Override
	public int diaryInsert(DiaryVO dvo) throws Exception {

		int result = 0;
		if (dvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(dvo.getFile(), "diary");
			dvo.setD_file(fileName);

			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			dvo.setD_thumb(thumbName);
		}
		result = diaryDao.diaryInsert(dvo);
		return result;
	}

	@Override
	public DiaryVO diaryDetail(DiaryVO dvo) {
		DiaryVO detail = null;

		diaryDao.readCntUpdate(dvo);

		detail = diaryDao.diaryDetail(dvo);
		if (detail != null) {
			detail.setD_content(detail.getD_content().toString().replace("\n", "<br/>"));
		}
		return detail;
	}

	@Override
	public int diaryDelete(DiaryVO dvo) throws Exception {
		int result = 0;
		if (!dvo.getD_file().isEmpty()) {
			FileUploadUtil.fileDelete(dvo.getD_file());
			FileUploadUtil.fileDelete(dvo.getD_thumb());
		}
		result = diaryDao.diaryDelete(dvo.getD_no());
		return result;
	}

	@Override
	public DiaryVO updateForm(DiaryVO dvo) {
		DiaryVO detail = null;
		detail = diaryDao.diaryDetail(dvo);
		return detail;
	}

	@Override
	public int diaryUpdate(DiaryVO dvo) throws Exception {
		int result = 0;
		if (!dvo.getFile().isEmpty()) {
			if (!dvo.getD_file().isEmpty()) {
				FileUploadUtil.fileDelete(dvo.getD_file());
				FileUploadUtil.fileDelete(dvo.getD_thumb());
			}
			String fileName = FileUploadUtil.fileUpload(dvo.getFile(), "diary");
			dvo.setD_file(fileName);

			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			dvo.setD_thumb(thumbName);
		}
		result = diaryDao.diaryUpdate(dvo);
		return result;
	}

	@Override
	public int diaryListCnt(DiaryVO dvo) {
		return diaryDao.diaryListCnt(dvo);
	}

}
