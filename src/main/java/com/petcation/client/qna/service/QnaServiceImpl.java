package com.petcation.client.qna.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.qna.dao.QnaDAO;
import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.dao.QreplyDAO;
import com.petcation.common.file.FileUploadUtil;

import lombok.Setter;
	
@Service
public class QnaServiceImpl implements QnaService {
	
	@Setter(onMethod_=@Autowired)
	private QnaDAO qnaDao;
	
	@Setter(onMethod_=@Autowired)
	private QreplyDAO replyDao;
	
	@Override
	public List<QnaVO> qnaList(QnaVO qvo) {
		List<QnaVO> list = null;
		
		list = qnaDao.qnaList(qvo);
		return list;
	}
	
	@Override
	public int qnaListCnt(QnaVO qvo) {
		return qnaDao.qnaListCnt(qvo);
	}
	
	
	@Override
	public int qnaWrite(QnaVO qvo) throws Exception  {
		int result = 0;
		if(qvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(qvo.getFile(), "qna");
			qvo.setQ_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			qvo.setQ_thumb(thumbName);
		}
		result = qnaDao.qnaWrite(qvo);
		return result;
	}
	
	@Override
	public QnaVO qnaDetail(QnaVO qvo) {
		QnaVO detail = null;
		qnaDao.readCntUpdate(qvo);
		detail = qnaDao.qnaDetail(qvo);
		if(detail!=null) {
			detail.setQ_content(detail.getQ_content().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}
	
	@Override
	public int pwdConfirm(QnaVO qvo) {
		int result = 0;
		
		result = qnaDao.pwdConfirm(qvo);
		return result;
	}
	
	@Override
	public QnaVO updateForm(QnaVO qvo) {
		QnaVO updateData = null;
		updateData = qnaDao.qnaDetail(qvo);
		return updateData;
	}

	@Override
	public QnaVO adminReplyForm(QnaVO qvo) {
		QnaVO replyData = null;
		replyData = qnaDao.qnaDetail(qvo);
		return replyData;
	}
	
	@Override
	public int replyInsert(QnaVO qvo) throws Exception {
		int result = 0;
		if(qvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(qvo.getFile(), "qna");
			qvo.setQ_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			qvo.setQ_thumb(thumbName);
		}
		result = qnaDao.replyInsert(qvo);
		return result;
	}

	@Override
	public int qnaUpdate(QnaVO qvo) throws Exception {
		int result = 0;
		if(!qvo.getFile().isEmpty()) {
			if(!qvo.getQ_file().isEmpty()) {
				FileUploadUtil.fileDelete(qvo.getQ_file());
				FileUploadUtil.fileDelete(qvo.getQ_thumb());
			}
			
			String fileName = FileUploadUtil.fileUpload(qvo.getFile(), "qna");
			qvo.setQ_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			qvo.setQ_thumb(thumbName);
		}
		result = qnaDao.qnaUpdate(qvo);
		return result;
	}

	@Override
	public int qnaDelete(QnaVO qvo) throws Exception{
		int result = 0;
		if(!qvo.getQ_file().isEmpty()) {
			FileUploadUtil.fileDelete(qvo.getQ_file());
			FileUploadUtil.fileDelete(qvo.getQ_thumb());
		}
		result = qnaDao.qnaDelete(qvo.getQ_num());
		return result;
	}
	
	@Override
	public int makeReply(QnaVO qvo) throws Exception {
		return qnaDao.makeReply(qvo);
	}
	
	@Override
	public int replyCnt(int f_num) {
		int result = 0;
		result = replyDao.replyCnt(f_num);
		return result;
	}
	
	
}
