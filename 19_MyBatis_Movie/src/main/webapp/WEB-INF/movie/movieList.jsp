<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
movieList.jsp<br>
<script type="text/javascript">
	function insert(){
		location.href="insert.mv";
	}
	
	function goUpdate(num, pageNumber){
		location.href="update.mv?num="+num+"&pageNumber="+pageNumber;
	}
	
</script>
<style>
	td{
		text-align: center;
	}
</style>

<h2 align="center">Movie List(${pageInfo.totalCount}/${totalCount})</h2>
<center>
현재 클릭한 페이지 ${pageInfo.pageNumber }<Br>
<form action="list.mv" method="get"> <!-- 검색 폼 시작 -->
    <select name="whatColumn"> <!-- 검색 조건 선택하는 드롭다운 메뉴 -->
        <option value="all">전체 검색</option> <!-- 모든 컬럼 검색 옵션 -->
        <option value="genre">장르 검색</option> <!-- 장르로 검색하는 옵션 -->
        <option value="grade">관람등급 검색</option> <!-- 관람등급으로 검색하는 옵션 -->
        <option value="actor">배우 검색</option> <!-- 배우로 검색하는 옵션 -->
    </select>
    <input type="text" name="keyword"> <!-- 검색어 입력창 -->
    <input type="submit" value="검색"> <!-- 검색 버튼 -->
</form> <!-- 검색 폼 끝 -->

    <!-- 영화 목록을 나타내는 테이블 -->
    <table border="1" >
        <tr>
            <td>
                <input type="button" value="추가" onclick="insert()"> <!-- 추가 버튼 -->
            </td>
        </tr>
        <tr>
    		<th>번호</th>
    		<th>제목</th>
    		<th>대륙</th>
    		<th>국가</th>
    		<th>장르</th>
    		<th>관람등급</th>
    		<th>배우</th>
    		<th>수정</th>
    		<th>삭제</th>
    	</tr>
        <!-- 영화 목록을 출력하는 반복문 -->
        <c:forEach var="movie" items="${lists}">
            <tr>
                <td>${movie.num}</td>
    			<td><!-- 제목 -->
    				<a href="detail.mv?num=${movie.num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}">${movie.title}</a>
    			</td>
                <td>${movie.continent}</td> <!-- 대륙 -->
                <td>${movie.nation}</td> <!-- 국가 -->
                <td>${movie.genre}</td> <!-- 장르 -->
                <td>${movie.grade}</td> <!-- 관람등급 -->
                <td>${movie.actor}</td> <!-- 배우 -->
                <%-- <td><input type="button" value="수정" onClick="goUpdate('${movie.num}','${pageInfo.pageNumber}')"></td> --%>
                <td><a href="update.mv?num=${movie.num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}">수정</a></td>
                <td><a href="delete.mv?num=${movie.num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}">삭제</a></td>
            </tr>
        </c:forEach>
    </table>
    ${pageInfo.pagingHtml }
</center>
