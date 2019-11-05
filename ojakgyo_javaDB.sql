<!-- javaDB -->
create table members( <!-- 회원정보 -->
	userId varchar2(50) not null,
	userPw varchar2(50) not null,
	userName varchar2(50) not null,
	nickName varchar2(50) not null unique,
	email varchar2(100) not null,
	groupCode1 varchar2(100),
	groupCode2 varchar2(100),
	groupCode3 varchar2(100),
	groupCode4 varchar2(100),
	admin number default 0,
	constraint pk_members primary key (userId)
)

create table groups( <!-- 그룹 생성시 저장되는 정보 -->
	groupCode varchar2(100) constraint pk_groups primary key,
	groupName varchar2(200) not null,
	content varchar2(2000) not null,
	leader varchar2(50),
	regDate date default sysdate,
	status number default 2,
	headCount number(10,0)
	constraint fk_leader foreign key (leader) references members (nickName)
);
create sequence seq_groups; <!-- 그룹 테이블의 gno를 위한 시퀀스 -->






