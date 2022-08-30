package com.petcation.client.qnareply.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.petcation.client.qna.vo.QnaVO;
import com.petcation.client.qnareply.service.QreplyService;
import com.petcation.client.qnareply.vo.QreplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

	/***************************************************************************************
	 * ���� : REST(Representational State Transfer)�� ���� 
	 *      �ϳ��� URI�� �ϳ��� ������ ���ҽ��� ��ǥ�ϵ��� ����ȴٴ� �����̴�. 
	 *      �� REST����� Ư�� URL�� �ݵ�� �׿� �����ϴ� ������ ��ü��� ���� �ǹ��ϴ� ����̴�. 
	 *      ���� ��� 'board/125'�� �Խù� �߿��� 125���̶�� ������ �ǹ̸� �������� �����ϰ�, 
	 *      �̿� ���� ó���� GET, POST ��İ� ���� �߰����� ������ ���ؼ� �����Ѵ�.
	 ***************************************************************************************/


	/***************************************************************************************
	 * ���� : @RestController (@Controller + @ResponesBody)
	 * Controller�� REST ����� ó���ϱ� ���� ������ ���. (������ Ư���� JSP�� ���� �並 ����� 
	 * ���� ���� ������ �ƴ� REST ����� ������ ó���� ���ؼ� ����ϴ�(������ ��ü�� ��ȯ) ������̼��̴�.
	 * @ResponesBody: �Ϲ����� JSP�� ���� ��� ���޵Ǵ� �� �ƴ϶� ������ ��ü�� �����ϱ� ���� �뵵�̴�.
	 * @PathVariable: URL ��ο� �ִ� ���� �Ķ���ͷ� �����Ϸ��� �� �� ����Ѵ�.
	 * @RequestBody: JSON �����͸� ���ϴ� Ÿ������ ���ε� ó���Ѵ�.
	 ***************************************************************************************/

@RestController
@RequestMapping(value="/qreplies")
@Log4j
@AllArgsConstructor
public class QreplyController {

		private QreplyService replyService;

		/***************************************************************************************
		 * ��� �۸�� �����ϱ�
		 * @return List<ReplyVO>
		 * ���� : @PathVariable�� URI�� ��ο��� ���ϴ� �����͸� �����ϴ� �뵵�� ������̼�.
		 * ���� ���� Ÿ���� xml�̳� json���� ��ȯ�� ���� produces �Ӽ��� ����Ѵ�.
		 * produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE }
		 * ���� ��û URL : http://localhost:8080/qreplies/all/�Խ��Ǳ۹�ȣ
		 * ���� ��û URL : http://localhost:8080/qreplies/replyList?b_num=�Խ��Ǳ۹�ȣ
		 * ResponseEntity�� �����ڰ� ���� ��� �����Ϳ� HTTP ���� �ڵ带 ���� ������ �� �ִ� Ŭ����.
		 **************************************************************************************/
		/*
		@GetMapping(value = "/all/{b_num}", produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<List<ReplyVO>> replyList(@PathVariable("b_num") Integer b_num) {
			log.info("list ȣ�� ����");
			
			ResponseEntity<List<ReplyVO>> entity = null;
			entity = new ResponseEntity<>(replyService.replyList(b_num), HttpStatus.OK);
			return entity;
		}
		 * */
		
		@GetMapping(value = "/all/{b_num}", produces=MediaType.APPLICATION_JSON_VALUE)
		public List<QreplyVO> replyList(@PathVariable("b_num") Integer b_num) {
			log.info("list ȣ�� ����");
			
			
			
			List<QreplyVO> entity = null;
			entity = replyService.replyList(b_num);
			return entity;
		} 
		
		@PostMapping(value = "/replyInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
		public String replyInsert(@RequestBody QreplyVO rvo, QnaVO qvo) {
			log.info("replyInsert ȣ�� ����");
			log.info("ReplyVO : " + rvo);
			
			
			int result = 0;
			result = replyService.replyInsert(rvo);
			return (result==1) ? "SUCCESS" : "FAILURE";
		}
		
		/*
		@DeleteMapping(value="/{r_num}", produces = MediaType.TEXT_PLAIN_VALUE )
		public ResponseEntity<String> replyDelete(@PathVariable("r_num") Integer r_num) {
			log.info("replayDelete ȣ�� ����");
			log.info("r_num = " + r_num);
			
			int result = replyService.replyDelete(r_num);
			return result==1 ?
						new ResponseEntity<String>("SUCCESS", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		*/
		
		@DeleteMapping(value = "/{r_num}", produces = MediaType.TEXT_PLAIN_VALUE)
		public String replyDelete(@PathVariable("r_num") int r_num) {
			log.info("replyDelete ȣ�� ����");
			log.info("r_num = " + r_num);
			
			int result = replyService.replyDelete(r_num);
			return (result==1) ? "SUCCESS" : "FAILURE";
		}
		
		@PutMapping(value = "/{r_num}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
		public String replyUpdate(@PathVariable("r_num") int r_num, @RequestBody QreplyVO rvo) {
				log.info("replyUpdate ȣ�� ����");
				
				rvo.setR_num(r_num);
				int result = replyService.replyUpdate(rvo);
				return (result==1) ? "SUCCESS" : "FAILURE";
		}
	}

