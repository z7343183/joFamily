var pageId = new Date().getTime();
/**
 * [받아온 배열 테이블에 셋팅시키는 함수]
 * 설명 : 지정한 테이블에 있는 빈 TR들을 복사한 뒤 받아온 DATA와 같은 ID값이 있을 시 APPEND 한다.
 * 사용법  
 *    1. var tbl = fnTbl.init('#'+ 결과를 받아올 테이블); // 새로운 객체 생성(전역변수)
 * 	  2. setData(data) // AJAX로 받아온 리스트 데이터를 넣어줌
 * 	  3. setFn(id,function(){return 값}) //값에 적용할 함수
 * 	  4. setEvent(id,이벤트(click, blur),function(){ 적용할 이벤트 }) //엘레먼트 선택시 적용할 이벤트 	
 */
var fnTbl = {
		
		el  : "", //결과를 받을 전체 테이블
		$tbl  : "", //타입이 obj일때 el과 동일, list 일 때 tbody 아래 TR ELEMET
		fnObj : [], //함수적용 배열
		evObj : [], //이벤트적용 배열
		tblType : "", //list, obj
		dat : {}, //데이터
		emptyMsg : "검색결과가 없습니다.", //결과값이 없을 때 메세지(리스트일 때)
		init : function(element, type){ //init 할 때마다 새로운 객체 생성
			var o = new Object(); 
			$.extend(o,fnTbl);
			o.fnObj = []; //초기화
			o.evObj = []; //초기화
			o.dat ={};	  //초기화
			o.el = element;
			
			if(type == "obj"){
				o.tblType = "obj";
			}else{
				o.tblType ="list";
			}
			
			if(type == "obj"){ // 상세보기 같은 리스트 형식이 아닐 때 
				o.$tbl = $(element);
				o.$tbl.find('td').each(function(){ //TD 비우기
					if($(this).children().size()==0){ // TD 안에 엘리먼트들이 없으면
						$(this).empty(); //비운다 
					} 		 
				 });
				
			}else{ // 리스트 형식일 때 
				o.$tbl = $(element).find('tbody').children(); 
				o.$tbl.find('td').each(function(){ //TD 비우기
					if($(this).children().size()==0){ // TD 안에 엘리먼트들이 없으면
						$(this).empty(); //비운다
					} 		 
				 });
				 $(element).find('tbody').empty(); //ROW 삭제 
			}	 
			 return o;
		},
		setData : function(arr){ //데이터 셋팅
			this.dat = arr;
			var _this = this;
			if(_this.tblType != "obj"){
				$(_this.el).find('tbody').empty(); //row 삭제
				
			}else{
				arr = [arr];
			}
				if(arr != undefined&&arr.length>0){
					$.each(arr, function(n){
						var thisTr = "";
						if(_this.tblType != "obj"){
							$(_this.el).append(_this.$tbl.clone().addClass("thisTr"));
							thisTr = $(_this.el).find('.thisTr');  
						}else{
							thisTr = $(_this.el);
						}
						for(var key in this){
							var elName = key.toLowerCase();
							var $el = $(thisTr).find('#'+elName); //데이터 셋팅
							var keyValue = $.trim(this[key]);
							if($el == undefined){	
									
							}else if($el.prop("tagName")=="INPUT" || $el.attr("type")=="text" ||$el.prop("tagName")=="SELECT" ){
								if($el.attr("type")=="radio"){ //라디오 버튼일 때
									var name = $el.attr("name");
									var radioArr = $(thisTr).find('[name='+name+']');//같은 이름의 라디오 버튼을 가져온다.
									$(radioArr).each(function(n,dat){
										if($(dat).val() == keyValue){ 
											$el.prop("checked",true); //라디오 버튼에 값 셋팅
										}
									});
									
								}else{ //text 나 selectBox일때
									$el.val(keyValue);
								}
							}else{ //text area 등 일 때
								$el.html(keyValue);
							}
						}
						var data = this;
						
						//함수적용 -- 작업 ROW에 같은 이름의 ID가 있으면 셋팅 
						for(var key in _this.fnObj){
							
							var elName = key;
							var $el = thisTr.find('#'+elName);
							var fn = _this.fnObj[elName];
							if(typeof fn != 'function'){
								continue; 
							}
							var obj = $el;
							obj.data = data;
							var rst = fn.call(obj);
							if($el == undefined){	
								
							}else if($el.prop("tagName")=="INPUT" || $el.attr("type")=="text" ||$el.prop("tagName")=="SELECT" ){
								 $el.val(rst);
							}else{
								 $el.html(rst);
							}
							
						}
						
						//이벤트 적용 -- 작업 ROW에 같은 이름의 ID가 있으면 셋팅 
						var obj = [];
						for(var key in _this.evObj){
							var elName = key;
							var $el = thisTr.find('#'+elName);
							var ev =_this.evObj[elName]["event"];
							var evFn = _this.evObj[elName]["eventfn"];
							
							if(ev== "click") {
								$el.css("cursor","pointer");
							}
							obj = $el;
							obj.data = data;
							obj.key = key;
							if($el == undefined){	
							}else{
								$el.bind(ev,(function(fn,o) { 
									return function(e){
										fn.call(o,e);
									}; 
								})(evFn, obj)); 
							}
						}
						
						$(thisTr).removeClass("thisTr");  	
				});
				$(_this.el).find('tbody').show();
				
				
			}else{
				if(_this.tblType != "obj"){
					var colspan = this.$tbl.find('td').size();
					$(_this.el).append($('<tr class="trOver"><td colspan = '+colspan+' align="center" >'+this.emptyMsg+'</td></tr>'));
					$(_this.el).find('tbody').show();
				}
			}
		},
		setEmptyMag : function(str){ //검색 결과값이 없을 때 값 셋팅
			this.emptyMsg = str;
		},			
					
		setFn : function(str,fn){ //함수 부여
			if(typeof str =="string"){
				var obj = new Object();
				obj[str] = fn;
				$.extend(this.fnObj, obj);
			}else if(typeof str =="object"){
				$.extend(this.fnObj, str);
			}	 
		},
		
		setEvent : function(str,ev,fn,param){ //이벤트 셋팅
			if(typeof str =="string"){
				var obj = new Object();
				obj[str] = new Object;
				obj[str]["event"] = ev;
				obj[str]["eventfn"] = fn;
				$.extend(this.evObj, obj);
			}else if(typeof str =="object"){
				$.extend(this.evObj, str);
			}	
		}
	};



