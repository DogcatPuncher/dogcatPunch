package com.petcation.client.reservation.service;

import java.util.List;

import com.petcation.client.hotel.vo.User_HotelVO;
import com.petcation.client.reservation.vo.ReservVO;

public interface ReservService {
	
	public User_HotelVO hotelVO(User_HotelVO uhvo); 
	// public List<ReservVO> reservList(ReservVO rvo) throws Exception;
	public int reservInsert(ReservVO rvo) throws Exception;
	public ReservVO reservResult(ReservVO rvo);

	public int reservDelete(ReservVO rvo);
	public List<ReservVO> reservDate(int hotel_no);

	
	
}
