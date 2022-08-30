package com.petcation.client.community.service;

import java.util.List;

import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.community.vo.CommunityCategoryVO;


public interface CommunityBoardService {
	public List<CommunityBoardVO> communityBoardList(CommunityBoardVO cbvo);
	
	public List<CommunityCategoryVO> communityCategoryList(CommunityCategoryVO ccvo);
	
	public CommunityBoardVO boardDetail(CommunityBoardVO cbvo);
	
	public int boardInsert(CommunityBoardVO cbvo) throws Exception;
	
	public  CommunityBoardVO updateForm(CommunityBoardVO cbvo);
	
	public int boardUpdate(CommunityBoardVO cbvo) throws Exception;
	
	public int boardDelete(CommunityBoardVO cbvo) throws Exception;
	
	public int replyCnt(int b_no);
	
	public int boardListCnt(CommunityBoardVO cbvo);
}
