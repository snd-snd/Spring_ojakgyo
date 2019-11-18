<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" class="fullscreen-bg">
<head>
	<title>Login | Ojakgyo</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="/resources/assets/vendor/linearicons/style.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="/resources/assets/css/main.css">
	<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
	<link rel="stylesheet" href="/resources/assets/css/demo.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="/resources/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/resources/assets/img/favicon.png">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.js"></script>
	<!-- 사용자 작성 유효성 검증 -->
	<script src="/resources/js/account/joinForm.js"></script>
</head>

<body>

	<!-- WRAPPER -->
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box ">
					<div class="left">
						<div class="content">
							<div class="header">
								<div class="logo text-center"><img src="/resources/assets/img/logo-ojakgyo.png" alt="Klorofil Logo"></div>
								<p class="lead">회원가입</p>
							</div>
							<form id="join" class="form-auth-small" action="/account/join" method="post">
								<div class="form-group">
									<label for="userId" class="control-label sr-only">아이디</label>
									<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요">
									<small id="userId" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="userPw" class="control-label sr-only">이름</label>
									<input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력하세요">
									<small id="userName" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="nickName" class="control-label sr-only">닉네임</label>
									<input type="text" class="form-control" id="nickName" name="nickName" placeholder="닉네임을 입력하세요">
									<small id="nickName" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="userPw" class="control-label sr-only">비밀번호</label>
									<input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요">
									<small id="userPw" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="confirm_password" class="control-label sr-only">비밀번호 확인</label>
									<input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="비밀번호를 확인해주세요">
									<small id="confirm_password" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="userPw" class="control-label sr-only">이메일</label>
									<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
									<small id="email" class="text-info"></small>
								</div>
								<button type="submit" class="btn btn-success btn-lg btn-block">회원가입</button>
							</form>
						</div>
					</div>
					<div class="right">
						<div class="overlay"></div>
						<div class="content text">
							<h1 class="heading">오작교는 핑크빛</h1>
							<p>by Team Ojakgyo</p>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
</body>
<script>
$(function(){
	var btn = (".btn-block");
	btn.click(function(){
		alert("클릭했어");
	})
})
</script>
</html>
