package com.petcation.admin.notice.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petcation.admin.notice.service.AdminNoticeService;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.common.vo.PageDTO;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/notice/*")
@AllArgsConstructor
public class AdminNoticeController {

	private AdminNoticeService noticeService;
	
	@RequestMapping(value = "/noticeList")
	public String noticeList (@ModelAttribute("data")NoticeVO anvo, Model model) {
		List<NoticeVO> list = null;
		list = noticeService.noticeList(anvo);
		model.addAttribute("noticeList", list);
		
		int total = noticeService.noticeListCnt(anvo);
		model.addAttribute("pageMaker", new PageDTO(anvo, total));
		
		return "admin/notice/noticeList";
	}
	
	@RequestMapping(value = "/noticeDetail")
	public String noticeDetail(@ModelAttribute("data") NoticeVO anvo, Model model) {
		NoticeVO detail = noticeService.noticeDetail(anvo);
		model.addAttribute("detail", detail);
		
		return "admin/notice/noticeDetail";
	}
	
	@RequestMapping(value = "/writeForm")
	public String noticeWrite() {
		return "admin/notice/writeForm";
	}
	
	@RequestMapping(value = "/noticeInsert", method = RequestMethod.POST)
	public String noticeInsert(NoticeVO anvo, Model model) throws Exception {
		int result = 0;
		String url = "";
		
		result = noticeService.noticeInsert(anvo);
		if(result == 1) {
			url = "/admin/notice/noticeList";
		}else {
			url = "/admin/notice/writeForm";
		}
		
		return "redirect:"+url;
	}
	
	@RequestMapping(value = "/noticeDelete")
	public String noticeDelete(@ModelAttribute NoticeVO anvo, RedirectAttributes ras) throws Exception {
		int result = 0;
		String url = "";
		
		result = noticeService.noticeDelete(anvo);
		ras.addFlashAttribute("NoticeVO", anvo);
		
		if(result == 1) {
			url = "/admin/notice/noticeList";
		}else {
			url = "/admin/notice/noticeDetail?n_no="+anvo.getN_no();
		}
		
		return "redirect:" + url;
	}
	
	@RequestMapping(value = "/updateForm")
	public String updateForm(@ModelAttribute("data") NoticeVO anvo, Model model) {
		NoticeVO updateData = noticeService.updateForm(anvo);
		
		model.addAttribute("updateData", updateData);
		return "admin/notice/updateForm";
	}
	
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdate(@ModelAttribute("data") NoticeVO anvo, RedirectAttributes ras) throws Exception {
		System.out.println("noticeUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = noticeService.noticeUpdate(anvo);
		ras.addAttribute("data", anvo);
		
		System.out.println("getN_no : " + anvo.getN_no());
		if(result == 1) {
			url = "/admin/notice/noticeDetail";
		}else {
			url = "/admin/notice/updateForm";
		}
		
		return "redirect:" + url;
	}
}
