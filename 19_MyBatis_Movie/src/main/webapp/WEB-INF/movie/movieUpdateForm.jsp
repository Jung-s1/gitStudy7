<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>       
movieUpdateForm.jsp<br>
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
<%
	String[] continentList = {"아시아", "아프리카", "유럽", "아메리카", "오세아니아"};
	String[][] nationList = {
		    	{"한국", "중국", "베트남", "네팔"}, 
		    	{"케냐", "가나", "세네갈"}, 
		    	{"스페인", "영국", "덴마크", "러시아", "체코"}, 
		    	{"미국", "캐나다"},
		    	{"뉴질랜드", "오스트레일리아"} 
			};
%>

<c:set var="cList" value="<%= continentList %>"/>
<c:set var="nList" value="<%= nationList %>"/>

<%-- <body onLoad="init('${movie.continent}','${movie.nation}')"> --%>
    <table border="1">
        <form:form commandName="movie" name="myform" method="post" action="update.mv">
            <input type="hidden" name="num" value="${movie.num}"><br>
            <input type="hidden" name="pageNumber" value="${pageNumber}"><br>
            <input type="hidden" name="whatColumn" value="${whatColumn}"><br>
            <input type="hidden" name="keyword" value="${keyword}"><br>
            <h2>영화 정보 수정 화면</h2>
            <tr>
                <td>영화 제목</td>
                <td>
                    <input type="text" name="title" value="${movie.title}">
                    <form:errors path="title" cssClass="err"/>
                </td>
            </tr>
            <tr>
                <td>대륙</td>
                <td>
                    <select id="first" name="continent" onChange="firstChange()" style="width: 150px">
                        <option value="">대륙 선택하세요</option>
                        <c:forEach var="i" begin="0" end="${fn:length(cList)-1 }">
                        	<option value="${cList[i]}" <c:if test="${movie.continent eq cList[i]}">selected</c:if>>${cList[i]}
                        </c:forEach>
                    </select>
                    <form:errors path="continent" cssClass="err" />
                </td>
            </tr>
             <tr>
                <td>나라</td>
                <td>
                    <select id="second" name="nation" onChange="secondChange()" style="width: 150px">
                        <option value="">나라 선택하세요</option>
                        <c:forEach var="i" begin="0" end="${fn:length(cList)-1}">
                        	<c:if test="${cList[i] == movie.continent}">
                                <c:forEach var="j" begin="0" end="${fn:length(nList[i])-1}">
                                    <option value="${nList[i][j]}" <c:if test="${nList[i][j] == movie.nation}">selected</c:if>>${nList[i][j]}</option>
                                </c:forEach>
                        	</c:if>
                        </c:forEach>
                    </select>
                    <form:errors path="nation" cssClass="err" />
                </td>
            </tr>
            <tr>
                <td>장르</td>
                <td>
                    <%
                        String[] genreList = {"액션", "스릴러", "코미디", "판타지", "애니메이션"};
                    %>
                    <c:forEach var="genreItem" items="<%=genreList %>">
                        <input type="checkbox" name="genre" value="${genreItem}" <c:if test="${fn:contains(movie.genre, genreItem)}">checked</c:if>>${genreItem}
                    </c:forEach>
                    <form:errors path="genre" cssClass="err" />
                </td>
            </tr>
            <tr>
                <td>등급</td>
                <td>
                    <%
                        String[] gradeList = {"19", "15", "12", "7"};
                    %>
                    <c:forEach var="gradeItem" items="<%=gradeList %>">
                        <input type="radio" name="grade" value="${gradeItem}" <c:if test="${fn:contains(movie.grade, gradeItem)}">checked</c:if>>${gradeItem}
                    </c:forEach>
                    <form:errors path="grade" cssClass="err" />
                </td>
            </tr>
            <tr>
                <td>출연배우</td>
                <td>
                	<input type="text" name="actor" value="${movie.actor}">
                	<form:errors path="actor" cssClass="err" />
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="수정하기" id="btnSubmit"></td>
            </tr>
        </form:form>
    </table>
<!-- </body> -->
