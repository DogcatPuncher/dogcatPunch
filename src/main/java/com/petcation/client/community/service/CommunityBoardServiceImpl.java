package com.petcation.client.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.community.dao.CommunityBoardDao;
import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.community.vo.CommunityCategoryVO;
import com.petcation.client.comreply.dao.comReplyDao;
import com.petcation.common.file.FileUploadUtil;

import lombok.Setter;
@Service
public class CommunityBoardServiceImpl implements CommunityBoardService{
	
	@Setter(onMethod_=@Autowired)
	private CommunityBoardDao boardDao;
	
	@Setter(onMethod_=@Autowired)
	private comReplyDao replyDao;
	
	//글목록 구현
	@Override
	public List<CommunityBoardVO>communityBoardList(CommunityBoardVO cbvo){
		List<CommunityBoardVO> list = null;
		list = boardDao.communityBoardList(cbvo);
		return list;
	}
	
	@Override
	public List<CommunityCategoryVO> communityCategoryList(CommunityCategoryVO ccvo){
		List<CommunityCategoryVO> clist =boardDao.communityCategoryList(ccvo);
		return clist;
	}
	
	//상세페이지
	@Override
	public CommunityBoardVO boardDetail(CommunityBoardVO cbvo) {
		CommunityBoardVO detail = null;
		
		boardDao.readCntUpdate(cbvo);
		
		detail = boardDao.boardDetail(cbvo);
		if(detail!=null) {
			detail.setB_content(detail.getB_content().toString().replace("\n","<br />"));
		}
		return detail;
	}
	
	//입력하기
	@Override
	public int boardInsert(CommunityBoardVO cbvo) throws Exception{
		int result = 0;
		if(cbvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(cbvo.getFile(),"CommunityBoard");
			cbvo.setB_file(fileName);
		}
		result = boardDao.boardInsert(cbvo);
		return result;
	}
	
	//수정하기
	@Override
	public CommunityBoardVO updateForm(CommunityBoardVO cbvo) {
		CommunityBoardVO detail = null;
		detail = boardDao.boardDetail(cbvo);
		return detail;
	}
	
	@Override
	public int boardUpdate(CommunityBoardVO cbvo) throws Exception{
		int result = 0;
		if(!cbvo.getFile().isEmpty()) {
			if(!cbvo.getB_file().isEmpty()) {
				FileUploadUtil.fileDelete(cbvo.getB_file());
			}
			String fileName = FileUploadUtil.fileUpload(cbvo.getFile(), "CommunityBoard");
			cbvo.setB_file(fileName);				
		}
		result = boardDao.boardUpdate(cbvo);
		return result;
	}
	
	//삭제하기
	@Override
	public int boardDelete(CommunityBoardVO cbvo) throws Exception{
		int result = 0;
		if(!cbvo.getB_file().isEmpty()) {
			FileUploadUtil.fileDelete(cbvo.getB_file());
		}
		result = boardDao.boardDelete(cbvo.getB_no());
		return result;
	}
	
	@Override
	public int replyCnt(int b_no) {
		int result = 0;
		result = replyDao.replyCnt(b_no);
		return result;
	}

	@Override
	public int boardListCnt(CommunityBoardVO cbvo) {
		return boardDao.boardListCnt(cbvo);
	}
}
