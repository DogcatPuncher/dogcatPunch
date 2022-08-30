package com.petcation.client;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petcation.admin.hotel.vo.HotelVO;
import com.petcation.admin.notice.vo.NoticeVO;
import com.petcation.client.community.vo.CommunityBoardVO;
import com.petcation.client.service.MainService;
import com.petcation.client.traveldiary.vo.DiaryVO;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class MainController {
	private MainService mainService;
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(@ModelAttribute("data") DiaryVO dvo, CommunityBoardVO cbvo, HotelVO hvo, NoticeVO unvo, Model model) {
		
		List<DiaryVO> mainDiaryList = mainService.mainDiaryList(dvo);
		model.addAttribute("mainDiaryList", mainDiaryList);
		System.out.println("���̾ ���� �������� ȣ�� ����");
		System.out.println(mainDiaryList);
		
		List<CommunityBoardVO> mainCommunityList = mainService.mainCommunityList(cbvo);
		model.addAttribute("mainCommunityList", mainCommunityList);
		System.out.println("Ŀ�´�Ƽ ����Ʈ ���� �������� ȣ�� ����");
		System.out.println(mainCommunityList);
		
		List<HotelVO> mainHotelList = mainService.mainHotelList(hvo);
		model.addAttribute("mainHotelList", mainHotelList);
		System.out.println("ȣ�ڸ���Ʈ ���� �������� ȣ�� ����");
		System.out.println(mainHotelList);
		
		List<NoticeVO> mainNoticeList = mainService.mainNoticeList(unvo);
		model.addAttribute("mainNoticeList", mainNoticeList);
		System.out.println("�������� ���� �������� ȣ�� ����");
		System.out.println(mainNoticeList);
		
		return "main"; 
	}
}
