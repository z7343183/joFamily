/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package jo.pic.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jo.main.util.ImageUtil;
import jo.pic.dao.PicDAO;
import jo.pic.service.PicService;

import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.Java2DFrameConverter;
import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Method;
import org.imgscalr.Scalr.Rotation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiException;
import com.sun.jimi.core.JimiUtils;
import com.sun.xml.internal.bind.CycleRecoverable.Context;

import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;


/**
 * @Class Name : EgovSampleServiceImpl.java
 * @Description : Sample Business Implement Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Service("picService")
public class PicServiceImpl extends EgovAbstractServiceImpl implements PicService {

	private static final Logger LOGGER = LoggerFactory.getLogger(PicServiceImpl.class);

	/** SampleDAO */
	// TODO ibatis 사용
	@Resource(name = "picDAO")
	private PicDAO picDAO;
	
	 
	
	private String getSuperPath() throws Exception{
		String path = "";
		InetAddress inet= InetAddress.getLocalHost();
		if(inet.getHostName().equals("wk1-PC")){
			path = "z:/사진";
		}else{			
			path = "/mnt/hdd/사진";
		}
		
		return path;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List selectPicList(Map map,  HttpServletRequest req) throws Exception {
		
		String path = getSuperPath();
		List list = new ArrayList();
		List dir = getParDirList(list, path, req);		
		return dir;		
	}	
	public List getParDirList(List list,String path, HttpServletRequest req) throws Exception {		
		File myDir = new File(path);
		File[] contents = myDir.listFiles();
		String thumbnailPath = req.getSession().getServletContext().getRealPath("/images/jo/myPic/thumbnail/");
		for(int i = 0; i < contents.length; i++){			
			boolean chk = !contents[i].isDirectory()? false: !contents[i].isHidden()?true:false;
			if(chk==true){								
				Map<String, String> map = new HashMap<String, String>();
				//map.put("superPath", path);				
				String subPath = contents[i].getName();
				if(subPath.indexOf("20")==-1 ) continue;
				//map.put("thisPath", subPath);
				///int idx =  subPath.indexOf(" ");
				//map.put("thisDate", subPath.substring(0, idx ));
				//map.put("thisStr", subPath.substring(idx+1));
				String firstJpg = findFistJpg(contents[i].getPath(), list);				
				String tpath = thumbnailPath +"/"+subPath.replace(" ","_")+".jpg"; 
				if(!new File (tpath).exists()){ //썸네일 생성
					try {
						if(!firstJpg.equals("") )
						imageResize(firstJpg, tpath,"jpg", "small");
					} catch (Exception e) {
						e.printStackTrace();
					}						
				}
				if(!firstJpg.equals("") ){ 
					map.put("jpgPath", subPath.replace(" ","_")+".jpg");
				}
			}			
		}		
		return list;		
	}
		
	public String findFistJpg(String path, List list) throws Exception {		
		File myDir = new File(path);
		String imgRootPath = getSuperPath();  
		
		if(null==path||path.equals("")){
			return "";
		}
		File[] contents = myDir.listFiles();
		String firstJpg  = "";
		String chkJpg  = "";
		Map map = new HashMap();
		String vpath = path.replace("\\", "/");
		String spath = myDir.getParent().replace("\\", "/");
		String thisPath = vpath.replace(spath+"/", "");
		String superPath = spath.replace(imgRootPath, "").replace("/","");
		map.put("superPath", superPath);
		map.put("thisPath",  thisPath);
		map.put("fullPath",  vpath.replace(imgRootPath+"/", ""));
		
		for(int i = 0; i < contents.length; i++){			
			boolean chk = !contents[i].isDirectory()? false: !contents[i].isHidden()?true:false; 			
			if(chk==true){						
				chkJpg = this.findFistJpg(contents[i].getPath(), list);
				if(firstJpg.equals("")){
					firstJpg = chkJpg;
				}
				
			}else {
				if((contents[i].getName().toUpperCase()).indexOf("JPG") > -1
				 ||(contents[i].getName().toUpperCase()).indexOf("JPEG") > -1
				 ||(contents[i].getName().toUpperCase()).indexOf("GIF") > -1	
				 ||(contents[i].getName().toUpperCase()).indexOf("BMP") > -1
				){							
					if(firstJpg.equals("")){						
						firstJpg = contents[i].getPath();
					//break;
					}
				}				
			}
		}	
		list.add(map);
		return firstJpg;		
	}
	
	
	public List getDirList(List list,String path, String dirName, HttpServletRequest req) throws Exception{		
		File myDir = new File(path);
		File[] contents = myDir.listFiles();		
		Arrays.sort(contents); 
		String vPath = "/images/jo/myPic/list/";
		String nPath = req.getSession().getServletContext().getRealPath(vPath);
		String pt = nPath+"/"+dirName.replace(" ","_")+"/";
		File f = new File(pt);
		if(!f.exists()){
			f.mkdir();
		}		
		for(int i = 0; i < contents.length; i++){			
			boolean chk = !contents[i].isDirectory()? false: !contents[i].isHidden()?true:false;
			if(chk==true){					
				String dir = contents[i].getName();				
				HttpSession session = req.getSession();
				String auth = ((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH")+"";
				Map map = new HashMap();
				String imgRootPath = getSuperPath();
				String vpath = contents[i].getPath().replace("\\", "/");				
				map.put("FULL_PATH", vpath.replace(imgRootPath+"/", ""));				
				map.put("AUTH",auth);				
				if( picDAO.cntAuthDir(map) == 0 ){
					continue;
				}else{					
					List lst = new ArrayList();
					list.addAll(this.getDirList(lst,contents[i].getPath(),dirName+"/"+dir, req));					
				}
				
			}else if(!contents[i].isHidden()&&contents[i].isFile()){	
				Map<String, String> map = new HashMap<String, String>();	
			
				String imgName = contents[i].getName().replace(" ","_");
				String tpath = pt+imgName;
				
					if((contents[i].getName().toUpperCase()).indexOf(".JPG") > -1
						 ||(contents[i].getName().toUpperCase()).indexOf(".JPEG") > -1
						 ||(contents[i].getName().toUpperCase()).indexOf(".GIF") > -1	
						 ||(contents[i].getName().toUpperCase()).indexOf(".BMP") > -1
						 ||(contents[i].getName().toUpperCase()).indexOf(".MP4") > -1
					   ){	
						
					
							try {																			
								
								if(imgName.toUpperCase().indexOf(".MP4")>-1){
									tpath =tpath+".jpg";
									imgName = imgName+".jpg";
									if(!new File (tpath).exists()){									
										makeVideoImg(contents[i].getPath(), tpath );										
										imageResize(tpath, tpath,"jpg", "large" );
							    	}         
								}else{									 								
									if(!new File (tpath).exists()){										
										imageResize(contents[i].getPath(), tpath,"jpg", "large");										
									}
									
								}
								
							} catch (Exception e) {
								e.printStackTrace();
					
							}						
					
					String dirDate = dirName.substring(0,dirName.indexOf(" "));
					map.put("thisOrgPath",dirName+"/"+contents[i].getName());					
					map.put("thisPath",vPath+dirName.replace(" ","_")+"/"+imgName);
					if(Integer.parseInt(dirDate.substring(0,8)) > 20171001){
						boolean nChk = true;
						String chkType = "T"; 
						int cnt = 0;
						if(!imgName.startsWith("jo_")){
							String chNm = "";
							String newNm  = "";
							File newFile = null;
							while(nChk){
								chNm = ImageUtil.getFileDate(contents[i]);
								if(cnt > 0){
									String ext = chNm.substring(chNm.lastIndexOf(".")+1);		  											
									newNm = "jo_"+chNm.replace("."+ext,"")+"("+cnt+")."+ext ;
								}else{
									newNm = "jo_"+chNm;
								}
								newFile = new File(contents[i].getParent()+"/"+newNm);
								if(newFile.exists()){
									if((contents[i].hashCode()==newFile.hashCode()||contents[i].length() == newFile.length())){
										contents[i].delete();
										cnt = 0;
										chkType = "D";
										nChk = false;
																				
									}else{
										cnt++;
										continue;
									}
								}else{
									nChk = false;
									cnt = 0;
								}
							}	
							if("D".equals(chkType)){
								continue;
							}
							File thFile = new File(tpath);
							File newThFile = new File(thFile.getParent()+"/"+newNm);
							contents[i].renameTo(newFile);
							thFile.renameTo(newThFile);							
							map.put("thisOrgPath",dirName+"/"+newNm);					
							map.put("thisPath",vPath+dirName.replace(" ","_")+"/"+newNm);
						}
						
					}
					list.add(map);
				}
			}
		}		
		return list;		
	}
	
	public static void makeVideoImg(String orgFilePath, String targetFilePath ) throws Exception{
	
		FFmpegFrameGrabber g = new FFmpegFrameGrabber(orgFilePath);
		g.start();
		try{
		g.setFrameNumber(1);
        Frame frame = g.grabFrame();
		ImageIO.write(new Java2DFrameConverter().convert(frame), "jpg", new File(targetFilePath));
		}catch(Exception e){
			e.printStackTrace();			
		}		
		g.stop();
	}	
	 
	
	
	public void imageResize(String orgFilePath, String targetFilePath, String imageType ,String type ) throws Exception{

		File f = new File(orgFilePath);		
		BufferedImage originalImage = ImageIO.read(f);

		int rWidth = 0 ;
		int rHeigth= 0 ;
		int cWidth = 0 ;
		int cHeight= 0 ;
		boolean cut = false;
		Method qt = Scalr.Method.QUALITY;
		if(type.equals("small")){
			 rWidth = 410 ;
			 rHeigth= 410 ;
			 cWidth = 400 ;
			 cHeight= 289 ;
			 qt = Scalr.Method.ULTRA_QUALITY;
			 cut = true;	
		}else if(type.equals("large")){
			rWidth = 592 ;
			rHeigth= 592 ;
			
		}
		
		int degree = ImageUtil.getOrientation(f);
		
		Rotation rot = null;
		AffineTransformOp[] xform = null;

		switch ((int) degree) {
		case 90:
			rot = Rotation.CW_90;
			break;
		case 180:
			rot = Rotation.CW_180;
			break;
		case 270:
			rot = Rotation.CW_270;
			break;
		default:
			xform = new AffineTransformOp[1];
			xform[0] = new AffineTransformOp(
					AffineTransform.getRotateInstance(Math.toRadians(degree)),
					AffineTransformOp.TYPE_BICUBIC);
			break;
		}
		
		
		
		int h = originalImage.getHeight();
		int w = originalImage.getWidth();		

		int chH = 0;
		int chW = 0;
		
		if(originalImage.getWidth() >= originalImage.getHeight()   ){
			
			if(rHeigth > originalImage.getHeight() ){
									
				chW  = w;
				chH  = h;					
			}else{		
				
				chW  = rWidth*w/h;
				chH  = rHeigth;	
			}
									
		}else{
			if(rWidth > originalImage.getWidth() ){									
				chW  = w;
				chH  = h;
			}else{								
				
				chW  = rWidth;
				chH  = rHeigth*h/w;
				
			}
			
		}  
		
		BufferedImage resizedImage = Scalr.resize(originalImage,qt, chW, chH,  Scalr.OP_ANTIALIAS);
		
		if (rot != null){		
			resizedImage = Scalr.rotate(resizedImage, rot, xform);
		}
		
		if(cut){
			int imgwidth = Math.min(resizedImage.getHeight(),  resizedImage.getWidth());
			int imgheight = imgwidth;
			int hd =  (int)((resizedImage.getHeight() - imgheight)/1.5);
			resizedImage = Scalr.crop( resizedImage, (resizedImage.getWidth() - imgwidth)/2,hd, cWidth, cHeight, Scalr.OP_ANTIALIAS );	
		}		
		
		ImageIO.write(resizedImage, imageType, new File(targetFilePath));
		
	}
	
	@Override
	public void rotImg(String filePath, String imageType   ) throws Exception{
		Rotation rot =  Rotation.CW_90;
		Scalr.Mode scaleMode = Scalr.Mode.AUTOMATIC;
		File f = new File(filePath);		
		BufferedImage originalImage = ImageIO.read(f);
		BufferedImage rotImg =Scalr.rotate(originalImage,  rot, Scalr.OP_ANTIALIAS);		
		ImageIO.write(rotImg, imageType, new File(filePath));
	}
	
	@Override
	public List detailPicList(Map map, HttpServletRequest req) throws Exception {
		String dirName =(String)map.get("path");
		String path = "";
		
		if(map.get("path") != null){
			path = getSuperPath()+"/"+(String)map.get("path");
		}else{
			path = getSuperPath()+"/";
		}
		List list = new ArrayList();
		list =  getDirList(list, path, dirName, req);
		return list;	
	}
	@Override
	public void insertDir(Map map) throws Exception {
		picDAO.insertDir(map);
	}
	
	@Override
	public List selectImgDir(Map map, HttpServletRequest req) throws Exception{
		String path =  (String)map.get("path");
		HttpSession session = req.getSession();
		String auth = ((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH")+"";
		map.put("dir", path);
		map.put("AUTH", auth);
		return picDAO.selectImgDir(map);
	}
	
	@Override
	public List selectDir(Map map) throws Exception {
		return picDAO.selectDir(map);		
	}
	@Override
	public void deleteDir(Map map) throws Exception {
		picDAO.deleteDir(map);		
	}
	@Override
	public List selectAuthDir(Map map) throws Exception {		
		return 	picDAO.selectAuthDir(map);
	}
	public void updateAuthDir(Map map) throws Exception {		
		picDAO.updateAuthDir(map);
	}
	
	public void uploadPic(Map map, List<MultipartFile> multipartFiles) throws Exception{
		
		String path = getSuperPath() +"/"+map.get("path")+"/";
		
		File file = new File(path);
		if(!file.exists()){
			file.mkdirs();	
		}
		for (MultipartFile multipartFile : multipartFiles) {
			file = new File(path + multipartFile.getOriginalFilename());
			multipartFile.transferTo(file);
		}
	}
 	
	  public File[] sortFileList(File[] files )
	     {
	     
	      Arrays.sort(files,
	       new Comparator<Object>()
	        {
	         @Override
	         public int compare(Object object1, Object object2) {
	          String s1 = ((File)object1).isFile()?"0000_":"9999_"+ ((File)object1).getName();
	          String s2 = ((File)object2).isFile()?"0000_":"9999_"+((File)object2).getName();
	          return s1.compareTo(s2);

	        }
	     });
	      return files;
	     }
	  
	  public void updateDirSort(Map map) throws Exception{
		   picDAO.updateDirSort(map);
	  }
	
	  	
	  public List selectUpPathList(Map map) throws Exception{
		 return picDAO.selectUpPathList(map);
	  }
}