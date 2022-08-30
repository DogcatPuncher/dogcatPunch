package com.petcation.client.reservation.dao;

import java.util.List;

import com.petcation.client.hotel.vo.User_HotelVO;
import com.petcation.client.join.vo.MemberVO;
import com.petcation.client.reservation.vo.ReservVO;

public interface ReservDao {
	
	public User_HotelVO hotelVO(User_HotelVO uhvo);
	public int reservForm(MemberVO mvo);
	//public List<ReservVO> reservList(ReservVO rvo);
	
	public int reservInsert(ReservVO rvo);
	
	public ReservVO reservResult(ReservVO rvo);
	public int reservDelete(ReservVO rvo);
	
	public List<ReservVO> reservDate(int hotel_no);
	
	
}
