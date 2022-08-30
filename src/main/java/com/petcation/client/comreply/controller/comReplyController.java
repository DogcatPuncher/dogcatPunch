package com.petcation.client.comreply.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.petcation.client.comreply.service.comReplyService;
import com.petcation.client.comreply.vo.comReplyVO;
import com.petcation.client.join.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping(value="/replies")
@Log4j
@AllArgsConstructor
public class comReplyController {
	
	private comReplyService comreplyService;
	
	@GetMapping(value = "/all/{b_no}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<comReplyVO> replyList(@PathVariable("b_no") Integer b_no,@ModelAttribute("data") comReplyVO crvo, MemberVO member, HttpServletRequest request, Model model){
		System.out.println("replyList 호출 성공");
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		crvo.setUser_id(userID.getUser_id());
		List<comReplyVO> entity = null;
		entity = comreplyService.replyList(b_no);
		System.out.println(entity);
		return entity;
	}
	
	@PostMapping(value="/replyInsert",consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyInsert(@RequestBody comReplyVO crvo,@ModelAttribute("data") MemberVO member, HttpServletRequest request, Model model) {
		
		System.out.println("replyInsert 호출 성공");
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		crvo.setUser_id(userID.getUser_id());
		log.info("comReplyVO : "+crvo);
		
		int result = 0;
		
		result = comreplyService.replyInsert(crvo);
		return(result ==1)? "SUCCESS" : "FAILURE";
	}
	
	@PutMapping(value = "/{com_rno}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyUpdate(@PathVariable("com_rno") Integer com_rno, @RequestBody comReplyVO crvo) {
		log.info("replyUpdate 호출 성공");
		log.info("com_rno="+com_rno);
		crvo.setCom_rno(com_rno);
		int result = comreplyService.replyUpdate(crvo);
		return(result ==1) ? "SUCCESS" : "FAILURE";
	}
	
	@DeleteMapping(value = "/{com_rno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> replyDelete(@PathVariable("com_rno")Integer com_rno){
		log.info("replyDelete 호출 성공");
		log.info("com_rno="+com_rno);
		int result = comreplyService.replyDelete(com_rno);
		return result == 1?
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK) :new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);	
	}
}
