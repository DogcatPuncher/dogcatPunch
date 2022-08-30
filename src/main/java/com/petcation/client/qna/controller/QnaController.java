//package com.petcation.client.qna.controller;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import lombok.AllArgsConstructor;
//import lombok.extern.log4j.Log4j;
//
//@Controller
//@Log4j
//@RequestMapping("/qna/*")
//@AllArgsConstructor
//public class QnaController {
//	// 회원가입 페이지 이동
//	@RequestMapping(value = "qnaList", method = RequestMethod.GET)
//	public void qnaListGET() {
//		log.info("QnA 목록 진입");
//	}
//	@RequestMapping(value = "qnaDetail", method = RequestMethod.GET)
//	public void qnaDetailGET() {
//		log.info("QnA 상세페이지 진입");
//	}
//	@RequestMapping(value = "qnaUpdate", method = RequestMethod.GET)
//	public void qnaUpdateGET() {
//		log.info("QnA 수정 진입");
//	}
//	@RequestMapping(value = "qnaWrite", method = RequestMethod.GET)
//	public void qnaWriteGET() {
//		log.info("QnA 글쓰기 진입");
//	}
//	@RequestMapping(value = "adminReply", method = RequestMethod.GET)
//	public void adminReplyGET() {
//		log.info("QnA 목록 진입");
//	}
//
//}

