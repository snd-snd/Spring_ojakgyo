<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
	<title>Ojakgyo Bridge - Free Bootstrap</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="/resources/assets/vendor/linearicons/style.css">
	<link rel="stylesheet" href="/resources/assets/vendor/chartist/css/chartist-custom.css">
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
	<script src="/resources/ckeditor/ckeditor.js"></script>
</head>

<body>

	<!-- WRAPPER -->
	<div id="wrapper">
		<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand">
				<a href="/"><img src="/resources/assets/img/logo-ojakgyo.png" alt="Klorofil Logo" class="img-responsive logo"></a>
			</div>
			<div class="container-fluid">
				<div class="navbar-btn">
					<button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
				</div>
				<form class="navbar-form navbar-left">
					<div class="input-group">
						<input type="text" value="" class="form-control" placeholder="Search dashboard...">
						<span class="input-group-btn"><button type="button" class="btn btn-primary">Go</button></span>
					</div>
				</form>
				<div class="navbar-btn navbar-btn-right">
					<c:if test="${empty login }">
						<a class="btn btn-info" href="/acount/login"><i class="fa fa-rocket"></i> <span>Login and Join</span></a>
					</c:if>
					<c:if test="${not empty login }">
						<a class="btn btn-info" href="/logout"><i class="fa fa-rocket"></i> <span>Logout</span></a>
					</c:if>
				</div>
				<div id="navbar-menu">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
								<i class="lnr lnr-alarm"></i>
								<span class="badge bg-danger">5</span>
							</a>
							<ul class="dropdown-menu notifications">
								<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>System space is almost full</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-danger"></span>You have 9 unfinished tasks</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-success"></span>Monthly report is available</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>Weekly meeting in 1 hour</a></li>
								<li><a href="#" class="notification-item"><span class="dot bg-success"></span>Your request has been approved</a></li>
								<li><a href="#" class="more">See all notifications</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="lnr lnr-question-circle"></i> <span>Help</span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="#">Basic Use</a></li>
								<li><a href="#">Working With Data</a></li>
								<li><a href="#">Security</a></li>
								<li><a href="#">Troubleshooting</a></li>
							</ul>
						</li>
						<c:if test="${not empty login }">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="/resources/assets/img/user.png" class="img-circle" alt="Avatar"> <span>${login.nickName}</span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="#"><i class="lnr lnr-user"></i> <span>My Profile</span></a></li>
								<li><a href="#"><i class="lnr lnr-envelope"></i> <span>Message</span></a></li>
								<li><a href="#"><i class="lnr lnr-cog"></i> <span>Settings</span></a></li>
								<li><a href="/acount/delete"><i class="lnr lnr-trash"></i> <span>회원탈퇴</span></a></li>
							</ul>
						</li>
						</c:if>
						<!-- <li>
							<a class="update-pro" href="https://www.themeineed.com/downloads/klorofil-pro-bootstrap-admin-dashboard-template/?utm_source=klorofil&utm_medium=template&utm_campaign=KlorofilPro" title="Upgrade to Pro" target="_blank"><i class="fa fa-rocket"></i> <span>UPGRADE TO PRO</span></a>
						</li> -->
					</ul>
				</div>
			</div>
		</nav>
		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li>
							<a href="#subBoards" data-toggle="collapse" class="collapsed"><i class="lnr lnr-dice"></i> <span>My Group Board</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subBoards" class="collapse">
								<c:if test="${!empty login.groups }">
								<ul class="nav">
									<c:forEach items="${login.groups }" var="group">
										<li><a href="/${group.groupCode }/board/list" class=""><i class="lnr lnr-layers"></i>${group.groupName }</a></li>
									</c:forEach>
								</ul>
								</c:if>
							</div>
						</li>		
						<li>
							<a href="/support/request" class=""><i class="lnr lnr-leaf"></i>Group Request</a>		
						</li>
						<li>
							<a href="/review/review" class=""><i class="lnr lnr-heart"></i> <span>Review</span></a>
						</li>
						<li>
							<a href="#manage" data-toggle="collapse" class="collapsed"><i class="lnr lnr-cog"></i> <span>Manage</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="manage" class="collapse">
								<ul class="nav">				
									<c:forEach items="${login.groups }" var="group">
										<c:if test="${group.admin == 1 }">
											<li><a href="/manage/${group.groupCode }" class=""><i class="lnr lnr-users"></i>${group.groupName }</a></li>
										</c:if>	
									</c:forEach>			
									<li><a href="/manage/${group.groupCode }" class=""><i class="lnr lnr-users"></i>회원 관리</a></li>
									<li><a href="#" class=""><i class="lnr lnr-layers"></i>머머 관리</a></li>
									<li><a href="#" class=""><i class="lnr lnr-layers"></i>댕댕 관리</a></li>
									<li><a href="#" class=""><i class="lnr lnr-layers"></i>냥냥 관리</a></li>
								</ul>						
							</div>
						</li>
						<li>
							<a href="#adminPage" data-toggle="collapse" class="collapsed"><i class="lnr lnr-cog"></i> <span>Admin Pages</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="adminPage" class="collapse">
								<ul class="nav">							
									<li><a href="/admin/member" class=""><i class="lnr lnr-users"></i>회원 관리</a></li>
									<li><a href="/admin/group" class=""><i class="lnr lnr-users"></i>그룹 관리</a></li>
									<li><a href="#" class=""><i class="lnr lnr-layers"></i>머머 관리</a></li>
									<li><a href="#" class=""><i class="lnr lnr-layers"></i>댕댕 관리</a></li>
									<li><a href="#" class=""><i class="lnr lnr-layers"></i>냥냥 관리</a></li>
								</ul>						
							</div>
						</li>					
					</ul>
				</nav>
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->