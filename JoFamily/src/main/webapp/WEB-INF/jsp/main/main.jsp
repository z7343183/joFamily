<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/jo/fav.ico" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>My Home</title>

    <!-- Bootstrap Core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="css/docs.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<%=request.getContextPath()%>/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- Theme CSS -->
    <link href="<%=request.getContextPath()%>/css/agency.min.css" rel="stylesheet">
    

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>-->
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js" integrity="sha384-0s5Pv64cNZJieYFkXYOTId2HMA2Lfb6q2nAcx2n0RTLUnCAoTTsS0nKEO27XyKcY" crossorigin="anonymous"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js" integrity="sha384-ZoaMbDF+4LeFxg6WdScQ9nnR1QC2MIRxA1O9KWEXQwns1G8UNyIEZIQidzb0T1fo" crossorigin="anonymous"></script>
    <!--[endif]-->
        
</style>
<style>

.form-control {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
</style>

</head>

<body id="page-top" class="index"  ng-app="myApp">

    <!-- Navigation -->
    <nav id="mainNav" class="navbar navbar-default navbar-custom navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">My Home</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#services">Services</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#portfolio">Gallery</a>
                    </li>
                    <li>
                        <a href="#uploadPhoto" class="portfolio-link" data-toggle="modal"  data-view-pre ="selUploadInfo" data-view-pre-param ="" >Upload</a>
                    </li>
                    <li>
                        <a href="#setup"  class="portfolio-link" data-toggle="modal" data-view-pre ="selSetupInfo" data-view-pre-param ="">Setup</a>
                    </li>                                         
                    <li>
                        <a class="page-scroll" href="<%=request.getContextPath()%>/logout.do">Logout</a>
                    </li>                    
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <!-- Header -->
    <header>
        <div class="container">
            <div class="intro-text">
                <div class="intro-lead-in"></div>
                <div class="intro-heading">Welcome To My Home!</div>
                <a href="#portfolio" class="page-scroll btn btn-xl">Go To GALLAY</a>
            </div>
        </div>
    </header>
    <!-- Services Section -->
    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Services & Setup</h2>
                    <h3 class="section-subheading text-muted">&nbsp;</h3>
                </div>
            </div>
            <div class="row text-center">
              	<div class="col-md-4">
                    <span class="fa-stack fa-4x" >
						<img  ng-src="<%=request.getContextPath()%>/images/jo/photo2.png" class="img-responsive" alt="">                        
                    </span>
                    <h4 class="service-heading">Gallery</h4>
                    <a type="button" class="btn btn btn-danger page-scroll" id="syncPhoto" href="#portfolio">동기화</a>
                    <p>&nbsp;</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                       <img  ng-src="<%=request.getContextPath()%>/images/jo/video.png" class="img-responsive" alt="">                        
                    </span>
                    <h4 class="service-heading">New Video</h4>
                    <a type="button" class="btn btn btn-danger" href="http://jj0315.ipdisk.co.kr:2080" target="_blank">바로가기</a>
                    <p>&nbsp;</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <img  ng-src="<%=request.getContextPath()%>/images/jo/music2.png" class="img-responsive" alt="">                                                
                    </span>
                    <h4 class="service-heading">New Music</h4>
                    <a type="button" class="btn btn btn-danger" href="http://jj0315.ipdisk.co.kr:4040" target="_blank">바로가기</a>
                    <p>&nbsp;</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <img  ng-src="<%=request.getContextPath()%>/images/jo/setup2.png" class="img-responsive" alt="">                                                
                    </span>
                    <h4 class="service-heading">Setup</h4>
                    <a href="#setup"  class="btn btn btn-danger portfolio-link" data-toggle="modal" data-view-pre ="selSetupInfo" data-view-pre-param ="">설정</a>
                    <p>&nbsp;</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <img  ng-src="<%=request.getContextPath()%>/images/jo/upload2.png" class="img-responsive" alt="">                                                
                    </span>
                    <h4 class="service-heading">Upload</h4>
                    <a href="#uploadPhoto"  class="btn btn btn-danger portfolio-link" data-toggle="modal" data-view-pre ="selUploadInfo" data-view-pre-param ="">업로드</a>
                    <p>&nbsp;</p>
                </div>
                
            </div>
        </div>
    </section>

    <!-- Portfolio Grid Section -->
    <section id="portfolio" class="bg-light-gray">
        <div class="container" id="picCon"  ng-controller="dirCtrl">
            <div class="row" id="picTxt">
                <div class="col-lg-12 text-center" align="center">
                    <h2 class="section-heading">Gallery</h2>
                     <div class="input-group" align="center" style="max-width: 500px; width:85%; margin: 0 auto;">
				      <input id="searchStr" type="text" class="form-control" placeholder="검색할 날짜 또는 제목을 넣어주세요...">
				      <span class="input-group-btn">
				        <button id="searchBtn" class="btn btn-default glyphicon glyphicon-search" type="button" style="margin-top: -1px;"></button>
				      </span>
				    </div><!-- /input-group -->
				   <h3 class="section-subheading text-muted">Who controls the past controls the future. </h3>                    
                </div>
            </div>
            <div class="row" id ="picRow" >
                <div class="col-md-4 col-sm-6 portfolio-item"  ng-repeat="data in data" >
                    <a href="#portfolioModal1" class="portfolio-link" data-toggle="modal" data-view-pre ="fnPicList" data-view-pre-param ="{{data.DIR}}" >
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>                        
                         <img onerror="setErrImg(this)"  ng-src="<%=request.getContextPath()%>/images/jo/myPic/thumbnail/{{data.THIS_PATH}}.jpg?{{data.RANDOM}}"  class="img-responsive picDir-Img" alt="">                        
		            </a>
                    <div class="portfolio-caption"  href="#portfolioModal1"  data-toggle="modal" data-view-pre ="fnPicList" data-view-pre-param ="{{data.DIR}}" style="cursor: pointer;" >
                        <h4 class="picDir-h4">{{data.SUBSTR}}</h4>	                 	
                        <p class="picDir-text text-muted">{{data.SUBDATE}}</p>
                    </div>
                </div>                      
            </div>
            <p align="center"><button id="nextView1"  type="button" class="btn btn-lg btn-primary nextView1" ng-click="addRow()">계속보기</button></p>                   
        </div>
    </section>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <span class="copyright">Copyright &copy; Your Website 2017</span>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline social-buttons">
                        <li><a href="#"><i class="fa fa-twitter"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-facebook"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline quicklinks">
                        <li><a href="#">Privacy Policy</a>
                        </li>
                        <li><a href="#">Terms of Use</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
    <!-- Portfolio Modals -->
    <!-- Use the modals below to showcase details about your portfolio projects! -->

    <!-- Portfolio Modal 1 -->
    <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal picClose" data-dismiss="modal">
                    <div class="lr">
                        <div class="rl">
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="modal-body">
                                <!-- Project Details Go Here -->
                                <h2>&nbsp;</h2>
                                <div id="picBtn">                                
                                </div>
                                <p class="item-intro text-muted">Who controls the past controls the future.</p>                                
                                <div id = "picHref">
                                </div>
                                <div id = "picList">
                                
                                </div>
                                <button id="nextView2"  type="button" class="btn btn-lg btn-info nextView2" style="display: none;">계속보기</button>
                                <button id="picInfoClose" type="button" class="btn btn-lg btn-danger picClose" data-dismiss="modal"><i class="fa fa-times"></i> CLOSE </button>
			                    <div id="sAuthPop"  class="sAuthPop" style="display: none;position: absolute;z-index:7700"  curX = "" curY = "">
									  <div class="modal-dialog modal-sm">
										 <div class = "setupBox" id="authSetup_s" >
											<div style="float: left">사진폴더 권한 관리</div><div id="changeSort" style="float:right;cursor: pointer;color: #777;padding-right: 20px;margin-top: -1px;" >▲</div> 
											 <div class="setupContent scroll">
												 <div style="height:400px;overflow-x:auto;">
													<table class="table table-striped">
											    		<tbody id ="authRow_s">
											      			<tr>
											        			<td class="auth_dir" ></td>
											        			<td class="auth_check" ></td>
											      			</tr>								              
											    		</tbody>
											  		</table>
												</div>	                                        		  
									    	</div>
											<div align="center">
					               				<span id="sAuthPopBtnSpan">
					    	         				<button id="sAuthPopBtnClose_s" type="button" class="btn btn-info">CLOSE</button>
					             				</span>
										   </div>
									    </div>                  
									</div>
									
									
								</div>	
                            </div>
                        </div>
                    </div>
                     <div id="dirPathPop"  class="dirPath"  style="display: none;position: absolute;z-index:7600;"  curX = "" curY = ""> 
				       <div class="modal-body" id="upBody_s" >
				       	<div class = "setupBox" >
				       		<div>파일 첨부</div>
				       		<div class="setupContent bd-example">
				       		 	 <div class="form-group">
									<div class="col-10" style="z-index:7601">
											<p id="parPath" style="padding: 10px"></p>					
											<input class="form-control" type="text" value="" id="filePath_s" name = "filePath_s" >
									</div>  										 	  
					               	</br>	   
					               	<div align="center">
			               				<span id="uploadBtnSpan">
				             				<button id="upLoadBtn_s" type="button" class="btn btn-warning" >UPLOAD</button>
			    	         				<button id="uploadBtnClose_s" type="button" class="btn btn-info">CLOSE</button>
			             				</span>
								   </div>
				       		</div>
					       </div>
					     </div>  
					   </div>
		 			 </div> 
		          </div>
		         </div>
		        </div>
   			 </div>
    
    <!-- Portfolio Modal 1 -->
    <div class="portfolio-modal modal fade" id="setup" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="background-color: #EAEAEA">
               <div class="close-modal" id="setupClose" data-dismiss="modal">
                    <div class="lr">
                        <div class="rl">
                        </div>
                    </div>
                </div>
                <div class="container"  >
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="modal-body" >
                            	<div id="setupBody">
                                 <div class = "setupBox" >
                                   	<div>Gallery 로그인시  자동  동기화</div>
                                   	<div class="setupContent">	                                                   		                        		  
	                                 	<p class="set1">
										    <input type="radio" name="SET1"  value="1"   autocomplete="off"> 켜짐(오래걸림)
										    <input type="radio" name="SET1"  value="2"    autocomplete="off">꺼짐
										</p>
                                	</div>
                                </div>  
                                <div class = "setupBox" >
                                   	<div >Gallery 썸네일 표시</div>
                                   	<div class="setupContent">	                                        		  
	                                   <p class="set2"><input name="SET2" type="radio"  value="1" />표시<input name="SET2" type="radio"  value="2" />표시안함	                                   				 
	                                   </p>
                                	</div>
                                  </div>          
                                 <div class = "setupBox" >
                                   	<div >Gallery 한번에 표시할 사진 갯수 </div>
                                   	<div class="setupContent">	                                        		  
	                                   <p class="set3"><input name="SET3" type="radio"  value="all" />전체<input name="SET3" type="radio"  value="15"/>15개 <input type="radio"  name="SET3" value="30" />30개 
	                                   				  <input type="radio"  name="SET3" value="60"/>60개</p>
	                                   </p>
                                	</div>
                                  </div>                                  
                                  <div class = "setupBox" >
                                   	<div >사진상세에서 한번에 표시할 사진 갯수</div>
                                   	 <div class="setupContent">	                                        		  
	                                   <p class="set4"><input name="SET4" type="radio" value="all" />전체<input name="SET4" type="radio" value="15"/>15개<input type="radio"  name="SET4" value="30" /> 30개
	                                   				   <input type="radio"  name="SET4" value="60"/>60개</p>	
	                                   </p> 	                                                                      
                                	</div>
                                  </div> 
                                   <div class = "setupBox" >
                                   	<div>사진 다운로드(1초클릭) 기능</div>
                                   	 <div class="setupContent">	                                        		  
	                                   <p class="set5"><input name="SET5" type="radio" value="1" />사용
	                                   <input name="SET5" type="radio" value="2"/>사용안함(폰 자체기능사용)</p> 	                                                                      
                                	</div>
                                  </div>  
                                                                  
                                </div>   
                                 <div class = "setupBox" id="authSetup" style="display: none">
                                   	<div>사진폴더 권한 관리</div>
                                   	 <div class="setupContent scroll">
                                   		 <div style="height:400px;overflow-x:auto;">
								          <table class="table table-striped">
								            <tbody id ="authRow">
								              <tr>
								                <td class="auth_dir" ></td>
								                <td class="auth_check" ></td>
								              </tr>								              
								            </tbody>
								          </table>
								        </div>	                                        		  
                                	</div>
                                  </div>                                  	
                                <br/><br/>                                
                                <button type="button" id="setupReload" class="btn btn-info" data-dismiss="modal">적용(재시작)</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i>CLOSE</button>
                        	</div>
                    	</div>
            		</div>
        		</div>
   			</div>
    	</div>
    </div>
     <!-- Portfolio Modal 2 -->
    <div class="portfolio-modal modal fade" id="uploadPhoto" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="background-color: #EAEAEA">
               <div class="close-modal" data-dismiss="modal" id="upClose">
                    <div class="lr">
                        <div class="rl">
                        </div>
                    </div>
                </div>
                <div class="container"  >
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="modal-body" id="upBody" > 
                              <div class = "setupBox" >                                  
                                   	<div >파일 첨부</div>
                                   	 <div class="setupContent bd-example">	 
                                   	 <form id="fileForm" enctype="multipart/form-data">
	                                   <div class="form-group ">
  										<div class="col-10">  										
    										<input class="form-control" type="text" value="" id="filePath" name = "filePath" readonly="readonly" style="background-color:transparent;">    										    									
  										</div>  										 	  
										<div style="display: none"> 	                                   	                                   		                                   
	                                   	<input id="uploadFile" type="file" style="width: 500px" multiple="multiple" name="filename[]"/>사진올리기 	                                   
	                                   	</div>
	                                   	<br>
	                                   	</br>	   
	                                   	<div align="center">
	                                   		<span id="uploadBtnSpan">
		                                		<button id="upLoadBtn" type="button" class="btn btn-warning" 	>UPLOAD</button>
		                                	</span>
        		                        	<button id="uploadBtnClose" type="button" class="btn btn-info" data-dismiss="modal"><i class="fa fa-times"></i>CLOSE</button>                                	
	                                   </div>
	                                   </div>
	                                   </form>
	                                </div> 	        	                                                                                                      	
                                  </div>  
                            
                            	<div class = "setupBox" >                                  
                                   	<div >경로 선택</div>
                                   	 <div class="setupContent scroll">
                                   		 <div style="height:400px;overflow-x:auto;">
								          <table class="table table-striped">
								          	<thead>
								          	  <tr >
								          	  	<td align="right" colspan="2" >								          	  		
								          	  		<button type="button" id="newUpDir" style="margin-left:20px" class="btn btn-sm btn-default">+폴더생성</button>
								          	  		<button type="button" style="margin : 5px" id="upDirReset" class="btn btn-sm btn-default">새로고침</button>								          	  		
								          	  	</td>
								              </tr>									             
								          	</thead>								            
								            <tbody id ="uploadPathRow">								              
								              <tr>
								              	<td width=5% ></td>
								                <td class="upload_dir" ></td>
								              </tr>								              
								            </tbody>
								          </table>
								        </div>	                                        		  
                                	</div>        	                                                                                                      	
                                  </div>       
                                                              
                        	</div>
                    	</div>
            		</div>
        		</div>
   			</div>
    	</div>
    </div>
    <div id="alertMsgDiv" align="center" class="alertDiv" style="display: none; cursor: pointer;">
		<div class="container">		
			 <div class="alert alert-danger alert-dismissible fade in" style="max-width: 700px" role="alert">
			  <button id="alertBtnClose" type="button" class="close" >
			  <span>×</span>
			  <span class="sr-only">Close</span></button>
			   <strong style="margin-right: 10px">알림말!</strong>
			   <span id="alertMsg"></span> 
			  </div> 
		</div>
	</div>	
	<!-- 
	<div id="closeDiv" align="center"  cursor: pointer;" style="position: fixed; bottom:10px;right:1px; z-index: 8000">
		<div class="container" align="right">		
			 <div class="" style="max-width: 700px" role="alert">
			  <p>
			  	<img src="<%=request.getContextPath()%>/images/jo/close5.png" width="50px" > </a>
			  </p>
			  
			  </div> 
		</div>
	</div>	
	 -->
	
		
	<div id="layerpop"  class="laypopDiv" style="display: none;position: absolute;z-index:7500"  curX = "" curY = "">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content">
	      <div class="modal-header" style="padding: 10px">
	      	<strong id="fileName"></strong>	
	        <button type="button" class="close" data-dismiss="modal">×</button>
	      </div>
	      <div class="modal-body" >
				<a id="down1" style="color: #333;cursor: pointer;"><p>원본(고용량) 다운로드</p></a>
				<a id="down2" style="color: #333;cursor: pointer;"><p>저용량 다운로드</p></a>
				<a id="chgPic" style="color: #333;cursor: pointer;"><p>이사진으로 썸네일 변경</p></a>
				<a id="uploadThisDir" style="color: #333;cursor: pointer;"><p>이경로에 사진올리기</p></a>
				<a id="rotImg" style="color: #333;cursor: pointer;"><p>회전시키기(90도)</p></a>				
				<!-- <a id="updateInfo" style="color: #333;cursor: pointer;"><p>설명 달기</p></a> -->
				<!-- <a id="printPhoto" style="color: #333;cursor: pointer;"><p>이 사진 인쇄 요청</p></a> -->
	      </div>	      
	    </div>
	  </div>
	</div>
	
	
	
    <!-- jQuery -->
    <script src="vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getContextPath()%>/vendor/bootstrap/js/bootstrap.js"></script>

    <!-- Plugin JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js" integrity="sha384-mE6eXfrb8jxl0rzJDBRanYqgBxtJ6Unn4/1F7q4xRRyIw7Vdg9jP4ycT7x1iVsgb" crossorigin="anonymous"></script>

    <!-- Contact Form JavaScript -->
    <script src="<%=request.getContextPath()%>/js/jqBootstrapValidation.js"></script>
    <script src="<%=request.getContextPath()%>/js/contact_me.js"></script>

    <!-- Theme JavaScript -->
    <script src="<%=request.getContextPath()%>/js/agency.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/showLoading.css" charset="UTF-8" />
    <link rel="stylesheet" type="text/css" href="css/angularAni.css" charset="UTF-8" />
   
	<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.showLoading.js"></script>
	<script language="javascript" src="<%=request.getContextPath()%>/js/imgloaded.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-animate.js"></script>
	<script src="<%=request.getContextPath()%>/js/common.js"></script>
 	<script type="text/javascript">
 	
 	var rpath="<%=request.getContextPath()%>";
 	var setting = ${user.SETT};
 	var userSet = eval(setting);
 	var clickPic = "";
 	
 	
	function checkMobile(){
		var filter = "win16|win32|win64|mac";
		if(navigator.platform){
			if(0 > filter.indexOf(navigator.platform.toLowerCase())){
				return "mobile";
			}else{
				return "pc";
			}
		}
	}
 	var mobile =checkMobile();
 	
 	function alertPop(str, str2){
 		var displayYn;
 		if(str2 == undefined ){
 			displayYn = "Y";	
 		}else{	 			
 			displayYn = str2;
 		}
 		 		
 		$('#alertMsg').text(str);
 		$('#alertMsgDiv').show();
 		$('#alertMsgDiv').css({"top" : "0px"});
 		$('#alertMsgDiv').animate({"top" : '200px' }, "600");
 		setTimeout(function(){	 			
 			if(displayYn=='Y') {
 				$('#alertMsgDiv').fadeOut(500);	
 			}
 				 			
 		}, 1000);
 	}
		
 		history.pushState(null, null, location.href);
 		history.go(1);
 		
		window.onpopstate = function(event) {
			
			if($('#portfolioModal1').is(':visible') || $('#setup').is(':visible')|| $('#uploadPhoto').is(':visible')){
				$('.close-modal').trigger('click');			
				history.go(1);					
			}
		};

 	
 	$(document).ready(function(){
 		
 		
 		if(userSet.SET1 == '1'){
 			$('#syncPhoto').trigger('click'); //자동동기화 
 		}
	
 		//파일첨부 관련
 		$('#upDirReset').click(function(e){
 			selUploadInfo(); 			 		
 			btnInit(); 			
 		})
 		
 		//1초 누르면 팝업 관련
 		$('#portfolioModal1').on('click focus touchmove tourchstart', function(e){
 			
 			if($('#layerpop').is(':visible')){
	 			
	 			var curX = $('#layerpop').attr('curX');
	 			var curY = $('#layerpop').attr('curY');
	 			var x = e.pageX;
	            var y = e.pageY;
	            if(x == undefined &&(e.type).indexOf("touch")>-1 ){
	            	var et = e.originalEvent;						            	
	            	x = et.touches[0].screenX;						            	
	            	y = et.touches[0].screenY;
	            }		
	 			
	 			if(curX != x && curY != y ){
	 				$('#layerpop').attr({'curX':'', 'curY':''});
	 				$('#layerpop').fadeOut(100);				
	 			}
 			
 			}
 		})
 		//스크롤시 팝업 사라짐
 		$('#portfolioModal1').scroll(function () {
 			if($('#layerpop').is(':visible')){
 				$('#layerpop').attr({'curX':'', 'curY':''});
				$('#layerpop').hide();
 			}	
 		});
 		
 		
 		if(userSet.SET3 != 'all')
 		$('#nextView1').show();
 		
 		if(userSet.SET4 != 'all'){
 	 	 	$('#nextView2').show();
 		}
		$('#alertMsgDiv').on('click', function(){
				$('#alertMsgDiv').hide();
		});
 		
		
		//파일첨부관련
		$('#filePath').on('focus blur change', function(e){
			var fileStr = "경로를 선택해 주세요."
			if(e.type == 'focus'){
				this.value = "";				
			}else if(e.type == 'blur'){
				if(this.value == ""){						
					this.value = fileStr; 
				}				
			}
			
		});
		
		$('#filePath').trigger("blur");
		
		
		/**===================우클릭방지==========================**/
		if(userSet.SET5 == '1'){ //자체 다운로드 방지
			$(document).bind("contextmenu", function(e) { return false;	});
			//$(document).bind('selectstart',function() {return false;});  
			//$(document).bind('dragstart',function(){return false;});  	
		}
		
 		
 		$('#upClose, #uploadBtnClose').on("click",function(){
 			var o =$('#uploadFile').clone().hide();
 			$('#uploadFile').remove();
 			$('#uploadBtnSpan').append(o);
 			uploadFileChange(); 			
 			btnInit();
 		});
 		
 		$('.picClose').on("click", function(){
 			$('.videoMargin').each(function(){
 				this.pause();
 			})
 		});

 		$('#upLoadBtn').on('click', function(){
	 		$('#uploadFile').trigger("click");
	 		
	 	});
	 	$('#setupReload').on('click', function(){
	 		location.href = rpath+"/";	 	
	 	});
	 	
		$('#setupBody').find(':radio').on('change', function(){					
			var val = $(this).val(); 
			var name = $(this).attr('name');
 				$.ajax({
 		 			type        : "POST",
 		 			data : {SET_KEY:name  , VALUE : val },
 		 			url :  rpath+"/main/updateSetupInfo.do", 			
 		 			success : function(data){ 	 				
 		 				authInfo.setData(data.authDir); 				
 					},
 		 			error : function(request, status, error){ 				
 		 				alertPop("오류가 발생하였습니다.");
 		 			}
 		 		});	 	 
		});
	 	
	 	function btnInit(){
	 		$('#filePath').val('');
	 		$('#filePath').trigger("blur");
			$('#upLoadBtn').text("UPLOAD");
 			$('#upLoadBtn').removeClass();
 			$('#upLoadBtn').fadeOut('500').addClass("btn btn-warning").fadeIn(500);	 			
 			$('#upLoadBtn').off('click');
 			$('#upLoadBtn').on('click', function(){
 				$('#uploadFile').trigger("click");		 				
 			});
	 		
	 	}
	 	
	 	
	 	function uploadFileChange(){
	 		$('#uploadFile').on('change',function(){	 		
		 		if($(this).val() != ""){	 			
		 			$('#upLoadBtn').text("SAVE FILE");
		 			$('#upLoadBtn').removeClass();
		 			$('#upLoadBtn').fadeOut('500').addClass("btn btn-danger").fadeIn(500);	 	
		 			$('#upLoadBtn').off('click');
		 			var view1 = $('#uploadPhoto').is(":visible");		 			
		 			var view2 = $('#portfolioModal1').is(":visible");
		 			if(view1){
			 			$('#upLoadBtn').on('click', function(){		 				
			 				uploadFile();		 				
			 			});		 				
		 			}else if(view2){
		 				uploadFile();
		 			}

		 		}else{
		 			btnInit();
	 			}
	 		});
	 	}
	 	
	 	uploadFileChange();	 	         
	 	
	 	function uploadFile(){	 		
	 		var alertMsg = "경로를 선택해 주세요.";
	 		if($.trim($('#filePath').val())==""||$('#filePath').val()== alertMsg){ 				 			
	 			alertPop(alertMsg);
	 			return;
	 		}
	 		
	 		var formData = new FormData(); 
			var files = $("#uploadFile").get(0).files; 
			if (files.length == 0){
				return;
			}
			
			// Loop through each of the selected files.
			for (var i = 0; i < files.length; i++) {
			  var file = files[i];

			  // Check the file type.
			  if (!file.type.match('image.*')&&!file.type.match('video.*')) {
			    	alertPop("그림파일이 아닙니다.");
			    	btnInit();
			    	return;
			  }
			  formData.append('photos[]', file, file.name);
			}
			
			
			if(!confirm("파일을 전송하시겠습니까?")){	 			
	 			return;
	 		}
			
			var view1 = $('#uploadPhoto').is(":visible");		 			
 			var view2 = $('#portfolioModal1').is(":visible");
			
			//경로 셋팅
			formData.append("path", $.trim($('#filePath').val()));
			
			
			var bar = "";
			if(view2){				
				bar = new loadingBar("portfolioModal1");
			}else{
				bar = new loadingBar("upBody");	
			}
			
			bar.start();
			$.ajax({ url: rpath+"/pic/uploadPic.do", 		
					type:"POST", 
					processData: false, 
					contentType: false, 
					data: formData , 
					success: function (response) { //성공시											
						btnInit();
						bar.end();
						alertPop("전송 완료");
						if(!$('#portfolioModal1').is(':visible')){
							location.href = rpath+"/";
						}
						
					}
					, error: function (er) {
						bar.end();
						alertPop("오류발생","N"); 
					}
			}); 					
	 	}
 	
	 	$('#uploadBtnClose_s').click(function(){
	 		$('#dirPathPop').fadeOut(500);
	 	});
	 	$('#sAuthPopBtnClose_s').click(function(){	 		
	 		$('#sAuthPop').fadeOut(500);
	 	});
	 	
	 	
	 	$('#changeSort').on('click',function(){
	 		fn_changeSort();
	 	});
	 	
 	});//====================onload 끝==========================
 	
 	/**===================동기화하기==========================**/
 	var lv ="${user.AUTH_LEVEL}";	
 	//jquery ajax 사용
 	var hrefChk = "";
 	var btnCnt = 0;
 	var btnCnt2 = 0;
 	var fnPicList = function(str){
 		clickPic = str
 		btnCnt = 0;
 		btnCnt2 = 0;
		hrefChk = "";
		imgSeq = 0;
 		var cnt = 0;
 		var gData = "";
 		if(userSet.SET4 != 'all'){ 	 	 	
 	 	 	var cnt = userSet.SET4 ; 	 	 	
 	 	 	$('#nextView2').off("click");
 	 	 	$('#nextView2').on("click", function(){ 	 	 		
 	 	 		clickCnt ++ ; 	 	 		
				var dat = gData.slice(0,cnt);
				gData = gData.slice(cnt);
 	 	 		setDetailImageData(dat);
 	 	 		if($(gData).size()==0) $('#nextView2').hide();
 	 	 	});
 		}
 		
 		

 		$('#dirPathPop').hide();
 		$('#sAuthPop').hide();
 		
 		
 		$('#portfolioModal1 .modal-body').find('h2').text(str);
 		
 		
 		$('#picList').empty();		
 		$('#picBtn').empty();
 		$('#picList').show();
 		$('#portfolioModal1').show();
		$('#picList').append('<img class="img-responsive img-centered" src="'+rpath+'/images/jo/loading1.gif" >');
		$('#picList').append('<p class="item-intro text-muted">동기화중입니다. 잠시만 기다려 주세요.</p>');
		
        var reqId = new Date().getTime();
 		$.ajax({
 			type        : "POST",
 			url :  rpath+"/pic/detailPicList.do",
 			timeout 	: "6000000", //60분
 			data : {path : str },
 			success : function(data){
 				
 				gData = "";
 				clickCnt = 1 
 				if(!$('#portfolioModal1').is(':visible') || str != $('#portfolioModal1 .modal-body').find('h2').text()) {
 					alertPop("Gallery "+str+"의 동가화가 완료되었습니다.");
 					return;
 				};		
 				$('#picList').empty(); 	
 				$('#picList').hide();
 				var hrefChk = ""; 
 				
 				var setDat = "";
 				if(cnt == ""){ 					
 					setDat =  data.dir;
 				}else{
 					$('#nextView2').show();
 					setDat = (data.dir).slice(0,cnt);
 					gData =  (data.dir).slice(cnt);
 					if($(gData).size() ==0 ){
 						$('#nextView2').hide();
 					}
 					
 				} 				
 				
 				if(data.srt == "1" ){
 					$('#changeSort').text('▼');
 				}else{
 					$('#changeSort').text('▲');
 				}
 				
 				setDetailImageData(setDat, data.subDir);
 				
 				$('#picList').fadeIn(500);
			},
 			error : function(request, status, error){
 				alertPop("오류가 발생하였습니다.");
 				$('#picInfoClose').trigger('click');
 				
 			}
 		});
 		
 		
 	 }
 	
 	
 	/**===================상세이미지 보기==========================**/
 	var isClick = 0;	
	var timer;	
	var lastImg = "";
 	function setDetailImageData(data, sub){
		 		
 		$('#picRow').find('.portfolio-hover:hover').off('click');//초기화
 		$('#picRow').find('.portfolio-hover:hover').css('opacity','0').click(function(){
			$(this).css('opacity','1');		
		});
 		
 		
 		
		var btnClass = ["default", "primary", "success" , "info" ,  "danger"];		
		cntHideId=0;
		var divTop = $('#portfolioModal1').offset().top;
		
				
		$.each(sub, function(n,sdat){
			btnCnt2++
			if(btnCnt >=4){ 								
				btnCnt = 0 								
			}else{ 								
				btnCnt++;
			}
			var $a = $('<a  style="margin:5px" target=btnCnt'+btnCnt2+'  class="btn-'+btnClass[btnCnt]+'"><button type="button"   style="margin-bottom:5px;margin-top:5px" class="btn btn-sm btn-'+btnClass[btnCnt]+'">'+sdat.DIR+'</button></a>');
			var position = "";
			var vbar = new loadingBar("picBtn");
			$a.click(function(e){
				vbar.start();
				var target = $(this).attr('target');				
				if($('#'+target).size()==0){
					var tchk = true;
					while(tchk){						
						if($('#nextView2').is(':visible')==false){							
							tchk = false;
						}else{
							$('#nextView2').trigger('click');	
						}												
						if($('#'+target).size() > 0){														
							tchk = false;							
						}					
					}
					
				}
				$('#j_img'+imgSeq).imagesLoaded(function(){
					position = $('#'+target).offset();
					if(position != undefined){
						$('#portfolioModal1').animate({scrollTop : position.top-divTop }, 300);	
					}					
					vbar.end();
				});
			
			});
			$('#picBtn').append($a);
		});
		
		if(sub != undefined){
			btnCnt = 0;
			btnCnt2 = 0;	
		}
		
		
 		$.each(data, function(n,dat){
				var s = (dat.thisPath).split("/");
				if(s.length>7){ 						
					if(hrefChk != s[6] ){
						hrefChk = s[6];
						btnCnt2++	
												 							
						if(btnCnt >=4){ 								
							btnCnt = 0 								
						}else{ 								
							btnCnt++;
						}
						
						var ft = "";
						if(mobile=='mobile'){
							
							if(s[6].length > 15 && s[6].length < 20){								
								ft = '60%';	
							}else if(s[6].length > 20){																
								ft = '15px';	
								s[6] = s[6].substring(0,25);
							}
							
							
						}else{
							
							ft = '70%';
							
						}
						
						
						var p =$('<h1><p id=btnCnt'+btnCnt2+' class="label label-warning" style="font-size:'+ft+'; cursor:pointer " >'+s[6].replace(/_/gi," ")+'</p></h1>');
						
						$(p).click(function(){
							
							$('#portfolioModal1').animate({scrollTop : 0 }, 300);
							
						});
						
						$('#picList').append('<br/>');
						$('#picList').append(p);						
						$('#picList').append('<br/>');
						
					
					}
				}
				var obj = "";
				imgSeq++;
				if((dat.thisPath).indexOf(".mp4")>-1){			
					cntHideId = cntHideId + 1;
					var v = (dat.thisOrgPath).replace(".jpg","");
					var src = rpath+"/pic/video.do?name="+encodeURI(v);   
					var html = '';
						html += '<video id=j_img'+imgSeq+'  controls width=592 height=auto preload=none  class="img-responsive img-centered videoMargin" poster='+rpath+dat.thisPath+"?"+Math.random()+' >';
						html += ' 	 <source src='+src+'/>';  
						html += '</video>';
						html += '';												
					obj = $(html);
					$('#picList').append(obj);
				
					
				}else{
					
					obj = $('<img id=j_img'+imgSeq+' class="img-responsive img-centered" src="'+rpath+dat.thisPath+"?"+Math.random()+'" alt="" >');
					var v = dat.thisOrgPath;					
					$('#picList').append(obj);
				}
				
				
				//마우스  다운로드창
				if(userSet.SET5 == '1'){					
					$(obj).on('mousedown touchstart', function (event) {				
						if(event.type == "mousedown"&&event.button ==2){
							downPopView(this,event, dat);								
						}else{ //모바일 터치 일때 0.8초 클릭시 다운
							    isClick = 1;
							    var _this = this;
							    timer = setTimeout(function() {
							        if (isClick != 0) {
							            isClick = 0;
							            downPopView(_this, event, dat);
							        }
							    }, 800);
						}
				
					}).on('mouseup touchend touchcancel touchmove', function(event) {
					    clearTimeout(timer);
					    isClick = 0;
					});
				}	
				
			});
 	}
 	/**===================썸네일 설정==========================**/
	function selectAngularPicDir(){
 		var cnt = userSet.SET3;
		var dirApp = angular.module("myApp", ['ngAnimate'])
		var synk = false;
		dirApp.controller('dirCtrl', function($scope, $http) {
		
			if(cnt != 'all') $('#nextView1').show();
			else $('#nextView1').hide();
		

			var gData = "";
			$scope.addRow = function(){
				var dat = gData.slice(0,cnt)
				$scope.data.push.apply($scope.data, dat);
				gData = gData.slice(cnt);
				if($(gData).size() == 0 ) $('#nextView1').hide();  				
			}
			
			$('#syncPhoto').click(function(){
				var bar = new loadingBar("picTxt");
				bar.start();
				$http({
	    	    	method: 'POST',
	    	        url : rpath+"/pic/syncPicDir.do"
	    	    }).then(function mySucces(response) {
	    	    	bar.end();
	    	    	getData('');	    	    	
	    	    }, function myError(response) {
	    	    	bar.end();
	    	    });
	 		});		
			
			
			$('#searchBtn').on('click', function(e){
				getData($('#searchStr').val());
			});		
	 		
			$('#searchStr').on('keyup', function(e){
				if(e.keyCode == 13 ){
					$('#searchBtn').trigger('click');						 	 						
				}						 	 					
			});

			
			var getData = function(str){					
				var bar = new loadingBar("picTxt");
				bar.start();					
				$http({
					method : 'POST',					 	    	    
	    	        url : rpath+"/pic/picDirList.do?searchStr="+str
	    	    }).then(function mySucces(response) {
	    	    	bar.end();	    	    	
	    	    		    	    		
	    	    		$(response.data.dir).each(function(n,data){
	    	    			if(userSet.SET2=='2'){
	    	    				data.THIS_PATH = "1";
	    	    			}
	    	    			data.RANDOM  = (new Date()).toString();
	    	    		});	    	    		
	    	    	
	    	    	
	    	    	if(cnt != 'all'){
	    	    		$('#nextView1').show()
	    	    		gData = "";
	    	    		dat = response.data.dir.slice(0, cnt);
	    	    		gData = response.data.dir.slice(cnt);
	    	    		if($(gData).size()==0 ){
	    	    			$('#nextView1').hide();	
	    	    		}
	    	    			
	    	    	}else{
	    	    		dat = response.data.dir;
	    	    		
	    	    	}	    

	    	    	$scope.data =dat
	    	         
	    	    }, function myError(response) {	    	    	
	    	    	bar.end();
	    	    	//오류발생
	    	    });
			}
			getData('');
			
			
    	});
	}
	selectAngularPicDir();
	
	/**===================setup 설정==========================**/
	var authInfo =setData.init($('#authRow'));
	authInfo.clear();
	 	authInfo.matching = {
 	 	 '.auth_dir' 	: ['' , function(dat){		 	 		 
 	 		 if(dat.LEVEL <= 1 ){		 	 			 
 	 			$(this).text(dat.DIR);	 
 	 		 }else{
 	 			 var html = "";
 	 			 var sp = $("<span>").css("padding-left",dat.LEVEL*15+"px").html("┖   &nbsp;&nbsp;"+dat.DIR);		 	 			
 	 			$(this).html(sp);		 	 			
 	 		 }
 	 	 }],
 	 	 '.auth_check' 	: ['', 
 	 	       function(dat){
 	 		 		var html = "";
 	 		 		var viewInfos = dat.VIEW_YN.split(",");
 	 		 		for(var i = 0 ; i < viewInfos.length ; i++ ){	 	 		 			
 	 		 			var viewCheck = viewInfos[i].split("-");
 	 		 			var label = viewCheck[1];
 	 		 			var value = viewCheck[2] == "Y"? "checked" : "";
 	 		 			var o = $("<label auth="+viewCheck[0]+"><input  type = 'checkbox' "+value+" />"+label+"</label>").on("change", function(){
 	 		 				var dir = dat.DIR;
 	 		 				var par = dat.PARENT;
 	 		 				var auth = $(this).attr('auth');
 	 		 				var val = $(this).find(':checkbox').is(':checked') == true? 'Y' : 'N'  ;
 	 		 				
 	 		 				$.ajax({
 	 		 		 			type        : "POST",
	 	 		 		 		timeout 	: "6000000", //100분
 	 		 		 			data : {DIR: dir , AUTH : auth , VIEW_YN : val, PARENT : par },
 	 		 		 			url :  rpath+"/pic/updateAuthDir.do", 			
 	 		 		 			success : function(data){ 	 				
 	 		 		 				authInfo.setData(data.authDir); 				
 	 		 					},
 	 		 		 			error : function(request, status, error){ 				
 	 		 		 			alertPop("오류가 발생하였습니다.");
 	 		 		 			}
 	 		 		 		});	 	 		 					 	 		 				
 	 		 			}); 	 
 	 		 			$(this).append(o);
 	 		 		}	 	 		 		
 	 	 		}] 	 	 
 	 	};
	
	function fn_changeSort(){
		
		var n = "0";
		if($('#changeSort').text() =='▲'){
			n = 1;
			v = '▼';
		}else{ 
			n = 0;
			v = '▲';
		}
		
		$.ajax({
 			type        : "POST",
 			url :  rpath+"/pic/updateDirSort.do",
 			data : {srt : n, dir : clickPic},
 			success : function(data){ 	 				 				
 				$('#changeSort').text(v);	
			},
 			error : function(request, status, error){ 				
 				alertPop("오류가 발생하였습니다.");
 			}
 		});
	}
	function selSetupInfo(){ 
 		var lv ="${user.AUTH_LEVEL}";
 		function setRadio(data){
			$(data).each(function(n, dat){			
				$('#setupBody').find('[name='+dat.SET_KEY+']:radio').val([dat.VALUE]);
			});
 		} 		
 		if(lv < 2){
 			$('#authSetup').show();
	 		
 		
 		}else{ 			
 			$('#authSetup').hide();
 		}
 		$.ajax({
 			type        : "POST",
 			url :  rpath+"/main/setupInfo.do", 			
 			success : function(data){ 	 				
 				setRadio(data.setup); 				
 				if(lv < 2){
 					authInfo.setData(data.authDir);
 				}
 				
			},
 			error : function(request, status, error){ 				
 				alertPop("오류가 발생하였습니다.");
 			}
 		});
 	}
	
	
	
	var uploadPath =setData.init($('#uploadPathRow')); 	 
	//=========================upload경로 가져오기==================//
	function selUploadInfo(){				
		uploadPath.clear();
		uploadPath.matching = {
	 	 	 '.upload_dir' 	: ['' , function(dat){		 	 		 		 	 		 
						 	 			 var html = "";
						 	 			 var a = "";	
						 	 			 var v = "";
						 	 			 var addBtnName = "+폴더추가";
						 	 			 if(dat.LEVEL > 1){
						 	 				 a = "┖&nbsp;&nbsp;";
						 	 			 } 
						 	 			 v = a+dat.DIR;						 	 				 
						 	 				if(mobile=='mobile'){
						 	 				addBtnName = "+";						 	 				
						 	 			 }
						 	 			 
						 	 			 var lv =(dat.LEVEL-1)*5;
						 	 			 var btn = $('<button type="button"  style="margin-left:5px" class="addPathBtn btn btn-sm btn-default">'+addBtnName+'</button>');
						 	 			 if(dat.LEVEL > 1){
						 	 				$(btn).hide();						 	 				
						 	 			 }
						 	 			 
						 	 			 $(this).parent('tr').find('td').eq(0).html(btn);
						 	 			 						 	 			 						 	 			
						 	 			 var sp = $("<a>").css({"padding-left":lv+"px", "color":"#333", "cursor":"pointer"}).attr("FULL_PATH", dat.FULL_PATH).html(v).on("click", function(){				
						 	 				 alertPop("경로가 선택되었습니다.");
						 	 				 $('#filePath').val(dat.FULL_PATH);
						 				});						 	 									 	 		
						 	 			$(this).html(sp);						 	 									 	 			
						 	 			$(btn).on("click", function(e){						 	 				
						 	 				var idx = $('.addPathBtn').index(this);
						 	 				var FULL_PATH = $(this).parents('tr').find('a').attr("FULL_PATH");
						 	 				var dt = [{DIR : "" , LEVEL : dat.LEVEL+1, FULL_PATH :FULL_PATH }];
						 	 				uploadPath.setData(dt , idx+1);
						 	 				plusPath(idx, dat.LEVEL+1, FULL_PATH);
						 	 			})
						 	 			
							 	 	 }]				 	 	 
 	 	}
		$.ajax({
 			type        : "POST",
 			url :  rpath+"/pic/selectUpPathList.do", 			
 			success : function(data){ 	 				 				
 				uploadPath.setData(data.upList);
			},
 			error : function(request, status, error){ 				
 				alertPop("오류가 발생하였습니다.");
 			}
 		});
	}
	
	//============폴더생성 버튼=================
	$('#newUpDir').on('click', function(){ 	
		var dt = [{DIR : "" , LEVEL : 1, FULL_PATH :"" }];
		uploadPath.setData(dt , 0);
		plusPath(-1, 1, "");
 	});
	
	
	//=========================에러이미지 설정==================//
	function setErrImg(obj){		
		 if(userSet.SET2 == '2' ){			 
			 $(obj).hide();	 			 
		 }else{			 
			 $(obj).attr("src", rpath+"/images/jo/noImg2.jpg");
		 }
		
	}
	
	function plusPath(idx, level, FULL_PATH){		
		var input = $('<input style="margin-left:0px; width:90%; border:0px ;border-bottom: 1px solid gainsboro; background-color: transparent;">');						 	 				
		var btn = $('.addPathBtn').eq(idx+1);
		var sp = $(btn).parents('tr').find('a').hide();						 	 				
		$(sp).empty().after(input);						 	 				
		$(input).focus().on('blur', function(e){						 	 					
			var val = this.value;
			if(val == ""){ 								
				alertPop("폴더명을 입력해 주세요.");
				$(this).parents('tr').remove();
				return;				
			}
			 
			if((","+val).indexOf(",20") == -1 && level < 2 ){
				alertPop("날짜형식 + 이벤트명으로 기입해주세요");
				$(this).parents('tr').remove();				
				return;				
			}
			
			$(this).hide();
			var a = "";								 	 											 	 			
			if(level > 1){
 				a = "┖&nbsp;&nbsp;";		
 			 }		
			$(sp).off('click');
			
			var fullPathVal = (FULL_PATH==''?'':FULL_PATH+"/")+val;					 	 					
			$(sp).attr("FULL_PATH",fullPathVal).html((a+val)).show().on("click", function(){	
				alertPop("경로가 선택되었습니다.");
				$('#filePath').val(fullPathVal);				
			});
			var v = $("<img>").css({"margin":"0px","margin-left":"20px","width":"24px", "height":"24px", "cursor":"pointer" }).attr("src",rpath+"/images/jo/edit6.png" );						 	 					
			$(this).after(v);
			var _this = this;
			 
			$(v).on("click", function(){
				if($('#filePath').val()==fullPathVal){					
					$('#filePath').val("");
					$('#filePath').trigger("blur");					
				}						 	 						
				$(sp).empty();
				$(sp).hide();
				$(v).remove();
				$(_this).show().focus();						 	 						
			});
		}).on('keyup', function(e){
			if(e.keyCode == 13 ){
				$(this).trigger('blur');						 	 						
			}						 	 					
		});

	}
	

	//다운로드 팝업
 	var downPopView = function(obj, ev, dat){
		
 		$('#dirPathPop').hide();
 		$('#sAuthPop').hide();
		
		var prop = $(obj).prop('tagName');
		var left= $(obj).offset().left; 							     		
 		var top= $(obj).offset().top;
 	   	var x = ev.pageX;
        var y = ev.pageY;
        if(x == undefined){
        	var et = ev.originalEvent;						            	
        	x = et.touches[0].screenX;						            	
        	y = et.touches[0].screenY;
        }									            
        if($(document).scrollTop()> top ){
        	top = $(document).scrollTop();					            	
        }
 		$('#layerpop').css({'top':top, 'left':left}).fadeIn(500); 		
 		$('#layerpop').attr({'curX':x, 'curY':y});
 		
 		$('#layerpop').find('#down1').off('click');	//초기화
 		$('#layerpop').find('#down2').off('click'); //초기화
 		$('#layerpop').find('#chgPic').off('click');//초기화
 		$('#layerpop').find('#uploadThisDir').off('click');//초기화
 		$('#layerpop').find('#rotImg').off('click');//초기화
 		
 		
 		
 		if(prop != 'VIDEO'){
 			$('#down1').show();
 			$('#down2').show();
 	 		
 	 		$('#layerpop').find('#down1').on('click', function(){
 	 			var v = dat.thisOrgPath;
 	 			window.location.href = rpath+'/pic/downloadImg.do?name='+encodeURI(v);
 	 		});	
 	 		
 	 		
 	 		$('#layerpop').find('#down2').on('click', function(){
 	 			var v = dat.thisPath;
 	 			window.location.href = rpath+'/pic/downloadImg2.do?name='+encodeURI(v);	
 	 		});
 	 		
 		}else{ 			
 			$('#down1').hide();
 			$('#down2').hide(); 			
 		}
 		
 		
 		$('#layerpop').find('#chgPic').on('click', function(){ 		
	 			var name = dat.thisPath;
	 			var thDir = $('#portfolioModal1 .modal-body').find('h2').text(); //위치
	 			$.ajax({
	 	 			type        : "POST",
	 	 			url :  rpath+"/pic/changeThumbnail.do",
	 	 			data : {name : name, thDir : thDir},
	 	 			success : function(data){ 	 				
	 	 				$('#picRow').find('img').each(function(){
	 	 					var src = $(this).attr("src").split("?")[0]+"?"+Math.random();
	 	 					$(this).attr("src",src);
	 	 					alertPop("변경되었습니다.");
	 	 				}) ;				
	 				},
	 	 			error : function(request, status, error){ 				
	 	 				alertPop("오류가 발생하였습니다.");
	 	 			}
	 	 		});
	 		}); 	 		
			
 		
 		var nullTxt = "하위폴더 입력"; 		
		$('#filePath_s').on("focus", function(){ 					
			if($('#filePath_s').val()==nullTxt)
			$('#filePath_s').val(""); 					
		});
 		
 		
 		$('#layerpop').find('#uploadThisDir').on('click', function(){ 			
 			var v = dat.thisOrgPath; 			 			
 			
 			if( v.indexOf('/') == -1){ 				 				
 				return;
 			} 			
 			
 			var vstr = v.split("/");
 			
 			
 			if(vstr.length == 2){
 				
 				$('#parPath').text(vstr[0]+" /");
 				$('#filePath_s').val(nullTxt); 				
 				
 			}else if(vstr.length >2){
 				$('#filePath_s').off("focus");	
 				$('#parPath').text(vstr[0]+" /");
 				$('#filePath_s').val(vstr[1]);
 			}
 			
 			
 			var left= $('#layerpop').offset().left; 							     		
 	 		var oTop = $('#portfolioModal1').offset().top;
 	 		var tTop= $('#layerpop').offset().top;
 	 		var sTop = $('#portfolioModal1').scrollTop();
			 	 		
 	 		var top = sTop + (tTop-oTop)+20;
 			$('#dirPathPop').css({'top':top, 'left':left}).fadeIn(200); 		
 	 		//$('#dirPathPop').attr({'curX':x, 'curY':y});
 	 		$('#layerpop').fadeOut(100);
 	 		$('#upLoadBtn_s').off("click");
			$('#upLoadBtn_s').on("click",function(){
				var v1 = vstr[0];
				var v2 = $('#filePath_s').val();
				if(v2 == nullTxt){
					v2 = "";
				}
				$('#filePath').val(v1+"/"+v2);
				$('#uploadFile').trigger("click");
				$('#uploadBtnClose_s').trigger("click");
 			} );
 		});
 		
 		$('#layerpop').find('#rotImg').on('click', function(e){  			
 			var path = dat.thisPath;
 			$.ajax({
 	 			type        : "POST",
 	 			url :  rpath+"/pic/rotImg.do",
 	 			data : {path : path },
 	 			success : function(data){ 	 	
 	 					
 	 					if(prop == 'VIDEO'){ 	 						
 	 						var src = $(obj).attr("poster").split("?")[0]+"?"+Math.random();
 	 						$(obj).attr("poster",src); 	 						
 	 					}else{
 	 						var src = $(obj).attr("src").split("?")[0]+"?"+Math.random();
 	 	 					$(obj).attr("src",src); 	 						
 	 					}
 	 					
 	 					alertPop("변경되었습니다.");
 	 								
 				},
 	 			error : function(request, status, error){ 				
 	 				alertPop("오류가 발생하였습니다.");
 	 			}
 	 		});
 		});
 		
 	
 		if(lv >= 1 ){
 			$('#layerpop').find('#rotImg').hide();
 		}
	} 
	
	
	
	var sAuthInfo =setData.init($('#authRow_s'));
	
 	if(lv < 2){
 			$('#portfolioModal1 .modal-body').find('h2').click(function(){ 				
 				var sTop =140;
 				
 				var w = "100%";
 				
 				$('#sAuthPop').css({'top':sTop,'width':w, 'left':0 }).fadeIn(500);
 				sAuthInfo.clear();
 		 	 	sAuthInfo.matching = authInfo.matching; 
 		 		
 		 	 	
 		 	 	$.ajax({
 		 			type        : "POST",
 		 			data : {path : clickPic },
 		 			url :  rpath+"/main/setupInfo.do" , 			
 		 			success : function(data){ 	 				
 		 				if(lv < 2){
 		 					sAuthInfo.setData(data.authDir);
 		 				}
 		 				
 					},
 		 			error : function(request, status, error){ 				
 		 				alertPop("오류가 발생하였습니다.");
 		 			}
 		 		});
 		 	 	
 			});
 	}
 	</script>

</body>

</html>