/**
 * RET 사용할 AJAX SETUP
 */
$.ajaxSetup({
	type        : "POST"
	,async      : true
	,dataType   : "json"
	,contentType: "application/x-www-form-urlencoded; charset=utf-8"		
	,error 	 : function(){alert("오류가 발생하였습니다. 다시 시도해 주세요.");}
	
});


var loadingBar = function(id){
	var _this = this;
	_this.start = function(){
		$('#'+id).showLoading({'addClass': 'loading-indicator-bars'});
	}; 
	
	_this.end = function(){
		$('#'+id).hideLoading();
	}; 
};

var ajax = {
		run : function(url,param,callback,opt){																		
			var o = new Object();
			o.url = url;
			o.data = param;
			o.success = [function(){ callback(data);}];
			if(opt != ""&&opt != undefined){
				$.extend(o,opt);
			}
			$.ajax(o);
	} 
	
};



/**
 * 자바스크립트 replaceAll
 */
String.prototype.replaceAll = function(str2,str3){
	str1 = String(this);
	if(str3==undefined){str3 = ""; }
	return str1.replace(eval("/["+str2+"]/gi"),str3);
};



/**
 * 'NULL' 처리 
 */
String.prototype.nullString = function(){
	var str = String(this);
	return str.replaceAll( /null/gi, "" );
};


/**
 * 화폐형식
 */
function setComma(str){
	
	str = String(str);
	str = str.replace(/,/g,"");
	var reg = /^[0-9]+$/;
	
	if( !reg.test(str) ){
		return "";  //숫자가 아닐때
	}
	var retValue = "";
    for(var i=0; i<str.length; i++)
    {
    	if(i > 0 && (i%3)==0) {
                retValue = str.charAt(str.length - i -1) + "," + retValue;
         } else {
                retValue = str.charAt(str.length - i -1) + retValue;
        }
    }
    return retValue; 
	
}

/**
 * 날짜형식
 */
function setDate(str){
	
	if(str == undefined|| (str.length != 8 && str.length != 6 &&str.length != 4 )){
		return;
	}
	if(str.length==8){
		str = str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2);
	}else if(str.length == 6){
		str = str.substr(0,4)+"-"+str.substr(4,2);
	}
    return str; 
}


/**
 * [유효성 검증]
 * inputChk.load() //DOM element에 이벤트를 부여 
 * inputChk.checkAll() //insert나 update시 element 일괄적 유효성 체크
 * 
 */
