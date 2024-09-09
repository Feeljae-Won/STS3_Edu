<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트</title>
<style type="text/css">
/* 이곳을 주석입니다. Ctrl + Shift + C로 자동 주석 가능. 그러나 푸는 건 안된다.
	선택자 {스타일 항목 : 스타일 값;스타일 항목 : 스타일 값;...}
	기본 선택자 : a - a tag, .a - a라는 클래스(여러개), #a - a라는 아이디(한개)
	다수 선택자 : ","로 선택. a, #a : a tag와 a라는 아이디
	상태 선택자 : ":". ":hover" - 마우스가 올라갔을 때.
				 "a:hover" - a tag 위에 마우스가 올라갔을 때
	선택의 상속 : a .data - a tag 안에 data class의 태그를 찾는다.
 */
.dataRow:hover{
	opacity: 70%; /* 투명도 */
	cursor: pointer;
}

.imageDiv{
	background: black;
}

.title{
  text-overflow: ellipsis;
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
 }
 
</style>

<script type="text/javascript">
$(function(){
	
	// 제목 해당 태그 중 제일 높은 것을 이용하여 모두 맞추기
	// console.log($(".title"));
	let titleHeights = [];
	
	$(".title").each(function(idx, title){
		console.log($(title).height());
		titleHeights.push($(title).height());
	});
	console.log(titleHeights.join(", "));
	
	let maxTitleHeight = Math.max.apply(null, titleHeights);
	console.log(maxTitleHeight);
	
	$(".title").height(maxTitleHeight);
	
	// 이미지 사이즈 조정 5:4
	let imgWidth = $(".imageDiv:first").width();
	let imgHeight= $(".imageDiv:first").height();
	console.log("image width=" + imgWidth + ", height=" + imgHeight)
	// 높이 계산 - 너비는 동일하다. : 이미지와 이미지를 감싸고 있는 div의 높이로 사용
	let height = imgWidth / 5 * 4;
	// 전체 imageDiv의 높이를 조정한다.
	$(".imageDiv").height(height);
	// 이미지 배열로 처리하면 안된다. foreach 사용 - jquery each()
	$(".imageDiv > img").each(function(idx, image){
		//alert(image);
		//alert(height);
		//alert($(image).height());
		// 이미지가 계산된 높이 보다 크면 줄인다.
		if($(image).height() > height){
			let image_width = $(image).width();
			let image_height = $(image).height();
			let width = height  / image_height * image_width;
			
			console.log("chaged image width = " + width);
			
			// 이미지 높이 줄이기
			$(image).height(height);
			// 이미지 너비 줄이기
			$(image).width(width);
			
		}
	});
	
	// 이벤트 처리
	$(".dataRow").click(function(){
		// alert("click");
		// 글번호 필요 - 수집
		let goods_no = $(this).find(".goods_no").text();
		console.log("goods_no = " + goods_no);
		console.log("searchVO = ${searchVO}");
		console.log("searchVO.query = ${searchVO.query}");
		location="view.do?goods_no=" + goods_no + "&inc=1"
				+ "&${pageObject.pageQuery}"
				+ "&${searchVO.query}"
				;
	});
	
	// 검색 버튼
	$("#searchBtn").click(function() {
		// alert("검색");
		// 검색 내용이 없으면 검색으로 가지 않는다.
		if($("#cate_code1").val() == 0 && $("#goods_name").val().trim() == ''
				&& $("#min").val() == 0 && $("#min").val() == ''
				&& $("#max").val() == 0 && $("#max").val() == ''
			) return false;
		
		// alert("안넘어감");
	});
	
	// 검색 데이터 세팅
	$("#cate_code1").val("${(searchVO.cate_code1 == null)?'0':searchVO.cate_code1}");
	$("#cate_code2").val("${(searchVO.cate_code2 == null)?'0':searchVO.cate_code2}");
	$("#min").val("${searchVO.min}");
	$("#max").val("${searchVO.max}");
	$("#goods_name").val("${searchVO.goods_name}");
	
	// 대분류 선택에 따른 중분류 리스트 가져오기
	$("#cate_code1").change(function() {
		$("#cate_code2").load("/ajax/getMidList.do?cate_code1="	+ $("#cate_code1").val() + "&mode=l");
		
	});
	
	// perPageNum 처리
	$("#perPageNum").change(function(){
		// alert("change perPageNum");
		// page는 1페이지 + 검색 데이터를 전부 보낸다.
		$("#searchForm").submit();
	});
	
});
</script>

