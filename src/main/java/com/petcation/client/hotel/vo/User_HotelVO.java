package com.petcation.client.hotel.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class User_HotelVO {
	private int 	hotel_no;
	private String 	hotel_name;
	private String 	hotel_info;
	private String 	hotel_address;
	private String 	hotel_tel;
	private int 	hotel_price;
	private String 	hotel_date;
	private int 	hotel_status;
	private int 	local_no;
	
	private MultipartFile file;
	private String hotel_file      ="";
	private String hotel_thumb      ="";
}