var inputChk = {
		customFn : [],
		load : function(){ //입력시 체크
			var _this = this;
			$.extend(_this,this.customFn);
			$(":input[data-type]").each(function(n){
				var el = this;
				var fnArr = $(el).attr('data-type').split(" ");
				$(el).bind("blur focus keyup keydown change keypress", function(e){
					var chk = true;
					$.each(fnArr,function(){
						var fn = this;
						if(chk){
							if( _this[fn] != undefined){
								chk = _this[fn](el, e);
							}
						}
					});
				});
			});
		}, 
		
		checkAll : function(element){ //일괄 체크
			var _this = this;
			$.extend(_this,this.customFn);
			var chk = true;
			$(element).find(":input[data-type]").each(function(n){
				var el = this;
				var fnArr = $(el).attr('data-type').split(" ");		
				$.each(fnArr,function(){
					var fn = this;
					if(chk){
						if( _this[fn] != undefined)
						chk = _this[fn](el);
					}
				});				
			});	
			return chk;
		},
		priceChk : function(obj,event){ //화폐 제거
			if(event == undefined  || event.type == "focus" || event.type == "blur" ){
				/*
				if( event != undefined && event.type == "keyup"){
					if((event.keyCode>=37 &&event.keyCode <=40)||event.keyCode ==8 ){
						return; 
					} //시세를 입력할 때 계속 자릿수를 체크해서 처리하기 때문에 한번 한번 입력할때마다 포인트를 잃어버려서 주석처리 
					
				}*/
				var str = $(obj).val(); 
				if(str =="") return; 
				str = str.replace(/,/gi,"");
				if( event != undefined && event.type == "focus"){ //포커스 일때 콤마 제거
					$(obj).val(str);
					return true;
				}else{	
					var reg = /^[0-9]+$/;
					if( !reg.test(str) ){
						if(event == undefined || event == "blur") alert("숫자만 입력해 주세요");
						var val = setComma($(obj).val().replace(/[^0-9]|,/g,""));
						$(obj).val(val);
						$(obj).focus();
						return false;
					}else{
						var val = setComma($(obj).val());
						$(obj).val(val);
					}
					return true;
				}	
			}
			return true;
		},
		numberChk : function(obj, event){ //숫자만
			if(event == undefined ||  event.type == "keyup" || event.type == "blur" ){
				
				if( event != undefined && event.type == "keyup"){
					if((event.keyCode>=37 &&event.keyCode <=40)||event.keyCode ==8 ){
						return; 
					}
				}
				
				var str = $(obj).val();
				if(str =="") return true;
				var replaceReg = "";
				if($(obj).attr("data-pointYn")=="Y"){
					replaceReg = /[^0-9|.]/g;
					str = str.replace(/\./gi,"");
				}else{
					replaceReg = /[^0-9]/g;
				}
				
				var reg = /^[0-9]+$/;
				if( !reg.test(str) ){
					if( event == undefined  || event.type == "blur") alert("숫자만 입력해 주세요");
					var val = $(obj).val().replace(replaceReg,"");
					$(obj).val(val);
					 $(obj).focus();
					return false;
				}
			}
			return true;
		},
		
		lengthChk : function(obj,event){ //글자수 제한 
			if(event == undefined || event.type == "blur"){
				var minLength = $(obj).attr("data-minLength"); 
				var maxLength = $(obj).attr("data-maxLength");
				var valLength =$(obj).val().length;
				
				if(minLength != "" && valLength <= parseInt(minLength,10)){
					alert("최소 "+minLength+"자 이상 입력해 주세요.");
					$(obj).focus();
					return false;
				}else if(maxLength != "" && valLength >= parseInt(maxLength,10)){
					alert(maxLength+"자 이하로 입력해 주세요.");
					$(obj).focus();
					return false;
					
				}
			}
			return true;
			
		},cal : function(obj,event){
			if(event == undefined || event.type == "blur"){
				var str = $(obj).val(); 
				if(str =="") return true; 
				str = str.replace(/-/gi,"");
				var reg = /^[0-9]+$/;
				
				if( !reg.test(str) ){
					alert("숫자만 입력해 주세요");
					var val = $(obj).val().replace(/[^1-9]|-/g,"");
					$(obj).val(val);
					$(obj).focus();
					return false;
				}
				
				var calType = $(obj).attr("data-cal-type");
				
				var calTypeArr =[];
				if(calType==""||calType==undefined){
					calTypeArr.push("day"); //default
				}else{
					calTypeArr = calType.split(" ");
				}
				
				var typeChk = false; 
				$.each(calTypeArr, function(n,dat){
					if(dat == 'year'&& str.length == 4 ){
						typeChk = true;
					}else if(dat == 'month'&& str.length == 6){
						typeChk = true;
					}else if(dat == 'day'&& str.length == 8){
						typeChk = true;
					}
				});
				
				if(str.length>0 && typeChk ==false){ 
					alert("잘못된 형식입니다.");
					$(obj).val("");
					$(obj).focus();
					return false;
				}else{
					$(obj).val(setDate(str));
				}
			}
			return true;
		
		}, notNull : function(obj, event){ //빈값 체크(이벤트 적용안함)
			if(event == undefined){
				var str = $(obj).val().replaceAll(" "); 
				if(str =="") {
					var name = $(obj).attr("data-title");
					if(name == "" || name == undefined){
						name = $(obj).attr("alt");
					}
					var type = $(obj).prop("tagName");
					if(type =="SELECT"){
						alert("["+name+"]를 선택해 주세요.");
					}else{
						alert("["+name+"]를 입력해 주세요.");
					}
					
					$(obj).focus();
					return false; 
				}
			}
			return true;
			
		}, notNull2 : function(obj,event){ //빈값 체크(이벤트 적용)
			if(event == undefined || evnet == "blur"){
				var str = $(obj).val().replaceAll(" "); 
				if(str =="") {
					var name = $(obj).attr("data-title");
					if(name == "" || name == undefined){
						name = $(obj).attr("alt");
					}
					alert("["+name+"]에 빈값을 입력할 수 없습니다.");
					$(obj).focus();
					return false; 
				}
			}
			return true;
		}, 
		setCustomFn : function(str,fn){ //사용자 함수 추가
			if(typeof str =="string"){
				var obj = new Object();
				obj[str] = fn;
				$.extend(this.customFn, obj);
			}else if(typeof str =="object"){
				$.extend(this.customFn, str);
			}	 
		}
		
} ;

