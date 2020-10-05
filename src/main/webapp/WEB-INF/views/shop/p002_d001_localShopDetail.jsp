<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>

<head>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

h3 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 200%;
}

input[type="submit"] {
	font-family: FontAwesome;
}

button#search {
	font-family: FontAwesome;
}

div.search {
	text-align: center;
}

.card {
	
}

img.noResult{
	display:block; margin:0px auto;
}

a {
	text-decoration: none;
}

a:link {
	color: black;
}

a:visited {
	color: black;
}

a:active {
	color: black;
}

a:hover {
	color: black;
}

#pop {
	background:#e6e6e6;
	border:1px solid #000;
	position: fixed;
	top: 20%;
	left: 25%;
	width: 480px;
	height: auto;
	z-index: 10;
}

</style>

<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
	var shopId = '${shopId}';
	var s_category = '';
	
	$(document).ready(function(){
		$('#pop').hide();
		getShopDetail();
	})
	
	function popup(p1, p2){
		$('#pop').show();
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/shopReviewPopup.do",
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('#popContent').html("<br><br><br><br><img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
			},
			data: "m_id="+p1+"&s_id=" + p2,
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var output = "";
				output += '<table>';
				output += 	'<tr>';
				output += 		'<td align="center" height="80" width="80">';
				output += 			'<div style="margin: 2px">';
				output +=				'<div class="card" style="width: 4rem;">';
				output +=					'<a href="#">';
				output +=						'<img src="${contextPath }/resources/image/basicProfileImg.png" class="card-img-top" alt="...">';
				output +=					'</a>';
				output +=				'</div>';
				output +=			'</div>';
				output +=		'</td>';
				output += 		'<td align="left" height="80" width="350"><h2>&nbsp;&nbsp;'+jsonInfo.m_nickname+'</h2></td>';
				output += 		'<td id="close" align="right" height="80" width="80" valign="top"><img src="${contextPath }/resources/image/close.png" height="40" width="40"></td>';
				output += 	'</tr>';
				output += 	'<tr>';
				output += 		'<td colspan="2" align="left" height="40">'+jsonInfo.sr_score+'</td>';
				output += 		'<td align="right">'+jsonInfo.sr_date+'</td>';
				output += 	'</tr>';
				output += 	'<tr>';
				output += 		'<td colspan="2" height="300" valign="top">'+jsonInfo.sr_content+'</td>';
				output += 		'<td></td>';
				output +=	 '</tr>';
				output += 	'<tr>';
				output +=		'<td></td>'
				output += 		'<td colspan="2" align="center" height="110">';
				output += 		'<div class="row">';
				for(let j=0; j<Object.keys(jsonInfo.shopReviewImage).length; j++){
					output += 		'<div style="margin: 5px">';
					output += 			'<div class="card" style="width: 5rem;">';
					output += 				'<a href="#">';
					output += 					'<img src="https://via.placeholder.com/50" class="card-img-top" alt="...">';
					output += 				'</a></div></div>';
				}
				for(let j=0; j<3 - Object.keys(jsonInfo.shopReviewImage).length; j++){
					output += 		'<div style="margin: 5px">';
					output += 			'<div class="card" style="width: 5rem;">';
					output += 				'<img src="${contextPath }/resources/image/ina.png" class="card-img-top" alt="...">';
					output += 			'</div></div>';
				}
				output +=		'</div>'
				output +=		'</td>';
				output += 	'</tr>';
				output += '</table>';
				$('#popContent').html(output);
				$('#close').click(function(){
					$('#pop').hide();
				})
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				
			}
		});
	}
	
	function getShopDetail(){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/getShopDetailByAjax.do",
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('div.recommendShop').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
			},
			data: "s_id=" + shopId,
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var shopImage = "";
				var shopInformation = "";
				var reviewList = "";
				var recommendShop = "";
				
				var imageCount = Object.keys(jsonInfo.shopImage).length;
				var reviewCount = Object.keys(jsonInfo.shopReviewList).length;
				
				s_category = jsonInfo.s_category;
				console.log('======> 가게 카테고리');
				console.log(s_category);
				console.log('======> 가게 이름');
				console.log(jsonInfo.s_name);
				console.log('======> 리뷰 갯수');
				console.log(reviewCount);
				console.log('======> 가게 이미지 갯수');
				console.log(imageCount);
				
				shopImage += '<div class="row">';
				for(let i=0; i<imageCount; i++){
					shopImage += '<div style="margin: 15px">';
					shopImage += '<div class="card" style="width: 20rem;">';
					shopImage += '<a href="#">';
					shopImage += '<img src="https://via.placeholder.com/150" class="card-img-top" alt="...">';
					shopImage += '</a></div></div>';
				}
				for(let i=0; i<3-imageCount; i++){
					shopImage += '<div style="margin: 15px">';
					shopImage += '<div class="card" style="width: 20rem;">';
					shopImage += '<img src="${contextPath }/resources/image/ina.png" class="card-img-top" alt="...">';
					shopImage += '</div></div>';
				}
				shopImage += '</div>';
				
				shopInformation += '<table><tr><td width="500" height="70">';
				shopInformation += '<h1>'+jsonInfo.s_name+'</h1></td><td width="350" height="70"></td>';
				shopInformation += '<td align="right" width="150" height="70">';
				shopInformation += '<button id="all" type="button" class="btn btn-outline-info" onclick="">리뷰 쓰기</button>';
				shopInformation += '</td></tr><tr><td colspan="3" height="30">'+jsonInfo.s_score+'</td>';
				shopInformation += '</tr><tr><td colspan="3" height="30">'+jsonInfo.gc_name+'</td>';
				shopInformation += '</tr><tr><td colspan="3" height="30">'+jsonInfo.s_hashtag+'</td></tr><tr>';
				shopInformation += '<td valign="top" colspan="3" height="100">'+jsonInfo.s_content+'</td>';
				shopInformation += '</tr></table>';
				
				
				reviewList += '<hr><h3>후기('+jsonInfo.reviewCount+')</h3>';
				for(let i=0; i<reviewCount; i++){
					reviewList += '<table><tr><td rowspan="3" width="80">';
					reviewList += '<div style="margin: 10px">';
					reviewList += '<div class="card" style="width: 5rem;">';
					reviewList += '<a href="#">';
					reviewList += '<img src="${contextPath }/resources/image/basicProfileImg.png" class="card-img-top" alt="...">';
					reviewList += '</a></div></div></td>';
					reviewList += '<td class="clickArea" id="'+jsonInfo.shopReviewList[i].m_id+'"width="680">'+jsonInfo.shopReviewList[i].m_nickname+'</td>';
					for(let j=0; j<Object.keys(jsonInfo.shopReviewList[i].shopReviewImage).length; j++){
						reviewList += '<td rowspan="3" width="80">';
						reviewList += '<div style="margin: 5px">';
						reviewList += '<div class="card" style="width: 5rem;">';
						reviewList += '<a href="#">';
						reviewList += '<img src="https://via.placeholder.com/50" class="card-img-top" alt="...">';
						reviewList += '</a></div></div>';
						reviewList += '</td>';
					}
					for(let j=0; j<3 - Object.keys(jsonInfo.shopReviewList[i].shopReviewImage).length; j++){
						reviewList += '<td rowspan="3" width="80">';
						reviewList += '<div style="margin: 5px">';
						reviewList += '<div class="card" style="width: 5rem;">';
						reviewList += '<img src="${contextPath }/resources/image/ina.png" class="card-img-top" alt="...">';
						reviewList += '</div></div>';
						reviewList += '</td>';
					}
					reviewList += '</tr><tr><td class="clickArea" id="'+jsonInfo.shopReviewList[i].m_id+'" width="80">'+jsonInfo.shopReviewList[i].sr_score+'</td></tr>';
					reviewList += '<tr><td class="clickArea" id="'+jsonInfo.shopReviewList[i].m_id+'" value="rl" width="80">'+jsonInfo.shopReviewList[i].sr_content+'</td>';
					reviewList += '<td>'+jsonInfo.shopReviewList[i].sr_date+'</td></tr></table><hr>';
				}
				recommendShop += '<h3>업체추천</h3><div id="recommendShopList"></div>'
					
				$('div.shopImage').html(shopImage);
				$('div.shopInformation').html(shopInformation);
				$('div.reviewList').html(reviewList);
				$('div.recommendShop').html(recommendShop);
				$('td.clickArea').click(function(){
					let m_id = $(this).attr('id');
					popup(m_id, shopId);
				})
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				recommend();
			}
		});
		
	}
	
	function recommend(){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/searchByAjax.do",
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('div#recommendShopList').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
			},
			data:"filter="+s_category+"&searchCondition=GETRECOMMENDLIST&s_id="+shopId,
			success: function (data, textStatus) {
				console.log('======>추천 아작스');
				console.log(s_category);
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var shopCount = Object.keys(jsonInfo).length;
				var output = "";
				if(shopCount == 0){
					output += "<h3>저런~ 추천 가게가 없습니다.</h3>";
				}else{
					if(shopCount > 3){
						shopCount = 3;
					}
					output += "<div class='row'>";
					for (let i=0; i<shopCount; i++) {
						console.log(jsonInfo[i].s_name);
						output += "<div style='margin: 20px'>";
						output += "<div class='card' style='width: 18rem;'>";
						output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>";
						output += "<img src='https://via.placeholder.com/150' class='card-img-top'alt='...'></a>";
						output += "<div class='card-body'><h5 class='card-title'><a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>"+jsonInfo[i].s_name+"</a></h5>";
						output += "<p class='card-text'>"+jsonInfo[i].s_locate+"</p></div>";
						output += "<div class='card-body' id='review'>";
						output += "<p class='card-text'>";
						output += "<a href='#'>후기 "+jsonInfo[i].reviewCount+"건</a><br>";
						if(Object.keys(jsonInfo[i].shopReviewList).length == 0){
							output += "아직 남겨진 리뷰가 없어요~</p></div></div></div>";
						}else{
							output += "<a href='#'>"+jsonInfo[i].shopReviewList[0].m_nickname+"</a>님의 후기 <br>";
							output += jsonInfo[i].shopReviewList[0].sr_score+"<br>";
							output += jsonInfo[i].shopReviewList[0].sr_content+"</p></div></div></div>";
						}
					}
					output += "</div>";
				}
				$('div#recommendShopList').html(output);
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
			}
		});
	}
	
	
	
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div class="container my-5 center">
		<div class="shopImage">
		
			
		</div>
		
		<div class="shopInformation">
		
			
		</div>	
			
		
		<div class="reviewList">
		
			
		</div>	
			
		
		
		<div class="recommendShop">
		
	
		</div>
	</div>
	<br>
	<div id='pop'>
		<div id='popContent' style="height:530px;">
			
		</div>
	</div>
</body>

</html>