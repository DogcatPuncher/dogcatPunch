package com.petcation.admin.hotel.dao;

import java.util.List;

import com.petcation.admin.hotel.vo.HotelVO;

public interface HotelDao {
	public List<HotelVO> hotelList(HotelVO hvo);

	public HotelVO hotelDetail(HotelVO hvo);
	
	public int hotelInsert(HotelVO hvo);

	public int hotelDelete(int hotel_no);
	
	public int hotelUpdate(HotelVO hvo);

	public int hotelListCnt(HotelVO hvo);
}
