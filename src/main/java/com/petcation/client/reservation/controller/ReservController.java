package com.petcation.client.reservation.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petcation.client.hotel.vo.User_HotelVO;
import com.petcation.client.join.vo.MemberVO;
import com.petcation.client.reservation.service.ReservService;
import com.petcation.client.reservation.vo.ReservVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/reserv/*")
@AllArgsConstructor
public class ReservController {
	
	private ReservService reservService;

	
	@RequestMapping(value = "/reservForm")
	public String reservForm(@ModelAttribute("data") User_HotelVO uhvo, ReservVO rvo, MemberVO mvo, HttpServletRequest request,Model model) throws Exception {
		log.info("reservForm 호출 성공");
		
		String url ="";
		
		HttpSession session = request.getSession();
		
	    MemberVO userID =(MemberVO)session.getAttribute("lmember");
	    	if(userID != null) {
	    		 
	    		 User_HotelVO hotelVO = reservService.hotelVO(uhvo);
	             
	             rvo.setUser_no(userID.getUser_no());
	             
	             model.addAttribute("hotelVO",hotelVO);
	             
	             url = "reserv/reservForm";
	          } else {
	        	  url = "member/login";
	        	  String msg ="로그인 후 이용해주세요";
	        	  
	          }
		
		return url;
	}
	
	@ResponseBody
	@GetMapping(value = "/reservDate/{hotel_no}", produces=MediaType.APPLICATION_JSON_VALUE)
	   public List<ReservVO> reservDate(@PathVariable("hotel_no") @ModelAttribute("data") int hotel_no){
	      log.info("reservList 호출 성공");
	      
	      List<ReservVO> date = null;
	      date = reservService.reservDate(hotel_no);
	      
	      System.out.println("date : "+date);
	      return date;
	 }
	
	@RequestMapping(value = "/reservInsert", method=RequestMethod.POST)
	public String reservInsert(@ModelAttribute("data") ReservVO rvo,MemberVO mvo,HttpServletRequest request, Model model) throws Exception{
		log.info("reservInsert 호출 성공");
		
		HttpSession session = request.getSession();
		MemberVO userID = (MemberVO) session.getAttribute("lmember");
		rvo.setUser_no(userID.getUser_no());
		
		int reservResult = 0;
		
		String url = "";
		
		reservResult = reservService.reservInsert(rvo);
		
		model.addAttribute("result",rvo);
		System.out.println(rvo);
		
		
		log.info("예약 insert 결과 :  " + reservResult);
		
		if(reservResult == 1) { 
			url = "reserv/reservResult";
		} else {
			url = "hotel/hotelDetail";
		}
		
		
		return url;
		
	}
	
	@RequestMapping(value = "/reservResult")
	public String reservResult(@ModelAttribute("data") ReservVO rvo, Model model) {
		log.info("reservResult 호출 성공");
		
		ReservVO reservVO = reservService.reservResult(rvo);
		
		model.addAttribute("reservVO",reservVO);
		System.out.println("reservResult : " + reservVO);
		
		return "/reserv/reservResult";
		
	}
	
	 @RequestMapping(value = "/reservDelete", method = RequestMethod.GET) 
	 public String reservDelete(@ModelAttribute("data") ReservVO rvo, HttpServletRequest request, Model model) {
		log.info("예약 취소 호출 성공");
		
		String url = "";
		
		HttpSession session = request.getSession();
		MemberVO userID = (MemberVO) session.getAttribute("lmember");
		rvo.setUser_no(userID.getUser_no());
			
		 int result = reservService.reservDelete(rvo);
		 
		 System.out.println("result : " + result);
		 
		 if(result == 1) {
				url="/mypage/reservList";
			}else {
				url="/mypage/reservList";
			}
		return "redirect:"+url;
		 
		 
	 }
	
	
}