/**
 * [페이지 만드는 함수]
 * setPaging.init() //페이징 객체 생성
 */
var setPaging = {
		data : "",
		name : "",
		fn : "",
		init : function(data,name,fn){
			var o = new Object();
			$.extend(o,setPaging);
			o.data = data;
			o.name = name;
			o.fn = fn;
			o.load();
			return o;
		},
		
		load : function(){
			var _this = this;
			$('#'+this.name).empty();
			$('#'+this.name).append($('<ul/>',{ "class" : "paging"})); //전체
			$('ul.paging').append($('<li/>') //맨처음
					.append($('<a/>', {"class" : "first"} )
							.css("cursor","pointer")
							.click(function(){
								_this.fn(1);
							})
							.append($('<img/>',{"src" : "../images/btn_first.gif" , "alt" : "처음" }) 
					)
			));
			
			$('ul.paging').append($('<li/>', {"class" : "li01"})  //이전구간
					.append($('<a/>', {"class" : "prev"} )
							.css("cursor","pointer")
							.click(function(){
								if(_this.data.firstPageNoOnPageList-1 > 0){
									_this.fn(_this.data.firstPageNoOnPageList-1);
								}else{
									_this.fn(1);
								}	
								
								
							})
							.append($('<img/>',{"src" : "../images/btn_prew.gif" , "alt" : "이전구간" }) 
					)
			));
			var first = _this.data.firstPageNoOnPageList;
			var end = _this.data.lastPageNoOnPageList;
			var curPage = _this.data.currentPageNo;
			for(var i = first ; i<= end ; i++ ){ //각 페이지
				if(curPage == i){
					$('ul.paging').append($('<li/>')
							.append($('<strong>')
									.text(i)
					));
				
				}else{
					
					$('ul.paging').append($('<li/>')
							.append($('<a/>')
									.css("cursor","pointer")
									.click(function(){
										_this.fn($(this).text());
									}).text(i)
					));
				}	
				
			}
			
			$('ul.paging').append($('<li/>', {"class" : "li02"}) //다음구간
					.append($('<a/>', {"class" : "prev"} )
							.css("cursor","pointer")
							.click(function(){
								if(_this.data.lastPageNoOnPageList+1 < _this.data.totalPageCount){
									_this.fn(_this.data.lastPageNoOnPageList+1);
								}else{
									_this.fn(_this.data.totalPageCount);
									
								}	
							})
							.append($('<img/>',{"src" : "../images/btn_next.gif" , "alt" : "다음구간" })
					)
			));
			
			$('ul.paging').append($('<li/>') //맨마지막
					.append($('<a/>', {"class" : "nextEnd"} )
							.css("cursor","pointer")
							.click(function(){
								_this.fn(_this.data.totalPageCount);
							})
							.append($('<img/>',{"src" : "../images/btn_last.gif" , "alt" : "마지막" })
					)
			));
		}
};		        

