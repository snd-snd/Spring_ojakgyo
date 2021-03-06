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
</head>
<script>
	var message = '${message}';
	
	if (message != '' && message.length != 0){
		alert(message);
	}
</script>
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
								<p class="lead">로그인</p>
							</div>
							<form class="form-auth-small" action="" method="post">
								<div class="form-group">
									<label for="signin-userId" class="control-label sr-only">아이디</label>
									<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요">
								</div>
								<div class="form-group">
									<label for="userPw" class="control-label sr-only">비밀번호</label>
									<input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요">
								</div>
								<div class="form-group clearfix">
									<label class="fancy-checkbox element-left">
										<input type="checkbox">
										<span>Remember me</span>
									</label>
								</div>
								<button type="submit" class="btn btn-primary btn-lg btn-block">LOGIN</button>
								<div class="bottom">
									<span class="helper-text"><i class="fa fa-lock"></i> <a href="#">Forgot password?</a></span>
									<span class="helper-text"><i class="fa fa-lock"></i> <a href="/account/join">new Account</a></span>
								</div>
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

</html>
