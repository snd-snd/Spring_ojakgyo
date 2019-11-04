<!-- sysdba -->
grant connect, resource, dba, create sequence to javaDB; <!-- javaDB 계정에 권한 부여 -->

<!-- 관리자가 그룹생성 요청을 수락할 시 테이블 생성을 위한 프로시저 -->
create or replace procedure create_item 
(
    in_name in varchar2,
    out_name out varchar2
)
is
    item_cursor integer;
    item_sql1 varchar2(500);
    item_sql2 varchar2(500);
    item_sql3 varchar2(500);
    item_sql4 varchar2(300);
    item_sql5 varchar2(100);
    item_sql6 varchar2(100);
    item_sql7 varchar2(100);
    item_sql8 varchar2(100);
    item_sql9 varchar2(100);
begin
-- create table, sequence, index 생성
item_sql1 := 'create table '||in_name||' (
	mno number(10,0) constraint pk_'||in_name||' primary key,
	userId varchar2(50),
	userName varchar2(50),
	level number,
	regDate date default sysdate,
	admin number default 0,
	constraint fk_userId_'||in_name||' foreign key (userId) references members (userId),
	constraint fk_userName_'||in_name||' foreign key (userName) references members (userName)
)';
item_sql2 := 'create table board_'|| in_name ||' (
    bno number(10,0) constraint pk_board_'|| in_name ||' primary key,
    title varchar2(200) not null,
	content varchar2(2000) not null,
    writer varchar2(50) not null,
    regDate date default sysdate,
    readCount number(10,0),
	likeCount number(10,0)
)';
item_sql3 := 'create table reply_'|| in_name ||' (
	rno number(10) constraint pk_reply_'|| in_name ||' primary key,
	bno number(10),
	reply varchar2(1000) not null,
	replyer varchar2(50) not null,
	replyDate date default sysdate, 
	constraint fk_reply_'|| in_name ||' foreign key (bno) references board_'|| in_name ||' (bno)
)';
item_sql4 := 'create table like_'|| in_name ||' (
	lno number(10) constraint pk_like_'|| in_name ||' primary key,
	bno number(10),
	nickName varchar(50),
	constraint fk_bno_'|| in_name ||' foreign key (bno) references board_'|| in_name ||' (bno),
	constraint fk_nickName_'|| in_name ||' foreign key (nickName) references board_'|| in_name ||' (nickName)
)';
item_sql5 := 'create sequence seq_'|| in_name;
item_sql6 := 'create sequence seq_board_'|| in_name;
item_sql7 := 'create sequence seq_reply_'|| in_name;
item_sql8 := 'create sequence seq_like_'|| in_name;
item_sql9 := 'create index idx_reply_'|| in_name ||' on reply_'|| in_name ||' (bno desc, rno asc)';

-- 테이블 생성
item_cursor := DBMS_SQL.OPEN_CURSOR;   
DBMS_SQL.PARSE(item_cursor, item_sql1, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql2, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql3, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql4, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql5, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql6, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql7, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql8, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql9, dbms_sql.v7);
DBMS_SQL.CLOSE_CURSOR(item_cursor);
out_name := 'success';
commit;
end;
/

<!-- 그룹을 삭제할 경우 실행되는 프로시저 -->
create or replace procedure remove_item
(
    in_name in varchar2,
    out_name out varchar2
)
is
    item_cursor integer;
    item_sql1 varchar2(100);
    item_sql2 varchar2(100);
    item_sql3 varchar2(100);
    item_sql4 varchar2(100);
    item_sql5 varchar2(100);
    item_sql6 varchar2(100);
    item_sql7 varchar2(100);
    item_sql8 varchar2(100);
    item_sql9 varchar2(100);
begin
-- drop table, sequence, index 제거
item_sql1 := 'drop index idx_reply_'|| in_name;
item_sql2 := 'drop sequence seq_like_'|| in_name;
item_sql3 := 'drop sequence seq_reply_'|| in_name;
item_sql4 := 'drop sequence seq_board_'|| in_name;
item_sql5 := 'drop sequence seq_'|| in_name;
item_sql6 := 'drop table like_'|| in_name;
item_sql7 := 'drop table reply_'|| in_name;
item_sql8 := 'drop table board_'|| in_name;
item_sql9 := 'drop table '|| in_name;
-- 테이블 생성
item_cursor := DBMS_SQL.OPEN_CURSOR;   
DBMS_SQL.PARSE(item_cursor, item_sql1, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql2, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql3, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql4, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql5, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql6, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql7, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, item_sql8, dbms_sql.v7);
DBMS_SQL.CLOSE_CURSOR(item_cursor);
out_name := 'success';
commit;
end;
/
