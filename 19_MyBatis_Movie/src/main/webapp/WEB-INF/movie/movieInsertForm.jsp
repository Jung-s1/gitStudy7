<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>       
movieInsertForm.jsp<br>
<style>
   .err {
      color: red;
      font-size: 12px;
      font-weight: bold;
      font-style: italic;
   }
</style>

<script>
   var f_selbox = new Array('아시아','아프리카','유럽','아메리카','오세아니아');
   
   var s_selbox = new Array();
   s_selbox[0] = new Array('한국','중국','베트남','네팔');
   s_selbox[1] = new Array('케냐', '가나', '세네갈');
   s_selbox[2] = new Array('스페인', '영국','덴마크','러시아','체코');
   s_selbox[3] = new Array('미국', '캐나다'); 
   s_selbox[4] = new Array('뉴질랜드','오스트레일리아');
   var selectContinent;
   
   function init(mc, mn) {
	   //alert('init');
	  //alert(mc +"/" + mn); // 아프리카/ 세네갈
      document.myform.first.options[0] = new Option("대륙 선택하세요",""); // text, value
      document.myform.second.options[0] = new Option("나라 선택하세요",""); // text, value
      for(i=0; i<f_selbox.length; i++) {
         document.myform.first.options[i+1] = new Option(f_selbox[i],f_selbox[i]);
         if(document.myform.first.options[i+1].value == mc){
        	 document.myform.first.options[i+1].selected = true;
        	 selectContinent = i; // 아프리카:1
         }
      }//for
      
      for(var j=0;j<s_selbox[selectContinent].length;j++){
    	  document.myform.second.options[j+1] = new Option(s_selbox[selectContinent][j]);
    	  if(document.myform.second.options[j+1].value == mn){
         	 document.myform.second.options[j+1].selected = true;
          }
      }//for
   }//init
   
   function firstChange() {
      var index = document.myform.first.selectedIndex; // 아프리카:2
      
      for(i=document.myform.second.length-1; i>0; i--) {
         document.myform.second.options[i] = null;
      } 
      
      for(i=0; i<s_selbox[index-1].length; i++) {
         document.myform.second.options[i+1] = new Option(s_selbox[index-1][i]);
      }  
   } //firstChange

</script>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() { 
	//alert(1);
	
	var use;
	var isCheck = false;
	
	$('#title_check').click(function(){ // 중복체크 클릭
		//alert(2);
		isCheck = true;
		
		$.ajax({
			url : "title_check_proc.mv",
			type : "post",
			data : ({
				inputtitle : $('input[name=title]').val() // inputtitle=배트맨
			}),
			success :function(data){
				
				if($('input[name=title]').val() ==""){
					$('#titleMessage').html("<font color=red>title 입력 누락</font>");
					$('#titleMessage').show();
					
				}else if(data == 'YES'){
					$('#titleMessage').html("<font color=blue>사용가능합니다.</font>");
					$('#titleMessage').show();
					use = "possible";
				}else{
					$('#titleMessage').html("<font color=red>이미 등록한 제목입니다.</font>");
					use = "impossible";
					$('#titleMessage').show();
				}
			}
		});
	}); // 중복체크 click
	
	$('input[name=title]').keydown(function(){
		isCheck = false;
		use = "";
		$('#titleMessage').css('display','none');
	});
	
	$('#btnSubmit').click(function(){
		if(use == "impossible"){
			alert("이미 사용중인 제목입니다.");
			return false;
		}else if(isCheck == false){
			alert("중복체크를 하세요");
			return false;
		}
	}); // btnSubmit click
});
</script>

${movie.continent } / ${movie.nation} <br>

<body onLoad="init('${movie.continent }','${movie.nation}')"> 
   <form:form commandName="movie" name="myform" action="insert.mv" method="post">
   <h2>영화 정보 등록 화면</h2>
   <p>
      영화 제목 : <input type="text" name="title" value="${movie.title}">
      <input type="button" id="title_check" value="중복체크">
      <span id="titleMessage"></span>
      <form:errors path="title" cssClass="err"/>
   </p>
   
   <p>
      대륙 : 
      <select id="first" name="continent" onChange="firstChange()" style="width: 150px">
      	<!-- <option value="">대륙 선택하세요</option> -->
      </select>
     <%--  <c:if test="${movie.continent}">
         
      </c:if> --%>
      <form:errors path="continent" cssClass="err" />

      나라 : 
      <select id="second" name="nation" onChange="secondChange()" style="width: 150px"></select>
      <form:errors path="nation" cssClass="err"/>
   </p>
   
   <p>
      장르 : 
      <input type="checkbox" name="genre" value="액션" <c:if test="${fn:contains(movie.genre,'액션')}">checked</c:if>>액션
      <input type="checkbox" name="genre" value="스릴러" <c:if test="${fn:contains(movie.genre,'스릴러')}">checked</c:if>>스릴러
      <input type="checkbox" name="genre" value="코미디" <c:if test="${fn:contains(movie.genre,'코미디')}">checked</c:if>>코미디
      <input type="checkbox" name="genre" value="판타지" <c:if test="${fn:contains(movie.genre,'판타지')}">checked</c:if>>판타지
      <input type="checkbox" name="genre" value="애니메이션" <c:if test="${fn:contains(movie.genre,'애니메이션')}">checked</c:if>>애니메이션
      <form:errors path="genre" cssClass="err"/>
   </p>
   
   <p>
      등급 : 
      <input type="radio" name="grade" value="19" <c:if test="${fn:contains(movie.grade,'19')}">checked</c:if>>19
      <input type="radio" name="grade" value="15" <c:if test="${fn:contains(movie.grade,'15')}">checked</c:if>>15
      <input type="radio" name="grade" value="12" <c:if test="${fn:contains(movie.grade,'12')}">checked</c:if>>12
      <input type="radio" name="grade" value="7" <c:if test="${fn:contains(movie.grade,'7')}">checked</c:if>>7
      <form:errors path="grade" cssClass="err"/>
   </p>
   
   <p>
      출연배우 : <input type="text" name="actor" value="${movie.actor}">
   </p>
   
   <p>
      <input type="submit" value="추가하기" id="btnSubmit">
   </p>
   </form:form>
</body>