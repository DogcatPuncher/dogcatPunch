package com.petcation.client.reservation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcation.client.hotel.vo.User_HotelVO;
import com.petcation.client.reservation.dao.ReservDao;
import com.petcation.client.reservation.vo.ReservVO;

import lombok.Setter;

@Service
public class ReservServiceImpl implements ReservService {
	
	@Setter(onMethod_=@Autowired)
	private ReservDao reservDao;
	
	@Override
	public User_HotelVO hotelVO(User_HotelVO uhvo) {
		
		User_HotelVO hotelVO = reservDao.hotelVO(uhvo);
		return hotelVO;
	}
	
	
//	@Override
//	public List<ReservVO> reservList(ReservVO rvo) throws Exception {
//		List<ReservVO> reservList = null;
//		reservList = reservDao.reservList(rvo);
//		
//		return reservList;
//	}
	
	@Override
	public int reservInsert(ReservVO rvo) throws Exception {
		int result = 0;
		
		result = reservDao.reservInsert(rvo);
		
		return result;
	}

	@Override
	public ReservVO reservResult(ReservVO rvo) {
		ReservVO reservVO = reservDao.reservResult(rvo);
		
		return reservVO;
	}

	@Override
	public int reservDelete(ReservVO rvo) {
		int result = reservDao.reservDelete(rvo);
		
		return result;
	}


	@Override
	public List<ReservVO> reservDate(int hotel_no) {
		List<ReservVO> reservVO = reservDao.reservDate(hotel_no);
		return reservVO;
	}


	

	

	



}
