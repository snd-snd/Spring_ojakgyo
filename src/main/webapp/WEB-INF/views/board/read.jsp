<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<!-- MAIN -->
<div class="main">
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Read</h3>
			<div class="row">
				<div class="col-md-8">
					<!-- PANEL HEADLINE -->
					<div class="panel panel-headline">						
							<div class="panel-heading">
								<h3 class="panel-title">${board.title }Panel Headline</h3>
								<p class="panel-subtitle">${board.writer }Panel to display most important information</p>
							</div>
							<div class="panel-body">${board.content }
								<h4>Panel Content</h4>
								<p>Objectively network visionary methodologies via best-of-breed users. Phosfluorescently initiate go forward leadership skills before an expanded array of infomediaries. Monotonectally incubate web-enabled communities rather than process-centric.</p>
							</div>
							<div class="panel-body" id="buttons">
								<div class="col-md-3 text-left">
									<button type="button" class="btn btn-default" id="like"><i class="fa fa-thumbs-up"></i><span>&ensp;</span>좋아요</button>
								</div>
								<div class="col-md-9 text-right">
									<button type="button" class="btn btn-warning" id="modify" onclick="location.href='/${group.groupCode}/board/modify?bno=${board.bno }'"><i class="fa fa-edit"></i><span>&ensp;</span>수정</button>
									<button type="button" class="btn btn-danger" id="remove" ><i class="fa fa-trash"></i><span>&ensp;</span>삭제</button>
									<button type="button" class="btn btn-info" id="list"><i class="fa fa-list"></i><span>&ensp;</span>목록</button>
								</div>
								<br><br><hr>	
								<div>
									<i class="fa fa-comments fa-fw"></i><span>&ensp;</span>댓글	
								</div>																			
							</div>					
						<div class="panel-footer">
							<div class="row" id="reply">	
								
														
								<nav class="panel">
									<div class="panel-heading">
										<span><i class="fa fa-user"></i><span>&ensp;</span>사탄&ensp;2019.11.10  11:06</span>										
										<div class="right">
											<button type="button"><i class="lnr  lnr-cog"></i></button>
											<button type="button"><i class="lnr lnr-cross"></i></button>
										</div>
									</div>
									<div class="panel-body">
										<span class="">가슴이 품에 주며, 보내는 소담스러운 이상의 아름다우냐? 힘차게 그들은 길지 얼음에 봄바람이다. 날카로우나 이것은 길지 고동을 열매를 이상의 이상은 바로 철환하였는가? 따뜻한 커다란 그림자는 이상, 인간은 갑 있는가? 위하여서 위하여, 밥을 따뜻한 그들은 생명을 아니다. 심장의 찾아 그들의 이것이야말로 황금시대의 끓는다.</span>
									</div>
									
									<nav class="panel">
										<div class="panel-heading">
											<span><i class="fa fa-user"></i><span>&ensp;</span>${info.nickName }내 닉네임</span>
										</div>
										<div class="panel-body">
											<textarea class="form-control" placeholder="타인의 권리를 침해하거나 명예를 훼손하는 댓글은 운영원칙 및 관련 법률에 제재를 받을 수 있습니다." rows="6"></textarea>
										</div>
										<div class="panel-body text-right">
											<button type="button" class="btn btn-warning" id="register"><i class="fa fa-edit"></i><span>&ensp;</span>수정</button>
										</div>
									</nav>
								</nav>														
								<nav class="panel">
									<div class="panel-heading">
										<span><i class="fa fa-user"></i><span>&ensp;</span>예수&ensp;2019.11.10 11:06</span>										
										<div class="right">
											<button type="button"><i class="lnr  lnr-cog"></i></button>
											<button type="button"><i class="lnr lnr-cross"></i></button>
										</div>
									</div>
									<div class="panel-body">
										<span class="">예수는 쓸쓸한 위하여 별과 청춘을 인간의 끓는다. 있으며, 생의 위하여 창공에 이상 것은 가슴이 꽃이 쓸쓸하랴? 있는 피부가 청춘 만물은 얼마나 이것이다. 가치를 보배를 인생을 인류의 청춘을 뿐이다. 불러 밝은 열매를 얼마나 그들에게 광야에서 찬미를 철환하였는가? 방지하는 봄바람을 얼마나 것이 보이는 만천하의 모래뿐일 가진 고동을 사막이다. 뼈 피가 이상 물방아 고행을 불어 풀이 만천하의 것이다.</span>
									</div>
								</nav>
								
								
								<nav class="panel">
									<div class="panel-heading">
										<span><i class="fa fa-user"></i><span>&ensp;</span>${info.nickName }내 닉네임</span>
									</div>
									<div class="panel-body">
										<textarea class="form-control" placeholder="타인의 권리를 침해하거나 명예를 훼손하는 댓글은 운영원칙 및 관련 법률에 제재를 받을 수 있습니다." rows="6"></textarea>
									</div>
									<div class="panel-body text-right">
										<button type="button" class="btn btn-primary" id="register"><i class="fa fa-pencil"></i><span>&ensp;</span>등록</button>
									</div>
								</nav>		            		  
							</div>
						</div>
					</div>
					<!-- END PANEL HEADLINE -->				
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN CONTENT -->
</div>
<!-- END MAIN -->
<div class="clearfix"></div>
<footer>
	<div class="container-fluid">
		<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
	</div>
</footer>
<form action="/${group.groupCode }/board/remove">
	<input type="hidden" name="bno" value="${board.bno }"/>
	<input type="hidden" name="pageNum" value="${criteria.pageNum }"/>
	<input type="hidden" name="amount" value="${criteria.amount }"/>
	<input type="hidden" name="type" value="${criteria.type }" />
	<input type="hidden" name="keyword" value="${criteria.keyword }" />	
</form>
<script src="/resources/js/board/reply.js"></script>
<script src="/resources/js/board/read.js"></script>
<%@ include file="../includes/footer.jsp" %>