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
package jo.pic.web;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.rte.fdl.property.EgovPropertyService;
































import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.View;

import jo.main.util.StreamView;
import jo.pic.service.PicService;

import org.apache.commons.io.FileUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.github.sardine.Sardine;
import com.github.sardine.SardineFactory;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
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

@Controller
public class PicController {

	/** EgovSampleService */
	@Resource(name = "picService")
	private PicService picService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/pic/pList.do")
	public String piclist(@RequestParam Map<String,Object> dataVO, ModelMap model,HttpServletRequest req ) throws Exception {		
		List<Map> list = picService.selectPicList(dataVO, req);
		model.addAttribute("dir", list);
		return "pic/pList";
	}
	    
	@RequestMapping(value = "/pic/detailPicList.do", method = RequestMethod.POST)    
	public ModelAndView detailPicList(@RequestParam Map<String,Object> dataVO, HttpServletRequest req ) throws Exception {		
		List<Map> slist = picService.detailPicList(dataVO, req);
		List<Map>  subDirlist= picService.selectImgDir(dataVO, req);
		List<Map> list = new ArrayList<Map>();
		String srt = "0";
		if(subDirlist != null && subDirlist.size() > 0 ){
			srt = (String)subDirlist.get(0).get("SRT"); 
		}
		if(srt !=null && srt.equals("1") && slist !=null){
			for(int i = 0 ; i < subDirlist.size(); i++){
				String dir = (String)((Map)subDirlist.get(i)).get("FULL_PATH")+"/";				
				for(int x = 0 ; x < slist.size(); x++){
					Map m =(Map)slist.get(x);		
					String tDir = (String)m.get("thisOrgPath");
					if(tDir.indexOf(dir) > -1){
						list.add(m);
					};
					
				}
			}
		}else{
			list = slist;
		}
		ModelAndView model = new ModelAndView("jsonView");
		model.addObject("dir", list);		
		model.addObject("subDir", subDirlist);
		model.addObject("srt", srt);
		return model;
	}

