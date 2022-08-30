package com.petcation.common.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileUploadUtil {
	
	//폴더 생성 메소드
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) {
			return;
		}
		fileDir.mkdirs();
	}
	
	//파일업로드 메소드
	public static String fileUpload(MultipartFile file, String fileName) throws IOException{
		log.info("fileUpload 호출 성공");
		
		String real_name = null;
		String org_name = file.getOriginalFilename();
		log.info("업로드 파일명 : " +org_name);
		
		//파일명 변경
		if(org_name !=null && (!org_name.equals(""))) {
			real_name = fileName + "_"+System.currentTimeMillis()+"_"+org_name; //저장할 파일 이름
			
			String docRoot = "C://petcationStorage//"+fileName;
			makeDir(docRoot);
			
			File fileUpload = new File(docRoot+"/"+real_name);
			log.info("업로드할 파일(fileUpload) : " +fileUpload);
			
			file.transferTo(fileUpload);
		}
		return real_name;
	}
	
	//파일 삭제
	public static void fileDelete(String fileName) throws IOException{
		log.info("fileDelete 호출 성공");
		boolean result = false;
		String startDirName = "",docRoot="";
		String dirName = fileName.substring(0, fileName.indexOf("_"));
		
		if(dirName.equals("thumbnail")) {
			startDirName = fileName.substring(dirName.length()+1, fileName.indexOf("_",dirName.length()+1));
			docRoot = "C://petcationStorage//"+startDirName+"//"+dirName;
		}else {
			docRoot = "C://petcationStorage//"+dirName;
		}
		File fileDelete = new File(docRoot+"/"+fileName);
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("파일 삭제 여부 : "+result);
	}
	
	//썸네일 생성 메서드
	public static String makeThumbnail(String fileName) throws Exception{
		String dirName = fileName.substring(0,fileName.indexOf("_"));
		
		String imgPath = "C://petcationStorage//"+dirName;
		File fileUpload = new File(imgPath,fileName);
		log.info("원본 이미지 파일 : "+ fileUpload);
		
		BufferedImage sourceImg = ImageIO.read(fileUpload);
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,133);
	
		String thumbnailName = "thumbnail_"+fileName;
		String docRoot = imgPath+"/thumbnail";
		makeDir(docRoot);
		
		File newFile = new File(docRoot,thumbnailName);
		log.info("업로드할 파일(newFile) : "+newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		log.info("확장자(formatName) : "+formatName);
		
		ImageIO.write(destImg, formatName, newFile); //조정한 이미지 데이터를 생성한 파일에 저장
		return thumbnailName; //서버에 저장된 파일명 반환
	}
	
}
