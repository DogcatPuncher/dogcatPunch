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
//	// ȸ������ ������ �̵�
//	@RequestMapping(value = "qnaList", method = RequestMethod.GET)
//	public void qnaListGET() {
//		log.info("QnA ��� ����");
//	}
//	@RequestMapping(value = "qnaDetail", method = RequestMethod.GET)
//	public void qnaDetailGET() {
//		log.info("QnA �������� ����");
//	}
//	@RequestMapping(value = "qnaUpdate", method = RequestMethod.GET)
//	public void qnaUpdateGET() {
//		log.info("QnA ���� ����");
//	}
//	@RequestMapping(value = "qnaWrite", method = RequestMethod.GET)
//	public void qnaWriteGET() {
//		log.info("QnA �۾��� ����");
//	}
//	@RequestMapping(value = "adminReply", method = RequestMethod.GET)
//	public void adminReplyGET() {
//		log.info("QnA ��� ����");
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
		log.info("qnaList ȣ�� ����");
		
		List<QnaVO> qnaList = qnaService.qnaList(qvo);
		model.addAttribute("qnaList", qnaList);
		
		return "qna/qnaList";
	}
	 * */
	
	@RequestMapping(value="/qnaList", method=RequestMethod.GET)
	public String qnaList(@ModelAttribute QnaVO qvo, Model model) {
		log.info("qnaList ȣ�� ����");
		
		
		List<QnaVO> qnaList = qnaService.qnaList(qvo);
		model.addAttribute("qnaList", qnaList);
		
		int total = qnaService.qnaListCnt(qvo);
		model.addAttribute("pageMaker", new PageDTO(qvo, total));
		
		return "qna/qnaList";
	}
	
	@RequestMapping(value="/qnaWrite")
	public String writeForm(@ModelAttribute("data") QnaVO qvo) {
		log.info("writeForm ȣ�� ����");
		
		return "qna/qnaWrite";
	}
	
	@RequestMapping(value="/qnaWrite", method=RequestMethod.POST)
	public String qnaWrite(QnaVO qvo, Model model) throws Exception{
		log.info("qnaWrite ȣ�� ����");
		
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
		log.info("qnaDetail ȣ�� ����");
		
		QnaVO detail = qnaService.qnaDetail(qvo);
		model.addAttribute("detail", detail);
		
		return "qna/qnaDetail";
	}
	@RequestMapping(value="/replyDetail", method=RequestMethod.GET)
	public String replyDetail(@ModelAttribute("data") QnaVO qvo, Model model) {
		log.info("qnaDetail ȣ�� ����");
		
		QnaVO detail = qnaService.qnaDetail(qvo);
		model.addAttribute("detail", detail);
		
		return "qna/replyDetail";
	}
	
	/*
	 * ��й�ȣ Ȯ��
	 * @param q_num
	 * @param q_pwd
	 * @return int�� result�� 0�Ǵ� 1��	 ������ ���� �ְ�
	 * String�� result ���� '���� or ����, ��ġ or ����ġ'�� ������ ���� �ִ�. (���� ���ڿ� ����)
	 * ���� : @
	 * */
	@ResponseBody
	@RequestMapping(value="/pwdConfirm", method=RequestMethod.POST, produces = "text/plain; charset=UTF-8")
	public String pwdConfirm(QnaVO qvo) {
		log.info("pwdConfirm ȣ�� ����");
		String value="";
		
		int result = qnaService.pwdConfirm(qvo);
		if(result==1) {
			value="����";
		} else {
			value="����";
		}
		log.info("result = " + result);
		
		return value;
				
	}
	
	@RequestMapping(value="/qnaUpdateForm")
	public String updateForm(@ModelAttribute("data") QnaVO qvo, Model model) {
		log.info("qnaUpdateForm ȣ�� ����");
		log.info("q_num = " + qvo.getQ_num());
		
		QnaVO updateData = qnaService.updateForm(qvo);
		
		model.addAttribute("updateData", updateData);
		return "qna/qnaUpdateForm";
	}

	@RequestMapping(value="/adminReplyForm")
	public String adminReplyForm(@ModelAttribute("data") QnaVO qvo, Model model) {
		log.info("adminReplyForm ȣ�� ����");
		log.info("q_num = " + qvo.getQ_num());
		
		QnaVO replyData = qnaService.updateForm(qvo);
		
		model.addAttribute("replyData", replyData);
		return "qna/adminReplyForm";
	}
	
	@RequestMapping(value="/qnaUpdate", method=RequestMethod.POST)
	public String qnaUpdate(@ModelAttribute QnaVO qvo, RedirectAttributes ras) throws Exception {
		log.info("qnaUpdate ȣ�� ����");
		
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
		log.info("replyInsert ȣ�� ����");
		
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
		log.info("qnaDelete ȣ�� ����");
		
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
		log.info("replyCnt ȣ�� ����");
		
		int result = 0;
		result = qnaService.replyCnt(q_num);
		
		//return result+"";
		return String.valueOf(result);
	}
}
