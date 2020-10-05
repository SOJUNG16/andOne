<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
.left{
	float:left;
	cursor:pointer;
}
.info{
	margin-right:15px;
}

input[type="submit"] {
	margin: 0 auto;
}
</style>

<body>
<div class="container my-5 center">
		<div class="left">
			<div class="card info" style="width: 18rem;" onclick="location.href='${contextPath }/detailClub.do?c_id=${clubInfo.c_id}'">
				<img src="data:image/jpeg;base64,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" class="card-img-top"
					alt="...">
				<div class="card-body">
					<h5 class="card-title">${clubInfo.c_name }</h5>
					<p class="card-text">함께하는 사람 ${clubInfo.c_membercnt }</p>
					<small class="text-muted" style="height: 14px">#${clubInfo.c_hashtag}</small>
				</div>
			</div>
		</div>
</div>
<div class="container my-5 center">
<form action="${contextPath}/writeArticle.do" method="post" enctype="multipart/form-data">
	<textarea class="form-control col-sm-5" rows="13" name="ca_content">${articleInfo.ca_content }</textarea><br>
	<div class="btn" style="width:462px;">
	<input type="file" accept="image/*" name="ca_img"/>
	<br>
	<br>
	<input type="hidden" name="c_id" value="${clubInfo.c_id }">
	<input type="hidden" name="m_id" value="${member.m_id }">
	<input type="submit" class="btn btn-success btn-block"></div>
</form>
</div>

</body>
</html>