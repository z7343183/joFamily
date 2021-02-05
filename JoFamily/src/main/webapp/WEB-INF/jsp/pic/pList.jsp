<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>photo</title>
    
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">

	
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
   
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 수정 화면 function */
        function fn_egov_select(id) {
        	document.listForm.selectedId.value = id;
           	document.listForm.action = "<c:url value='/updateSampleView.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	document.listForm.action = "<c:url value='/addSample.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        //-->
    </script>
</head>

<body role="document">
    <form:form  id="frm" name="frm" method="post">
    <div class="container-fluid text-center" role="main" style="width: 85%"  align="center">  
       <img  src="<%=request.getContextPath()%>/images/jo/photo.jpg"
	      data-holder-rendered="true" width="1558px" style="margin-bottom: 20px" />      
        <div style="width: 100%;" >   
      	<c:forEach items="${dir}" var="list">  
      	<div style="float: left; margin: 25px" align="center">    	
	     <img src="<%=request.getContextPath()%>/images/jo/myPic/thumbnail/${list.jpgPath}"
	      data-holder-rendered="true" width="350" height="350" z-index=1>
	      <div style="background-color: #fff; margin-top: 0px;height: 100px; vertical-align: middle;font: 400 15px Lato, sans-serif; color: #818181; padding-top: 20px" >
	      	<strong>${fn:substring(list.thisDate,0,4)}.${fn:substring(list.thisDate,4,6)}.${fn:substring(list.thisDate,6,8)}	      	
	      	</strong>
	      	<p style="padding-top: 5px">
	      	${fn:substring(list.thisPath,8, 100)}
	      	</p>		
	      </div>
	      
	    </div>	    
	     	      
	    </c:forEach>
	    </div>
     </div>
     <div style="height: 50px">
     
     </div>
     </form:form>      
</body>
</html>