//체크박스 컨트롤	
function setCheckBox(name1,name2){
	$('[name=name1]').prop("checked",false);
	$(':checkbox[name ='+name1+']').bind("click", function(){
		if($(this).prop("checked")==false){  //체크시 모두 선택
			$(':checkbox[name ='+name2+']:not([data-not-chk=Y])').each(function(){
					$(this).prop("checked",false);
					
			});
		
		}else{ //체크 해제시 모두 해제
			
			$(':checkbox[name ='+name2+']:not([data-not-chk=Y])').each(function(n){
					$(this).prop("checked",true);
			});
			
		}
		
});

	
	$(':checkbox[name ='+name2+']:not([data-not-chk=Y])').each(function(){
		
		$(this).bind('click',function(){

			if($(':checkbox[name=choice]:not([data-not-chk=Y])').size() == $(':checkbox[name=choice]:not([data-not-chk=Y]):checked').size()){
				$('[name ='+name1+']').prop("checked",true);
				
			}else{
				$('[name ='+name1+']').prop("checked",false);
			}
			
		});
		
		
	});
	
}



//지정영역에서 check한 row들의 input 타입들을 긁어서 JSON형태로 변환
function setCheckParam(chekName){
	$('[name='+chekName+']:checked').each(function(n){
		var param = new Object();
		var row = $(this).parents('tr');
		param = setParam(row);
		paramArr.push(JSON.stringify(param));
	
	});
	return paramArr;
}

//지정객체 안의 input 타입들을 [리터럴] 형태로 변환
function setParam(obj){
	var param = {}; 
	$(obj).find(':input').each(function(){
		var name = this.name;
		var val = "";
		if($(this).attr("data-type")!=undefined &&$(this).attr("data-type").indexOf("priceChk")>-1){
			if($(this).val() != null)
			val = $(this).val().replaceAll(",","");
		}else if($(this).attr("data-type")!=undefined &&$(this).attr("data-type").indexOf("cal")>-1){
			if($(this).val() != null)
			val = $(this).val().replaceAll("-","");
		}else{
			val = this.value;
		}
		param[name] = val;
	});
	return param;
}


//탭함수
function retTab(obj){
	$(obj).find('.TabbedPanelsTab').each(function(n){
		$(this).bind("click mouseover mouseout", function(e){
			var className = $(this).attr("class");
			if(className.indexOf("select")==-1){
				if(e.type=="mouseover"){
					$(this).addClass("TabbedPanelsTabHover");
				}else if(e.type=="mouseout"){
					$(this).removeClass("TabbedPanelsTabHover");
				}
			}
			if(e.type=="click"){
				$(obj).find('.TabbedPanelsTabSelected').removeClass("TabbedPanelsTabSelected");
				$(this).removeClass("TabbedPanelsTabHover");
				$(this).addClass("TabbedPanelsTabSelected");
				if(n==0){
					$(obj).find('.TabbedPanelsContent').hide();
					$(obj).find('.TabbedPanelsContent').show();
				}else{
					$(obj).find('.TabbedPanelsContent').hide();
					$(obj).find('.TabbedPanelsContent').eq(n-1).show();
				}
			}
		});
	});
}
 var setData = {
 		target   : {} , 
 		contents : {} ,	 
 		matching : {} ,		
 		insertRowIndex : "",
 		init : function(obj){ var o = new Object(); this.target = obj; this.contents = $(obj).children().clone(); $.extend(o,setData);  return o; },
 		clear : function(){ $(this.target).empty(); }, 		 	
 		setData : function(data, idx){ 			 			
 			if(data != undefined && data.length > 0 ) {
 				var matching = this.matching;
 				var target = this.target;
 				var contents = this.contents; 				
 				$(data).each(function(n,dat){
 					var $appendCont = $(contents).clone();
					for(var key in matching){
						var find = key;
						var $f = $appendCont.find(find);
						var matchingType= matching[key][0]	;
						var valueKey = "";
						if(typeof matching[key][1] == 'function' ){							
							var fn = matching[key][1];
							valueKey = fn.call($f,dat);																					
						}else{
							valueKey = dat[ matching[key][1] ];
						} ;						 
						if(matchingType == 'text'){
							$f.text(valueKey);
						}else if(matchingType == 'value'){
							$f.val(valueKey);
						}else if(matchingType.indexOf('attr.' > -1)){
							var att = matchingType.replace("attr.","");
							$f.attr(att, valueKey);
						}
						$appendCont.hide();
						
						if(idx == undefined){
							target.append($appendCont);								
						}else{		
							target.children().eq(idx).before($appendCont);
							idx++;
						}
						
						$appendCont.fadeIn(500);
						
 					}
 				}); 			
 			}
 		}
 	 };
