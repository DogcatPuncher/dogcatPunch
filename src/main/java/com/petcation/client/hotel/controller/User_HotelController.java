package com.petcation.client.hotel.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petcation.admin.hotel.vo.HotelVO;
import com.petcation.client.hotel.service.User_HotelService;
import com.petcation.client.hotel.vo.User_HotelVO;
import com.petcation.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/hotel/*")
@AllArgsConstructor
public class User_HotelController {
	
	private User_HotelService hotelService;
	
	@RequestMapping(value = "/hotelList", method = RequestMethod.GET)
	public String hotelList(@ModelAttribute("data") HotelVO hvo, Model model) {
		log.info("hotelList 호출 성공");
		List<HotelVO> hotelList = hotelService.hotelList(hvo);
		model.addAttribute("hotelList", hotelList);
		
		int total = hotelService.hotelListCnt(hvo);
		model.addAttribute("pageMaker", new PageDTO(hvo, total));
		
		System.out.println(hotelList);
		return "hotel/hotelList";
	}
	
	@RequestMapping(value = "/hotelDetail", method = RequestMethod.GET)
	public String hotelDetail(@ModelAttribute("data") User_HotelVO uhvo, Model model) {
		log.info("hotelDetail 호출 성공");
		
		User_HotelVO detail = hotelService.hotelDetail(uhvo);
		model.addAttribute("detail", detail);
		
		System.out.println("detail " + detail);
		
		return "hotel/hotelDetail";
	}
}
