package com.petcation.admin.hotel.vo;


import org.springframework.web.multipart.MultipartFile;

import com.petcation.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class HotelVO extends CommonVO{
	private int 	hotel_no;
	private String 	hotel_name;
	private String 	hotel_info;
	private String 	hotel_address;
	private String 	hotel_tel;
	private int 	hotel_price;
	private String 	hotel_date;
	private int 	hotel_status;
	private int 	local_no;
	private String	local_name;
	
	private MultipartFile file;
	private String hotel_file		="";
	private String hotel_thumb		="";
}