	@RequestMapping(value = "/pic/picDirList.do" )
	public ModelAndView piclist(@RequestParam Map<String,Object> dataVO, HttpServletRequest req ) throws Exception {		
		HttpSession session = req.getSession();
		ModelAndView model = new ModelAndView("jsonView");		
		Map<String, String> map = new HashMap<String, String>();
		String auth = ((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH")+"";
		map.put("AUTH", auth);
		map.put("searchStr", dataVO.get("searchStr")+"");
		List<Map<String,String>> dirList = picService.selectDir(map);  
		model.addObject("dir", dirList);
		return model;
	}
	
	
	@RequestMapping(value = "/pic/syncPicDir.do")
	public ModelAndView syncPicDir(@RequestParam Map<String,Object> dataVO, HttpServletRequest req ) throws Exception {
	
		HttpSession session = req.getSession();
		List<Map> list = picService.selectPicList(dataVO, req);		
		String str = "";		
		for(int i = 0 ; i < list.size() ; i++){
		if(!str.equals("")) str = str+" UNION ALL ";
			str = str+ "SELECT '"+list.get(i).get("superPath") +"' PARENT,"
				   	 +" '"+list.get(i).get("thisPath")+"' DIR, "
				   	 +" '"+list.get(i).get("fullPath")+"' FULL_PATH "
				   	 + "FROM DUAL";
		}
		Map map = new HashMap<String, String>();
		ModelAndView model = new ModelAndView("jsonView");
		String auth = ((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH")+"";
		int level = Integer.parseInt(((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH_LEVEL").toString());
		map.put("dirList", str);
		map.put("AUTH", auth);
		map.put("AUTH_LEVEL", level);		
		picService.insertDir(map);
		if(level <= 1){			
			picService.deleteDir(map);			
		}
		model.addObject("result", "S");
		return model;
	}
	
	@RequestMapping(value = "/pic/updateAuthDir.do")
	public ModelAndView updateAuthDir(@RequestParam Map<String,Object> dataVO, HttpServletRequest req ) throws Exception {
		picService.updateAuthDir(dataVO);
		ModelAndView model = new ModelAndView("jsonView");
		model.addObject("result", "S");
		return model;
	}
	
	@RequestMapping(value = "/pic/updateDirSort.do")
	public ModelAndView updateDirSort(@RequestParam Map<String,Object> dataVO, HttpServletRequest req ) throws Exception {
		picService.updateDirSort(dataVO);
		ModelAndView model = new ModelAndView("jsonView");
		model.addObject("result", "S");
		return model;
	}
	
	
	
	
	@RequestMapping(value = "/pic/uploadPic.do")
	public ModelAndView uploadPic(@RequestParam Map<String,Object> dataVO, MultipartHttpServletRequest req , HttpServletRequest req2 ) throws Exception {		
		List < MultipartFile > files=  req.getFiles("photos[]");
		picService.uploadPic(dataVO, files);
		HttpSession session = req.getSession();
		String auth = ((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH")+"";
		int level = Integer.parseInt(((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH_LEVEL").toString());
		Map map = new HashMap();
		String path = (String)dataVO.get("path");
		String[] list =	path.split("/");
		String str = "";
		String full_path = "";
		for(int i = 0 ; i < list.length ; i++){
			String parent = "";
			if(!str.equals("")){
				str = str+" UNION ALL ";
				parent = list[i-1];
			}else{
				parent = "";				
			}
			full_path = (full_path==""?"":full_path+"/")+list[i];
			str = str+ "SELECT '"+parent +"' PARENT,"
					   	 +" '"+list[i]+"' DIR, "
					   	 +" '"+full_path+"' FULL_PATH "
					   	 + "FROM DUAL";
		}
		map.put("dirList", str);
		map.put("AUTH", auth);
		map.put("AUTH_LEVEL", level);		
		map.put("MK_LVL", level);
		picService.insertDir(map);
		ModelAndView model = new ModelAndView("jsonView");
		model.addObject("result", "S");
		return model;
	}
	
	@RequestMapping(value = "/pic/video.do")
	public  ModelAndView  video(@RequestParam String name, HttpServletRequest req ,  HttpServletResponse response, Model model) throws Exception {		
		ModelAndView mv = new ModelAndView();
		mv.addObject("name", name);
		//mv.setViewName("videoView");
		mv.setViewName("streamView");
		return mv;
	}
	
	@RequestMapping(value = "/pic/downloadImg.do")
	public ModelAndView downloadImg(@RequestParam  String name, Map<String,Object> dataVO, HttpServletRequest req, Model model ) throws Exception {		
		
		
		String dir = ""; 
    	InetAddress inet= InetAddress.getLocalHost();
		if(inet.getHostName().equals("wk1-PC")){  
    		dir ="z:/사진/" ; 
    	}else{
    		dir ="/mnt/hdd/사진/" ;    		
    	}					
		ModelAndView mv = new ModelAndView();
		/** 첨부파일 상세정보 가져오기 */			
	    return new ModelAndView("fileDownloadView", "name", dir+name);
		
	}
	
	@RequestMapping(value = "/pic/downloadImg2.do")
	public ModelAndView downloadImg2(@RequestParam  String name, Map<String,Object> dataVO, HttpServletRequest req, Model model ) throws Exception {				
		String dir =  req.getSession().getServletContext().getRealPath(name);		
		ModelAndView mv = new ModelAndView();
		/** 첨부파일 상세정보 가져오기 */			
	    return new ModelAndView("fileDownloadView", "name", dir);
		
	}
	
	@RequestMapping(value = "/pic/changeThumbnail.do")
	public ModelAndView changeThumbnail(@RequestParam   Map<String,Object> dataVO,  HttpServletRequest req, Model model ) throws Exception {				
		String name = (String) dataVO.get("name");
		String thDir = ((String) dataVO.get("thDir")).replace(" ","_");
		String thumbnailPath = req.getSession().getServletContext().getRealPath("/images/jo/myPic/thumbnail/");
		String orgPath =  req.getSession().getServletContext().getRealPath(name);	
		picService.imageResize(orgPath, thumbnailPath+"/"+thDir+".jpg", "jpg" ,"small");
		ModelAndView mv = new ModelAndView("jsonView");
		return mv.addObject("thDir", thDir);
	}
	@RequestMapping(value = "/pic/selectUpPathList.do")
	public ModelAndView selectUpPathList(@RequestParam   Map<String,Object> dataVO,  HttpServletRequest req, Model model ) throws Exception {
		HttpSession session = req.getSession();
		String auth = ((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH")+"";
		int level = Integer.parseInt(((Map<?, ?>)session.getAttribute("loginInfo")).get("AUTH_LEVEL").toString());
		Map map = new HashMap();
		String path = (String)dataVO.get("path");		
		map.put("AUTH", auth);
		List list = picService.selectUpPathList(map);
		ModelAndView mv = new ModelAndView("jsonView");
		return mv.addObject("upList", list);
	}
	
	@RequestMapping(value = "/pic/rotImg.do")
	public ModelAndView rotImg(@RequestParam   Map<String,Object> dataVO,  HttpServletRequest req  ) throws Exception{
		String path = ((String) dataVO.get("path")).replace(" ","_");
		String rPath = req.getSession().getServletContext().getRealPath(path);
		picService.rotImg(rPath, "jpg" );
		ModelAndView model = new ModelAndView("jsonView");
		model.addObject("result", "S");
		return model;
	}
	
}