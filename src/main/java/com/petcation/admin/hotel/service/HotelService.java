package com.petcation.admin.hotel.service;

import java.util.List;

import com.petcation.admin.hotel.vo.HotelVO;

public interface HotelService {
	public List<HotelVO> hotelList(HotelVO hvo);

	public HotelVO hotelDetail(HotelVO hvo);

	public int hotelInsert(HotelVO hvo) throws Exception;

	public int hotelDelete(HotelVO hvo) throws Exception;

	public int hotelUpdate(HotelVO hvo) throws Exception;

	public HotelVO updateForm(HotelVO hvo);

	public int hotelListCnt(HotelVO hvo);
}
