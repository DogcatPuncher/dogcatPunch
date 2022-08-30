package com.petcation.client.community.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petcation.client.community.service.CommunityBoardService;
import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.hotel.vo.User_HotelVO;
import com.petcation.client.join.vo.MemberVO;
import com.petcation.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Controller
@Log4j
@RequestMapping("/community/")
@AllArgsConstructor
public class CommunityBoardController {
	
	private CommunityBoardService boardService;
	
	@RequestMapping(value="/communityBoardList/{c_no}", method = RequestMethod.GET)
	public String communityBoardList(@PathVariable("c_no") int c_no, @ModelAttribute("data") CommunityBoardVO cbvo,MemberVO member, HttpServletRequest request,Model model){
		log.info("communityBoardList 호출 성공");
		
		String url ="";
		
		HttpSession session = request.getSession();
		
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
			if(userID != null) {
	   		 
				session.setAttribute("lmember", userID);
				System.out.println(userID);
				
		   		cbvo.setUser_id(userID.getUser_id());
		   		 
		   		List<CommunityBoardVO> communityBoardList = boardService.communityBoardList(cbvo);
				System.out.println(communityBoardList);
		            
		   		 model.addAttribute("communityBoardList",communityBoardList);
		         
		   		 int total = boardService.boardListCnt(cbvo);
				 model.addAttribute("pageMaker", new PageDTO(cbvo, total));
		   		 
		         url = "community/communityBoardList";
			} else {
		       	 url = "member/login";
		       	 String msg ="로그인 후 이용해주세요";
	       	  
	         }
		
		return url;
		
	}
	
	@RequestMapping(value="/communityBoardDetail/{c_no}", method = RequestMethod.GET)
	public String boardDetail(@PathVariable("c_no")int c_no,@ModelAttribute("data")CommunityBoardVO cbvo, MemberVO member, HttpServletRequest request, Model model) {
		log.info("boardDetail 호출 성공");
		CommunityBoardVO detail = boardService.boardDetail(cbvo);
		System.out.println(detail);
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		cbvo.setUser_id(userID.getUser_id());
		model.addAttribute("detail",detail);
		return "community/communityBoardDetail";
		
	}
	//글쓰기 폼만
	@RequestMapping(value="/communityBoardWrite/{c_no}", method = RequestMethod.GET)
	public String boardWrite(@PathVariable("c_no")int c_no,@ModelAttribute("data")CommunityBoardVO cbvo,MemberVO member, HttpServletRequest request, Model model) {
		log.info("write 호출 성공");
		System.out.println("카테고리 넘버 : "+c_no);
		System.out.println(cbvo);
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		cbvo.setUser_id(userID.getUser_id());
		return "community/communityBoardWrite";
	}
	
	
	@RequestMapping(value="/boardInsert/{c_no}", method = RequestMethod.POST)
	public String boardInsert(@PathVariable("c_no")int c_no,@ModelAttribute("data")CommunityBoardVO cbvo,MemberVO member, HttpServletRequest request, Model model)throws Exception{
		log.info("boardinsert 호출 성공");
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		cbvo.setUser_id(userID.getUser_id());
		int result = 0;
		String url = "";
		result = boardService.boardInsert(cbvo);
		System.out.println(c_no);
		if(result == 1) {
			url = "/community/communityBoardList/{c_no}";
		}else {
			url = "/community/communityBoardWrite/{c_no}";
		}
		return "redirect:"+url;
	}
	
	@RequestMapping(value="/communityBoardUpdate/{c_no}")//폼
	public String updateForm(@PathVariable("c_no")int c_no,@ModelAttribute("data")CommunityBoardVO cbvo, MemberVO member, HttpServletRequest request,Model model) {
		System.out.println("updateForm 호출 성공");
		System.out.println("b_no = "+cbvo.getB_no());
		
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		cbvo.setUser_id(userID.getUser_id());
		
		CommunityBoardVO updateData = boardService.updateForm(cbvo);
		
		model.addAttribute("updateData", updateData);
		return "community/communityBoardUpdate";
	}
	
	@RequestMapping(value="/boardUpdate/{c_no}", method = RequestMethod.POST)
	public String boardUpdate(@ModelAttribute("data")CommunityBoardVO cbvo, MemberVO member, HttpServletRequest request, RedirectAttributes ras) throws Exception{
		System.out.println("boardUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		cbvo.setUser_id(userID.getUser_id());
		
		result = boardService.boardUpdate(cbvo);
		ras.addFlashAttribute("data", cbvo);
		
		if(result == 1) {
			url = "/community/communityBoardDetail/{c_no}?b_no="+cbvo.getB_no();
		}else {
			url = "/community/communityBoardUpdate/{c_no}?b_no"+cbvo.getB_no();
		}
		return "redirect:"+url;
	}
	
	@RequestMapping(value="/boardDelete/{c_no}")
	public String boardDelete(@ModelAttribute("data")CommunityBoardVO cbvo, MemberVO member, HttpServletRequest request, RedirectAttributes ras) throws Exception{
		int result = 0;
		String url = "";
		
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		cbvo.setUser_id(userID.getUser_id());
		
		result = boardService.boardDelete(cbvo);
		ras.addFlashAttribute("data", cbvo);
		
		if(result == 1){
			url = "/community/communityBoardList/{c_no}";
		}else {
			url = "/community/communityBoardDetail/{c_no}";
		}
		return "redirect:"+url;
	}
	@ResponseBody
	@RequestMapping(value="/replyCnt")
	public String replyCnt(@RequestParam("b_no")int b_no) {
		log.info("replyCnt 호출");
		
		int result = 0;
		result = boardService.replyCnt(b_no);
		return String.valueOf(result);
	}
	
}
