package com.petcation.client.dao;

import java.util.List;

import com.petcation.admin.hotel.vo.HotelVO;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.traveldiary.vo.DiaryVO;

public interface MainDao {
	public List<DiaryVO> mainDiaryList(DiaryVO dvo);
	
	public List<CommunityBoardVO> mainCommunityList(CommunityBoardVO cbvo);
	
	public List<HotelVO> mainHotelList(HotelVO hvo);
	
	public List<NoticeVO> mainNoticeList(NoticeVO unvo);
}
