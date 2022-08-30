package com.petcation.admin.qna.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petcation.admin.qna.service.AdminQnaService;
import com.petcation.client.qna.service.QnaService;
import com.petcation.client.qna.vo.QnaVO;
import com.petcation.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Controller
@Log4j
@RequestMapping(value = "/admin/qna/*")
public class AdminQnaController {
	
	private AdminQnaService aqService;
	private QnaService qService;
	
	// AdminQnaList 페이지 이동
		@RequestMapping(value="/qnaList", method=RequestMethod.GET)
		public String qnaList(@ModelAttribute QnaVO qvo, Model model) {
			
			List<QnaVO> qnaList = aqService.qnaList(qvo);
			model.addAttribute("qnaList", qnaList);
			
			int total = qService.qnaListCnt(qvo);
			model.addAttribute("pageMaker", new PageDTO(qvo, total));
			
			return "admin/qna/aQnaList";
		}
		
		//AdminQnaDetail
		@RequestMapping(value="/aQnaDetail", method=RequestMethod.GET)
		public String aQnaDetail(@ModelAttribute("data") QnaVO qvo, Model model) {
			log.info("detail");
			QnaVO detail = aqService.aQnaDetail(qvo);
			model.addAttribute("detail", detail);
			
			return "admin/qna/aQnaDetail";
		}
		
		@RequestMapping(value="/aQnaDelete")
		public String aQnaDelete(@ModelAttribute QnaVO qvo, RedirectAttributes ras) throws Exception {
			log.info("aQnaDelete 호출 성공");
			
			int result = 0;
			String url = "";
			
			result = aqService.aQnaDelete(qvo);
			ras.addFlashAttribute("qnaVO", qvo);
			
			if(result == 1) {
				url="/admin/qna/qnaList";
			} else {
				url="/admin/qna/aQnaDetail";
			}
			
			return "redirect:" + url;
		}
		
}
