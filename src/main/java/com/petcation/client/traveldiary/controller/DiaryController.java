package com.petcation.client.traveldiary.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.petcation.client.join.vo.MemberVO;
import com.petcation.client.traveldiary.service.DiaryService;
import com.petcation.client.traveldiary.vo.DiaryVO;
import com.petcation.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/diary/")
@AllArgsConstructor
public class DiaryController {
   
   private DiaryService diaryService;
   

	 @RequestMapping(value="/diaryBoardList", method = RequestMethod.GET) 
	 public String diaryBoardList(@ModelAttribute("data") DiaryVO dvo,MemberVO member, HttpServletRequest request, Model model) {
		 log.info("diaryBoardList ȣ�� ����");
		 
		 String url="";
		 
		 HttpSession session = request.getSession();
		 
		 MemberVO userID =(MemberVO)session.getAttribute("lmember");
		 
		 	if(userID!=null) {
		 		session.setAttribute("lmember", userID); 
				 System.out.println(userID);
				 dvo.setUser_id(userID.getUser_id()); 
				 
				 List<DiaryVO> diaryList = diaryService.diaryList(dvo);
				 System.out.println(diaryList); 
				 model.addAttribute("diaryBoardList",diaryList); 
				 
				 int total = diaryService.diaryListCnt(dvo);
				 model.addAttribute("pageMaker", new PageDTO(dvo, total));
				 
				 url = "diary/diaryBoardList";
		 	} else {
		 		url="member/login";
		 		String msg="�α��� �� �̿����ּ���";
		 		
		 	}
		 return url;
	 }

   
	/*
	 * @RequestMapping(value="/diaryBoardList", method = RequestMethod.GET) public
	 * String diaryBoardList(@ModelAttribute("data") CommonVO cvo ,MemberVO member,
	 * HttpServletRequest request, Model model) { log.info("diaryBoardList ȣ�� ����");
	 * List<DiaryVO> diaryList = diaryService.diaryList(cvo);
	 * System.out.println(diaryList); HttpSession session = request.getSession();
	 * MemberVO userID =(MemberVO)session.getAttribute("lmember");
	 * session.setAttribute("lmember", userID); System.out.println(userID);
	 * cvo.setUser_id(userID.getUser_id()); model.addAttribute("diaryList",
	 * diaryList); return "diary/diaryBoardList";
	 * 
	 * }
	 */
   @RequestMapping(value="/diaryBoardWrite")
   public String diaryBoardWrite(@ModelAttribute("data")DiaryVO dvo,MemberVO member, HttpServletRequest request, Model model) {
	   log.info("write ȣ�� ����");
		/* dvo.setUser_no(1); */
	   HttpSession session = request.getSession();
	   MemberVO userID =(MemberVO)session.getAttribute("lmember");
	   session.setAttribute("lmember", userID);
	   System.out.println(userID);
	   dvo.setUser_id(userID.getUser_id());
	   return "diary/diaryBoardWrite";
   }
   
   @RequestMapping(value="/diaryBoardDetail",method=RequestMethod.GET)
	public String boardDetail(@ModelAttribute("data")DiaryVO dvo,MemberVO member, HttpServletRequest request, Model model) {
		log.info("boardDetail ȣ�� ����");
		
		DiaryVO detail = diaryService.diaryDetail(dvo);
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		dvo.setUser_id(userID.getUser_id());
		model.addAttribute("detail",detail);
		System.out.println(detail);
		return "diary/diaryBoardDetail";
	}
   @RequestMapping(value="/boardInsert", method=RequestMethod.POST)
	public String boardInsert(DiaryVO dvo,MemberVO member, HttpServletRequest request, Model model) throws Exception{
		log.info("boardInsert ȣ�� ����");
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		dvo.setUser_id(userID.getUser_id());
		/* log.info("vo : "+dvo); */
		int result = 0;
		String url = "";
		
		/*���ǰ����� ��ü*/
		/* dvo.setUser_no(1); */
		
		result = diaryService.diaryInsert(dvo);
		if(result ==1) {
			url = "/diary/diaryBoardList";
		}else {
			url = "/diary/diaryBoardWrite";
		}
		return "redirect:"+url;
	}
   @RequestMapping(value="/diaryDelete")
	public String diaryDelete(@ModelAttribute("data")DiaryVO dvo,MemberVO member, HttpServletRequest request, RedirectAttributes ras) throws Exception{

		int result = 0;
		String url ="";
		
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		dvo.setUser_id(userID.getUser_id());
		
		result = diaryService.diaryDelete(dvo);
		ras.addFlashAttribute("DiaryVO",dvo);
		
		if(result ==1) {
			url="/diary/diaryBoardList";
		}else {
			url="/diary/diaryBoardDetail";
		}
		return "redirect:"+url;
	}
   
   @RequestMapping(value="/diaryBoardUpdate")
	public String updateForm(@ModelAttribute("data") DiaryVO dvo, MemberVO member, HttpServletRequest request,Model model) {
		log.info("updateForm ȣ�� ����");
		log.info("d_no = "+dvo.getD_no());
		
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		dvo.setUser_id(userID.getUser_id());
		
		DiaryVO updateData = diaryService.updateForm(dvo);
		
		model.addAttribute("updateData",updateData);
		return "diary/diaryBoardUpdate";
	}
   @RequestMapping(value="/diaryUpdate",method=RequestMethod.POST)
	public String boardUpdate(@ModelAttribute DiaryVO dvo,MemberVO member, HttpServletRequest request, RedirectAttributes ras) throws Exception{
		log.info("diaryUpdate ȣ�⼺��");
		
		int result = 0;
		String url = "";
		
		HttpSession session = request.getSession();
		MemberVO userID =(MemberVO)session.getAttribute("lmember");
		session.setAttribute("lmember", userID);
		System.out.println(userID);
		dvo.setUser_id(userID.getUser_id());
		
		result = diaryService.diaryUpdate(dvo);
		ras.addFlashAttribute("data",dvo);
		
		if(result == 1) {
			url="/diary/diaryBoardDetail?d_no="+dvo.getD_no();
		}else {
			url="/diary/diaryBoardUpdate?d_no"+dvo.getD_no();
		}
		return "redirect:"+url;
	}
   
   @RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
   @ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
       /*
		 * String fileRoot = "C:\\summernote_image\\"; // �ܺΰ�η� ������ ����Ҷ�.
		 */
		
		// ���ΰ�η� ����
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/fileupload/";
		
		String originalFileName = multipartFile.getOriginalFilename();	//�������� ���ϸ�
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//���� Ȯ����
		String savedFileName = UUID.randomUUID() + extension;	//����� ���� ��
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//���� ����
			jsonObject.addProperty("url", "/resources/fileupload/"+savedFileName); // contextroot + resources + ������ ���� ������
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//����� ���� ����
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}

}