</head>
<body>
<div class="container">
	  <h2>상품 리스트</h2>
	  <form action="list.do" id="searchForm">
	  	<input name="page" value="1" type="hidden">
	  	<input name="perPageNum" value="${pageObjcet.perPageNum }" type="hidden">
	  		<!-- 검색 항목 처리 -->
		  <div class="row">
		  	<div class="col-md-12 form-inline">
		  		<div class="form-group">
					<label for="cate_code1" class="mr-3"><b>> 대분류</b></label>
					<select class="form-control mr-3" id="cate_code1" name="cate_code1">
						<option value="0">대분류 선택</option>
						<c:forEach items="${bigList }" var="vo">
							<option value="${vo.cate_code1 }">${vo.cate_name }</option>
						</c:forEach>
					</select>
					<label for="cate_code2" class="mr-3"><b>> 중분류</b></label>
					<select class="form-control" name="cate_code2"
						 id="cate_code2"  style="margin: 0 10px;">
							<option value="0" selected>대분류 선택</option>
							<!-- ajax를 이용한 중분류 option 로딩하기 -->
					</select>
					<label for="min" class="mr-3" ><b>> 가격대</b></label>
					<input class="form-control mr-3" type="number" min="0" id="min" name="min" placeholder="최소 금액" 
						style="width:150px;">
					<label for="max" class="mr-3" ><b> ~ </b></label>
					<input class="form-control mr-3" type="number" min="0" id="max" name="max" placeholder="최대 금액"  
						style="width:150px;">
					
					<input class="form-control " id="goods_name" name="goods_name" placeholder="상품 명을 입력하세요.">
					<div class="input-group-append">
					    <button class="btn btn-outline-primary " id="searchBtn">
					     	<i class="fa fa-search"></i>
					    </button>
					</div>
				</div>
		  	</div>
		  </div>
		  	<!-- col-md-8의 끝 : 검색 -->
		  <div class="row">
		  	<div class="col-md float-right">
		  		<!-- 너비를 조정하기 위한 div 추가. float-right : 오른쪽 정렬 -->
		  		<div style="width: 200px;" class="float-right">
				  <div class="input-group mb-3">
				    <div class="input-group-prepend">
				      <span class="input-group-text">Rows/Page</span>
				    </div>
				    <select id="perPageNum" name="perPageNum" class="form-control">
				    	<option>6</option>
				    	<option>9</option>
				    	<option>12</option>
				    	<option>15</option>
				    </select>
				  </div>
			  </div>
		  	</div>
		  	<!-- col-md-4의 끝 : 한페이지당 표시 데이터 개수 -->
		  </div>
	  </form>
  <c:if test="${empty list }">
	 <div class="jumbotron">
	    <h4>데이터가 존재하지 않습니다.</h4>      
	  </div>
  </c:if>
  <c:if test="${!empty list }">
  	<div class="row">
	  	<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 시작 -->
	  	<c:forEach items="${list }" var="vo" varStatus="vs">
	  		<!-- 줄바꿈처리 - 찍는 인덱스 번호가 3의 배수이면 줄바꿈을 한다. -->
	  		<c:if test="${(vs.index != 0) && (vs.index % 3 == 0) }">
	  			${"</div>"}
	  			${"<div class='row'>"}
	  		</c:if>
	  		<!-- 데이터 표시 시작 -->
		  	<div class="col-md-4 dataRow">
		  		<div class="card" style="width:100%">
		  			<div class="imageDiv text-center align-content-center">
					  <img class="card-img-top" src="${vo.image_name }" alt="image">
		  			</div>
				  <div class="card-body">
				    <strong class="card-title">
				    	<span class="float-right">${vo.hit }</span>
				    	${vo.goods_name }
				    </strong>
				    <p class="card-text title">
				    	<div>
				    		상품 번호 : <span class="goods_no">${vo.goods_no }</span>
				    	</div>
				    	<div>
				    		정가 : <span><fmt:formatNumber value="${vo.price }" /> 원</span>
				    	</div>
				    	<div>
				    		판매가 : <span><fmt:formatNumber value="${vo.sale_price }" /> 원</span>
				    	</div>
				    	<div>
				    		적립금 : <span>${vo.saved_rate }%</span>
				    	</div>
				    </p>
				  </div>
				</div>
		  	</div>
	  		<!-- 데이터 표시 끝 -->
	  	</c:forEach>
	  	<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 끝 -->
	</div>
	
	<!-- 페이지 네이션 처리 -->
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
	</div>
	
  </c:if>
  <!-- 리스트 데이터 표시의 끝 -->
<%-- 	<c:if test="${ !empty login }"> --%>
		<!-- 로그인이 되어있으면 보이게 하자. -->
		<a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="btn btn-primary">등록</a>
<%-- 	</c:if> --%>
</div>
</body>
</html>