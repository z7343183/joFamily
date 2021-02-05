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
package jo.main.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
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

import jo.main.dao.MainDAO;
import jo.main.service.MainService;
import jo.main.util.ImageUtil;
import jo.pic.service.PicService;

import org.apache.commons.lang3.builder.CompareToBuilder;
import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Rotation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiException;
import com.sun.jimi.core.JimiUtils;

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

@Service("mainService")
public class MainServiceImpl extends EgovAbstractServiceImpl implements MainService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MainServiceImpl.class);

	/** SampleDAO */
	// TODO ibatis 사용
	@Resource(name = "mainDAO")
	private MainDAO mainDAO;
		
	@Override
	public String loginChk(Map map,  HttpServletRequest req) throws Exception {		
		
		Map loginMap =  mainDAO.loginChk(map);
		String chk = "";
		if(null==loginMap){						
			chk = "fail";			
		}else{
			chk = "success";
			HttpSession session =  req.getSession();
			session.setAttribute("loginInfo", loginMap);
		}		
		return chk;		
	}

	public void updateSetupInfo(Map map , HttpServletRequest req) throws Exception{		
		HttpSession session =  req.getSession();
		mainDAO.updateSetupInfo(map);
		session.setAttribute("loginInfo", mainDAO.reloadSession(map)); //세션갱신		
	}
	
	public List selectSetupInfo(Map map) throws Exception{
		
		return mainDAO.selectSetupInfo(map);
	}
	
	
}