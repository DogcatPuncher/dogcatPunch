package com.petcation.client.notice.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.petcation.client.notice.service.User_NoticeService;
import com.petcation.common.vo.PageDTO;
import com.petcation.admin.notice.vo.NoticeVO;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/notice/*")
@AllArgsConstructor
public class User_NoticeController {

	private User_NoticeService noticeService;
	
	@RequestMapping(value = "/noticeList")
	public String noticeList(@ModelAttribute("data") NoticeVO unvo, Model model) {
		List<NoticeVO> noticeList = noticeService.noticeList(unvo);
		int total = noticeService.noticeListCnt(unvo);
		System.out.println(total);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageMaker", new PageDTO(unvo, total));
		
		return "notice/noticeList";
	}
	
	@RequestMapping(value = "/noticeDetail")
	public String noticeDetail(@ModelAttribute("data") NoticeVO unvo, Model model) {
		NoticeVO detail = noticeService.noticeDetail(unvo);
		model.addAttribute("detail", detail);
		
		return "notice/noticeDetail";
	}
}
