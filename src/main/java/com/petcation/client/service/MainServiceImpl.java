package com.petcation.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.admin.hotel.vo.HotelVO;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.dao.MainDao;
import com.petcation.client.traveldiary.vo.DiaryVO;

import lombok.Setter;

@Service
public class MainServiceImpl implements MainService{
	@Setter(onMethod_=@Autowired)
	private MainDao mainDao;
	@Override
	public List<DiaryVO> mainDiaryList(DiaryVO dvo) {
		List<DiaryVO> list = null;
		list = mainDao.mainDiaryList(dvo);
		return list;
	}
	@Override
	public List<CommunityBoardVO> mainCommunityList(CommunityBoardVO cbvo) {
		List<CommunityBoardVO> list = null;
		list = mainDao.mainCommunityList(cbvo);
		return list;
	}
	@Override
	public List<HotelVO> mainHotelList(HotelVO hvo) {
		List<HotelVO> list = null;
		list = mainDao.mainHotelList(hvo); 
		return list;
	}
	@Override
	public List<NoticeVO> mainNoticeList(NoticeVO unvo) {
		List<NoticeVO> list = null;
		list = mainDao.mainNoticeList(unvo);
		return list;
	}
	
}
