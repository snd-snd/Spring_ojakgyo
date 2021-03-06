-- javaDB --
-- 회원정보 --
create table members( 
	userId varchar2(50) not null,
	userPw varchar2(100) not null,
	userName varchar2(50) not null,
	nickName varchar2(50) not null unique,
	email varchar2(100) not null,
	groupCode1 varchar2(100),
	groupCode2 varchar2(100),
	groupCode3 varchar2(100),
	groupCode4 varchar2(100),
	admin number default 0,
	constraint pk_members primary key (userId)
);

-- 그룹 생성시 저장되는 정보 --
create table groups( 
	groupCode varchar2(100) constraint pk_groups primary key,
	groupName varchar2(200) not null,
	content varchar2(2000) not null,
	leader varchar2(50),
	regDate date default sysdate,
	status number default 2,
	headCount number default 0,
	constraint fk_leader foreign key(leader) references members(nickName)
);

create sequence seq_groups; -- 그룹 테이블의 gno를 위한 시퀀스 --

--=============================Review========================
--Review게시판  --
create table ReviewBoard( 
	bno number(10) not null,
	title varchar2(100) not null,
	content varchar2(3000) not null,
	writer varchar2(100) not null,
	readCount number default 0,
	replyCnt number default 0,
	regDate date default sysdate,
	xpos varchar2(50),
	ypos varchar2(50),
	constraint pk_reviewboard primary key(bno),
	foreign key(writer) references members(nickName)
)

--댓글수 업데이트
update ReviewBoard set replyCnt=(
	select count(rno) from ReviewReply where ReviewBoard.bno=ReviewReply.bno);

create sequence seq_review --리뷰테이블의 bno를 위한 시퀀스 --

--ReviewReply게시판
create table ReviewReply(
	rno number(10) constraint pk_reviewreplyboard primary key, -- 댓글 글 번호
	bno number(10) not null, --원본 글 번호
	reply varchar2(1000) not null, -- 댓글 내용
	replyer varchar2(50) not null, -- 댓글 작성자
	replydate date default sysdate, -- 댓글 작성 날짜
	updateDate date default sysdate, -- 댓글 수정 날짜
	constraint fk_reviewreply foreign key(bno) references ReviewBoard(bno), -- 외래키
	constraint fk_reviewreplyreplyer foreign key(replyer) references members(nickName)
)

create sequence seq_reviewreply --리뷰댓글테이블의 rno를 위한 시퀀스

create index idx_reviewreply on ReviewReply(bno desc, rno asc);

drop table members
drop table groups
drop table ReviewBoard
drop table ReviewReply