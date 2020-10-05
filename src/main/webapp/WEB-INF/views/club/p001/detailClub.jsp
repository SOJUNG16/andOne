<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.left,.right {
	display: inline-block;
	margin: 0;
	width:500px;
}
.left{
	margin-top:0;
	position:fixed;
}

.right{
	margin-left:300px;
	margin-top:17px;
}
.card-title,.pin,.card-subtitle{
	display:inline-block;
	margin-left:10px;
}
.art-title{
	width:330px;
	position:absolute;
}

.pin{
	width:30px;
	position: absolute;
	top: 20px;
    right: 20px;
}
.card-subtitle{
	margin-top:10px;
}

.bi-bookmark-star-fill{
	fill:#ffcc00;
	display:inline-block; 
}
.show{
	position:fixed;
}
.sub{
	display:none;
}
.tap{
	cursor:pointer;
}

.ca_img{
	height:100%;
	width:100%;
	object-fit : contain;
}

</style>
<script type="text/javascript">
function menuTap(ca_id){
	$('.'+ca_id).slideToggle();
};

</script>
</head>
<body>
<!-- 	소모임 카드 -->
	<div class="container my-5 center top">
		<div class="left">
			<div class="card info" style="width: 18rem;">
			<c:set var="c_img" value="${clubImg}"/>
				<c:choose>
					<c:when test="${c_img eq null}">
						<img src="https://static.toiimg.com/photo/msid-76940605/76940605.jpg?758247" class="card-img-top" alt="...">
					</c:when>
					<c:otherwise>
						<img src="data:image/jpg;base64, ${c_img}" class="c_img">
					</c:otherwise>
				</c:choose>
				<div class="card-body">
					<h5 class="card-title">${clubInfo.c_name }</h5>
					<p class="card-text">함께하는 사람 ${clubInfo.c_membercnt }</p>
					<small class="text-muted" style="height: 14px">#${clubInfo.c_hashtag}</small>
					<c:set var="cm_rank" value="${rank}"/>
						<c:choose>
							<c:when test="${rank eq 0}">
								<a href="${contextPath }/club/introForm.do?c_id=${clubInfo.c_id}" class="btn btn-success btn-block"
									style="margin-top: 3px;">함께하기</a>
							</c:when>
							<c:when test="${rank eq 10}">
								<a href="${contextPath }/club/introForm.do?c_id=${clubInfo.c_id}" class="btn btn-success btn-block"
									style="margin-top: 3px;">소모임 관리</a>
							</c:when>
							<c:when test="${rank eq 20 or rank eq 30}">
								<a href="${contextPath}/club/writeArticleForm.do?c_id=${clubInfo.c_id}" class="btn btn-success btn-block"
									style="margin-top: 3px;">글쓰기</a>
							</c:when>
							<c:when test="${rank eq 40}">
								<a href="#" class="btn btn-success btn-block"
									style="margin-top: 3px;">가입승인 대기중</a>
							</c:when>
						</c:choose>
				</div>
			</div>
		</div>
		<div class="right">
			<div class="card">
				<div class="card-header">${clubInfo.c_name }</div>
				<div class="card-body">
				 	<h5>${clubInfo.c_content }</h5>
				</div>
			</div>
			
			<!--소모임 게시글  -->
			<c:forEach var="club" items="${clubInfo.articleList }">
			<div class="card article" style="width: 500px;height:auto;">
				<div class="card-body" style="height:auto">
					<img style="position:relative;border-radius: 70px;
								-moz-border-radius: 70px;
								-khtml-border-radius: 70px;
								-webkit-border-radius: 70px;width:70px;height:70px;"
								src="https://www.vettedpetcare.com/vetted-blog/wp-content/uploads/2017/09/How-To-Travel-With-a-Super-Anxious-Cat-square.jpeg" />
					<h5 class="card-title art-title">${club.m_id}</h5>
					<c:set var="ca_pin" value="${club.ca_pin}"/>
					<c:choose>
					<c:when test="${ca_pin eq 1}">
					<div class="pin">
						<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-bookmark-star-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  							<path fill-rule="evenodd" d="M4 0a2 2 0 0 0-2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4zm4.16 4.1a.178.178 0 0 0-.32 0l-.634 1.285a.178.178 0 0 1-.134.098l-1.42.206a.178.178 0 0 0-.098.303L6.58 6.993c.042.041.061.1.051.158L6.39 8.565a.178.178 0 0 0 .258.187l1.27-.668a.178.178 0 0 1 .165 0l1.27.668a.178.178 0 0 0 .257-.187L9.368 7.15a.178.178 0 0 1 .05-.158l1.028-1.001a.178.178 0 0 0-.098-.303l-1.42-.206a.178.178 0 0 1-.134-.098L8.16 4.1z"/>
						</svg>
					</div>		
					</c:when>
					</c:choose>
					<h6 class="card-subtitle mb-2 text-muted">${club.ca_date }</h6>
					<p class="card-text" style="margin-top:10px;">${club.ca_content }</p>
					<c:set var="ca_img" value="${club.resultImgList}"/>
					<c:choose>
						<c:when test="${ca_img ne null}">
						<div class="ca_img_div">
							<img src="data:image/jpg;base64, ${ca_img}" class="ca_img">
						</div>							
						</c:when>
					</c:choose>
			<!--본인이 쓴 글일 경우 수정,삭제 메뉴 -->
					<c:set var="logOnId" value="${member.m_id }"/>
					<c:set var="writer" value="${club.m_id }"/>
					<c:choose>
						<c:when test="${logOnId eq writer}">
	     					<svg onclick="menuTap(${club.ca_id});" width="1em" height="1em" viewBox="0 0 16 16" class="tap bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  								<path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
							</svg>
							<div class="sub ${club.ca_id}">
								<button type="button" class="btn btn-outline-secondary" onclick="location.href='editClubArticle.do?ca_id=${club.ca_id}'">수정${club.ca_id }</button>
								<button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#staticBackdrop">삭제${club.ca_id}</button>
							</div>
							<!-- delete Modal -->
							<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="true" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="false">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-body">
							        	<h6 style="text-align:center;">해당 게시물을 삭제하겠습니까?</h6>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
							        <button type="button" class="btn btn-primary"
							        	onclick="location.href='deleteClubArticle.do?ca_id=${club.ca_id},c_id=${clubInfo.c_id }'">삭제하기${club.ca_content }</button>
							      </div>
							    </div>
							  </div>
							</div>
						</c:when>
					</c:choose>
				</div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>