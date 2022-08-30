package com.petcation.admin.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.admin.qna.dao.AdminQnaDAO;
import com.petcation.client.qna.vo.QnaVO;
import com.petcation.common.file.FileUploadUtil;

import lombok.Setter;

@Service
public class AdminQnaServiceImpl implements AdminQnaService {
	
	@Setter(onMethod_=@Autowired)
	private AdminQnaDAO aqDao;
	
	@Override
	public List<QnaVO> qnaList(QnaVO qvo){
		List<QnaVO> list = null;
		
		list = aqDao.qnaList(qvo);
		return list;
	}
	
	@Override
	public QnaVO aQnaDetail(QnaVO qvo) {
		QnaVO detail = null;
		detail = aqDao.aQnaDetail(qvo);
		if(detail!=null) {
			detail.setQ_content(detail.getQ_content().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}
	
	@Override
	public int aQnaDelete(QnaVO qvo) throws Exception{
		int result = 0;
		if(!qvo.getQ_file().isEmpty()) {
			FileUploadUtil.fileDelete(qvo.getQ_file());
			FileUploadUtil.fileDelete(qvo.getQ_thumb());
		}
		result = aqDao.aQnaDelete(qvo.getQ_num());
		return result;
	}
	
	@Override
	public int aQnaListCnt(QnaVO qvo) {
		return aqDao.aQnaListCnt(qvo);
	}
}
