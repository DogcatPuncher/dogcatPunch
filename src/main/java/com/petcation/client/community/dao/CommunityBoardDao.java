package com.petcation.client.community.dao;

import java.util.List;

import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.community.vo.CommunityCategoryVO;

public interface CommunityBoardDao {

	public List<CommunityBoardVO> communityBoardList(CommunityBoardVO cbvo);
	
	public List<CommunityCategoryVO> communityCategoryList(CommunityCategoryVO ccvo);
	
	public int boardInsert(CommunityBoardVO cbvo);
	
	public CommunityBoardVO boardDetail(CommunityBoardVO cbvo);
	
	public int boardUpdate(CommunityBoardVO cbvo);
	
	public int boardDelete(int b_no);
	
	public void readCntUpdate(CommunityBoardVO cbvo);
	
	public int boardListCnt(CommunityBoardVO cbvo);
}
