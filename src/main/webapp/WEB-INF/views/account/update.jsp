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
	<script src="/resources/js/account/update.js"></script>
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
							<form id="update" class="form-auth-small" action="" method="post">
								<div class="form-group">
									<label for="userId" class="control-label sr-only">아이디</label>
									<input type="text" class="form-control" id="userId" name="userId" value="${login.member.userId}" readonly="readonly">
									<small id="userId" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="userPw" class="control-label sr-only">이름</label>
									<input type="text" class="form-control" id="userName" name="userName" value="${login.member.userName}" readonly="readonly">
									<small id="userName" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="userPw" class="control-label sr-only">현재비밀번호</label>
									<input type="password" class="form-control" id="userPw" name="userPw" value="${login.member.userPw}" readonly="readonly">
									<small id="userPw" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="nickName" class="control-label sr-only">닉네임</label>
									<input type="text" class="form-control" id="nickName" name="nickName" placeholder="${login.member.nickName}">
									<small id="nickName" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="new_password" class="control-label sr-only">새비밀번호</label>
									<input type="password" class="form-control" id="new_password" name="new_password" placeholder="새 비밀번호를 입력해주세요">
									<small id="new_password" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="confirm_password" class="control-label sr-only">새비밀번호 확인</label>
									<input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="새 비밀번호가 맞는지 확인해주세요">
									<small id="confirm_password" class="text-info"></small>
								</div>
								<div class="form-group">
									<label for="userPw" class="control-label sr-only">이메일</label>
									<input type="email" class="form-control" id="email" name="email" placeholder="${login.member.email}">
									<small id="email" class="text-info"></small>
								</div>
								<button type="submit" class="btn btn-success btn-lg btn-block">회원수정</button>
								<button onclick="back();" class="btn btn-Danger btn-lg btn-block">취소</button>
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
	function back(){
		history.back();
	}
</script>
</html>