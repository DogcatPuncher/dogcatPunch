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
	
	//���� ���� �޼ҵ�
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) {
			return;
		}
		fileDir.mkdirs();
	}
	
	//���Ͼ��ε� �޼ҵ�
	public static String fileUpload(MultipartFile file, String fileName) throws IOException{
		log.info("fileUpload ȣ�� ����");
		
		String real_name = null;
		String org_name = file.getOriginalFilename();
		log.info("���ε� ���ϸ� : " +org_name);
		
		//���ϸ� ����
		if(org_name !=null && (!org_name.equals(""))) {
			real_name = fileName + "_"+System.currentTimeMillis()+"_"+org_name; //������ ���� �̸�
			
			String docRoot = "C://petcationStorage//"+fileName;
			makeDir(docRoot);
			
			File fileUpload = new File(docRoot+"/"+real_name);
			log.info("���ε��� ����(fileUpload) : " +fileUpload);
			
			file.transferTo(fileUpload);
		}
		return real_name;
	}
	
	//���� ����
	public static void fileDelete(String fileName) throws IOException{
		log.info("fileDelete ȣ�� ����");
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
		log.info("���� ���� ���� : "+result);
	}
	
	//����� ���� �޼���
	public static String makeThumbnail(String fileName) throws Exception{
		String dirName = fileName.substring(0,fileName.indexOf("_"));
		
		String imgPath = "C://petcationStorage//"+dirName;
		File fileUpload = new File(imgPath,fileName);
		log.info("���� �̹��� ���� : "+ fileUpload);
		
		BufferedImage sourceImg = ImageIO.read(fileUpload);
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,133);
	
		String thumbnailName = "thumbnail_"+fileName;
		String docRoot = imgPath+"/thumbnail";
		makeDir(docRoot);
		
		File newFile = new File(docRoot,thumbnailName);
		log.info("���ε��� ����(newFile) : "+newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		log.info("Ȯ����(formatName) : "+formatName);
		
		ImageIO.write(destImg, formatName, newFile); //������ �̹��� �����͸� ������ ���Ͽ� ����
		return thumbnailName; //������ ����� ���ϸ� ��ȯ
	}
	
}