package com.petcation.client.qna.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petcation.client.join.vo.MemberVO;
import com.petcation.client.qna.service.QnaService;
import com.petcation.client.qna.vo.QnaVO;
import com.petcation.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/qna/*")
@AllArgsConstructor
public class QnaController {
	
	private QnaService qnaService;
	
	/*
	@RequestMapping(value="/qnaList", method=RequestMethod.GET)
	public String qnaList(@ModelAttribute QnaVO qvo, Model model) {
		log.info("qnaList 호출 성공");
		
		List<QnaVO> qnaList = qnaService.qnaList(qvo);
		model.addAttribute("qnaList", qnaList);
		
		return "qna/qnaList";
	}
	 * */
	
	@RequestMapping(value="/qnaList", method=RequestMethod.GET)
	public String qnaList(@ModelAttribute QnaVO qvo, Model model) {
		log.info("qnaList 호출 성공");
		
		
		List<QnaVO> qnaList = qnaService.qnaList(qvo);
		model.addAttribute("qnaList", qnaList);
		
		int total = qnaService.qnaListCnt(qvo);
		model.addAttribute("pageMaker", new PageDTO(qvo, total));
		
		return "qna/qnaList";
	}
	
	@RequestMapping(value="/qnaWrite")
	public String writeForm(@ModelAttribute("data") QnaVO qvo) {
		log.info("writeForm 호출 성공");
		
		return "qna/qnaWrite";
	}
	
	@RequestMapping(value="/qnaWrite", method=RequestMethod.POST)
	public String qnaWrite(QnaVO qvo, Model model) throws Exception{
		log.info("qnaWrite 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = qnaService.qnaWrite(qvo);
		
		log.info(result);
		if(result == 1) {
			url = "/qna/qnaDetail?q_num="+qvo.getQ_num();
		} else {
			url = "/qna/qnaWrite";
		}
		
		return "redirect:" + url;
	}
	
	@RequestMapping(value="/qnaDetail", method=RequestMethod.GET)
	public String qnaDetail(@ModelAttribute("data") QnaVO qvo, Model model) {
		log.info("qnaDetail 호출 성공");
		
		QnaVO detail = qnaService.qnaDetail(qvo);
		model.addAttribute("detail", detail);
		
		return "qna/qnaDetail";
	}
	@RequestMapping(value="/replyDetail", method=RequestMethod.GET)
	public String replyDetail(@ModelAttribute("data") QnaVO qvo, Model model) {
		log.info("qnaDetail 호출 성공");
		
		QnaVO detail = qnaService.qnaDetail(qvo);
		model.addAttribute("detail", detail);
		
		return "qna/replyDetail";
	}
	
	/*
	 * 비밀번호 확인
	 * @param q_num
	 * @param q_pwd
	 * @return int로 result를 0또는 1로	 리턴할 수도 있고
	 * String로 result 값을 '성공 or 실패, 일치 or 불일치'를 리턴할 수도 있다. (현재 문자열 리턴)
	 * 참고 : @
	 * */
	@ResponseBody
	@RequestMapping(value="/pwdConfirm", method=RequestMethod.POST, produces = "text/plain; charset=UTF-8")
	public String pwdConfirm(QnaVO qvo) {
		log.info("pwdConfirm 호출 성공");
		String value="";
		
		int result = qnaService.pwdConfirm(qvo);
		if(result==1) {
			value="성공";
		} else {
			value="실패";
		}
		log.info("result = " + result);
		
		return value;
				
	}
	
	@RequestMapping(value="/qnaUpdateForm")
	public String updateForm(@ModelAttribute("data") QnaVO qvo, Model model) {
		log.info("qnaUpdateForm 호출 성공");
		log.info("q_num = " + qvo.getQ_num());
		
		QnaVO updateData = qnaService.updateForm(qvo);
		
		model.addAttribute("updateData", updateData);
		return "qna/qnaUpdateForm";
	}

	@RequestMapping(value="/adminReplyForm")
	public String adminReplyForm(@ModelAttribute("data") QnaVO qvo, Model model) {
		log.info("adminReplyForm 호출 성공");
		log.info("q_num = " + qvo.getQ_num());
		
		QnaVO replyData = qnaService.updateForm(qvo);
		
		model.addAttribute("replyData", replyData);
		return "qna/adminReplyForm";
	}
	
	@RequestMapping(value="/qnaUpdate", method=RequestMethod.POST)
	public String qnaUpdate(@ModelAttribute QnaVO qvo, RedirectAttributes ras) throws Exception {
		log.info("qnaUpdate 호출 성공");
		
		int result=0;
		String url="";
		
		result = qnaService.qnaUpdate(qvo);
		ras.addFlashAttribute("data", qvo);
		
		if(result == 1) {
			url = "/qna/qnaDetail?q_num="+qvo.getQ_num();
		} else {
			url = "/qna/qnaList";
		}
		
		return "redirect:"+url;
	}

	@RequestMapping(value="/replyInsert", method=RequestMethod.POST)
	public String replyInsert(@ModelAttribute QnaVO qvo, RedirectAttributes ras) throws Exception {
		log.info("replyInsert 호출 성공");
		
		int result=0;
		String url="";
		
		qnaService.makeReply(qvo);
		result = qnaService.replyInsert(qvo);
		ras.addFlashAttribute("data", qvo);
		
		log.info(qvo);
		log.info("result : " + result);
		
		if(result == 1) {
			url = "/qna/qnaList";
		} else {
			url = "/qna/adminReplyForm?num="+qvo.getQ_num()+"&code=1";
		}
		
		return "redirect:"+url;
	}
	
	
	
	@RequestMapping(value="/qnaDelete")
	public String qnaDelete(@ModelAttribute QnaVO qvo, RedirectAttributes ras) throws Exception {
		log.info("qnaDelete 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = qnaService.qnaDelete(qvo);
		ras.addFlashAttribute("qnaVO", qvo);
		
		if(result == 1) {
			url="/qna/qnaList";
		} else {
			url="/qna/qnaDetail";
		}
		
		return "redirect:" + url;
	}
	
	@ResponseBody
	@RequestMapping(value="/replyCnt")
	public String replyCnt(@RequestParam("q_num") int q_num) {
		log.info("replyCnt 호출 성공");
		
		int result = 0;
		result = qnaService.replyCnt(q_num);
		
		//return result+"";
		return String.valueOf(result);
	}
}
