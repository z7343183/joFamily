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
package jo.main.web;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jo.main.service.MainService;
import jo.pic.service.PicService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

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
public class MainController {

	/** EgovSampleService */
	@Resource(name = "picService")
	private PicService picService;
	
	@Resource(name = "mainService")
	private MainService mainService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;


	@RequestMapping(value = "/main.do")
	public String main(@RequestParam Map<String,Object> dataVO,  ModelMap model ,HttpServletRequest req ) throws Exception {				
		HttpSession session = req.getSession();		
		Map user = (Map)session.getAttribute("loginInfo");		  
		model.addAttribute("user", user);
		return "main/main";
	}
	
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam Map<String,Object> dataVO, ModelMap model,HttpServletRequest req ) throws Exception {			
		return "main/login";
	}
	
	@RequestMapping(value = "/logout.do")
	public String logOut(@RequestParam Map<String,Object> dataVO, ModelMap model,HttpServletRequest req ) throws Exception {
		HttpSession sess = req.getSession();
		sess.removeAttribute("loginInfo");
		sess.invalidate();		
		return "redirect:login.do";		
	}

	
	@RequestMapping(value = "/loginCheck.do")
	public ModelAndView loginCheck(@RequestParam Map<String,Object> dataVO,HttpServletRequest req ) throws Exception {					
		ModelAndView model = new ModelAndView("jsonView");
		String result = mainService.loginChk(dataVO, req);
		model.addObject("result", result);		
		return model;
	}

	
	@RequestMapping(value = "/main/setupInfo.do")
	public ModelAndView setupInfo(@RequestParam Map<String,Object> dataVO,HttpServletRequest req ) throws Exception {					
		ModelAndView model = new ModelAndView("jsonView");
		HttpSession session = req.getSession();
		Map user =  (Map)session.getAttribute("loginInfo");
		int level = Integer.parseInt(user.get("AUTH_LEVEL")+"");
		String userName = user.get("USERNAME")+"";		
		dataVO.put("id",userName);
		List setupList = mainService.selectSetupInfo(dataVO);
		model.addObject("setup", setupList);
		if(level < 2){
			dataVO.put("level",level);			
			List list = picService.selectAuthDir(dataVO);
			model.addObject("authDir", list);			    				
		}		
		return model;
	}

	@RequestMapping(value = "/main/updateSetupInfo.do")
	public ModelAndView updateSetupInfo(@RequestParam Map<String,Object> dataVO,HttpServletRequest req ) throws Exception {					
		ModelAndView model = new ModelAndView("jsonView");
		HttpSession session = req.getSession();
		Map user =  (Map)session.getAttribute("loginInfo");
		int level = Integer.parseInt(user.get("AUTH_LEVEL")+"");
		String userName = user.get("USERNAME")+"";		
		dataVO.put("id",userName);		
		mainService.updateSetupInfo(dataVO, req);		
		model.addObject("authDir", "S");			    				
		return model;
	}
	
}
