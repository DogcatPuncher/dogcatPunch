package com.petcation.client.diaryreply.controller;

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

import com.petcation.client.diaryreply.service.diaryReplyService;
import com.petcation.client.diaryreply.vo.diaryReplyVO;
import com.petcation.client.join.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping(value="/diaryreplies")
@Log4j
@AllArgsConstructor
public class diaryReplyController {
	
	private diaryReplyService diaryreplyService;
	
	@GetMapping(value = "/all/{d_no}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<diaryReplyVO> replyList(@PathVariable("d_no") Integer d_no,@ModelAttribute("data") diaryReplyVO drvo, MemberVO member, HttpServletRequest request, Model model){
		System.out.println("replyList 호출 성공");
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		drvo.setUser_id(userID.getUser_id());
		List<diaryReplyVO> entity = null;
		entity = diaryreplyService.diaryReplyList(d_no);
		System.out.println("entityList"+entity);
		return entity;
	}
	
	@PostMapping(value="/replyInsert",consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyInsert(@RequestBody diaryReplyVO drvo,@ModelAttribute("data") MemberVO member, HttpServletRequest request, Model model) {
		System.out.println("replyInsert 호출 성공");
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		drvo.setUser_id(userID.getUser_id());
		log.info("diaryReplyVO : "+drvo);
		
		int result = 0;
		
		result = diaryreplyService.replyInsert(drvo);
		return(result ==1)? "SUCCESS" : "FAILURE";
	}
	@PutMapping(value = "/{diary_rno}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyUpdate(@PathVariable("diary_rno") Integer diary_rno, @RequestBody diaryReplyVO drvo) {
		log.info("replyUpdate 호출 성공");
		log.info("diary_rno="+diary_rno);
		drvo.setDiary_rno(diary_rno);
		int result = diaryreplyService.replyUpdate(drvo);
		return(result ==1) ? "SUCCESS" : "FAILURE";
	}
	@DeleteMapping(value = "/{diary_rno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> replyDelete(@PathVariable("diary_rno")Integer diary_rno){
		log.info("replyDelete 호출 성공");
		log.info("diary_rno="+diary_rno);
		int result = diaryreplyService.replyDelete(diary_rno);
		return result == 1?
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK) :new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);	
	}
	
}
