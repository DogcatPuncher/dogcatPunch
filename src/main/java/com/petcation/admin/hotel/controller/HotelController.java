package com.petcation.admin.hotel.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

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
import com.petcation.admin.hotel.service.HotelService;
import com.petcation.admin.hotel.vo.HotelVO;
import com.petcation.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/hotel/*")
@AllArgsConstructor
public class HotelController {
	
	private HotelService hotelService;
	
	@RequestMapping(value = "/hotelList")
	public String hotelList(@ModelAttribute("data") HotelVO hvo, Model model) {
		List<HotelVO> hotelList = hotelService.hotelList(hvo);
		int total = hotelService.hotelListCnt(hvo);
		model.addAttribute("pageMaker", new PageDTO(hvo, total));
		model.addAttribute("hotelList", hotelList);
		
		System.out.println(hotelList);
		return "admin/hotel/hotelList";
	}
	
	@RequestMapping(value = "/hotelDetail", method = RequestMethod.GET)
	public String hotelDetail(@ModelAttribute("data") HotelVO hvo, Model model) {
		
		HotelVO detail = hotelService.hotelDetail(hvo);
		log.info(detail);
		model.addAttribute("detail", detail);
			
		return "admin/hotel/hotelDetail";
		}	
	
	@RequestMapping(value = "/hotelWrite")
	public String hotelWrite() {
		return "admin/hotel/hotelWrite";
	}
	
	
	@RequestMapping(value = "/hotelInsert", method = RequestMethod.POST)
	public String hotelInsert(HotelVO hvo, Model model) throws Exception {
	
		int result = 0;
		String url = "";
		
		result = hotelService.hotelInsert(hvo);
		if(result == 1) {
			url = "/admin/hotel/hotelList";
		}else {
			url = "/admin/hotel/writeForm";
		}
		
		return "redirect:" + url;
	}
	
	@RequestMapping(value = "/hotelDelete")
	public String hotelDelete(@ModelAttribute HotelVO hvo, RedirectAttributes ras) throws Exception{
		int result = 0;
		String url = "";
		
		//result = boardService.boardDelete(bvo.getB_num());
		result = hotelService.hotelDelete(hvo);
		ras.addFlashAttribute("HotelVO", hvo);
		
		System.out.println(result); // 이거 안됨 !
		
		if(result == 1) {
			url = "/admin/hotel/hotelList";
		}else {
			url = "/admin/hotel/hotelDetail?hotel_no=" + hvo.getHotel_no(); 
		}
		
		return "redirect:" + url;
	}
	
	@RequestMapping(value = "/updateForm")
	public String updateForm(@ModelAttribute("data")HotelVO hvo, Model model) {
		log.info(hvo.toString());
		HotelVO updateData = hotelService.updateForm(hvo);
		
		model.addAttribute("updateData", updateData);
		return "admin/hotel/updateForm";
	}
	
	@RequestMapping(value="/hotelUpdate", method=RequestMethod.POST)
	public String hotelUpdate(@ModelAttribute HotelVO hvo, RedirectAttributes ras) throws Exception{
		//log.info("boardUpdate 호출성공");
		
		int result = 0;
		String url = "";
		
		result = hotelService.hotelUpdate(hvo);
		System.out.println(result);
		/* ras.addAttribute("data", hvo); */
		
		if(result == 1) {
			//아래 url은 수정 후 상세 페이지로 이동
			//url="board/boardDetail?b_num="+bvo.getB_num()
			url = "/admin/hotel/hotelDetail?hotel_no="+hvo.getHotel_no();
		}else {
			//url="/board/updateForm?b_num="+bvo.getB_num();
			url = "/admin/hotel/updateForm";
		}
		
		return "redirect:"+url;
	}
	
	 @RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	   @ResponseBody
		public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
			JsonObject jsonObject = new JsonObject();
			
	       /*
			 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
			 */
			
			// 내부경로로 저장
			String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
			String fileRoot = contextRoot+"resources/fileupload/";
			
			String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
			String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
			
			File targetFile = new File(fileRoot + savedFileName);	
			try {
				InputStream fileStream = multipartFile.getInputStream();
				FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
				jsonObject.addProperty("url", "/resources/fileupload/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
				jsonObject.addProperty("responseCode", "success");
					
			} catch (IOException e) {
				FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
				jsonObject.addProperty("responseCode", "error");
				e.printStackTrace();
			}
			String a = jsonObject.toString();
			return a;
		}
}
