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
package jo.pic.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.service.SampleVO;

/**
 * @Class Name : EgovSampleService.java
 * @Description : EgovSampleService Class
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

public interface PicService {

	List detailPicList(Map map, HttpServletRequest req) throws Exception;
	List selectPicList(Map map, HttpServletRequest req) throws Exception;
	void insertDir(Map map) throws Exception; 	
	List selectDir(Map map) throws Exception; 
	void deleteDir(Map map) throws Exception;
	List selectAuthDir(Map map) throws Exception; 
	void updateAuthDir(Map map) throws Exception;
	void uploadPic(Map map, List<MultipartFile> multipartFiles) throws Exception;
	void imageResize(String orgFilePath, String targetFilePath, String imageType ,String type ) throws Exception;
	List selectUpPathList(Map map) throws Exception;
	void rotImg(String filePath, String imageType   ) throws Exception;
	List selectImgDir(Map map, HttpServletRequest req) throws Exception;
	void updateDirSort(Map map) throws Exception;
}
