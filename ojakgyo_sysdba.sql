<!-- sysdba -->
grant connect, resource, dba, create sequence to javaDB; <!-- javaDB 계정에 권한 부여 -->

<!-- 관리자가 그룹생성 요청을 수락할 시 테이블 생성을 위한 프로시저 -->
create or replace procedure create_item 
(
    input_data in varchar2,
    output_data out varchar2
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
item_sql1 := 'create table '||input_data||' (
	mno number(10,0) constraint pk_'||input_data||' primary key,
	userId varchar2(50),
	nickName varchar2(50),
	level number,
	regDate date default sysdate,
	admin number default 0,
	constraint fk_userId_'||input_data||' foreign key (userId) references members (userId),
	constraint fk_nickName_'||input_data||' foreign key (nickName) references members (nickName)
)';
item_sql2 := 'create table board_'|| input_data ||' (
    bno number(10,0) constraint pk_board_'|| input_data ||' primary key,
    title varchar2(200) not null,
	content varchar2(2000) not null,
    writer varchar2(50) not null,
    regDate date default sysdate,
    readCount number(10,0),
	likeCount number(10,0)
)';
item_sql3 := 'create table reply_'|| input_data ||' (
	rno number(10) constraint pk_reply_'|| input_data ||' primary key,
	bno number(10),
	reply varchar2(1000) not null,
	replyer varchar2(50) not null,
	replyDate date default sysdate, 
	constraint fk_reply_'|| input_data ||' foreign key (bno) references board_'|| input_data ||' (bno)
)';
item_sql4 := 'create table like_'|| input_data ||' (
	lno number(10) constraint pk_like_'|| input_data ||' primary key,
	bno number(10),
	nickName varchar(50),
	constraint fk_bno_'|| input_data ||' foreign key (bno) references board_'|| input_data ||' (bno),
	constraint fk_nickName_'|| input_data ||' foreign key (nickName) references board_'|| input_data ||' (nickName)
)';
item_sql5 := 'create sequence seq_'|| input_data;
item_sql6 := 'create sequence seq_board_'|| input_data;
item_sql7 := 'create sequence seq_reply_'|| input_data;
item_sql8 := 'create sequence seq_like_'|| input_data;
item_sql9 := 'create index idx_reply_'|| input_data ||' on reply_'|| input_data ||' (bno desc, rno asc)';

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
output_data := 'success';
commit;
end;
/

<!-- 그룹을 삭제할 경우 실행되는 프로시저 -->
create or replace procedure remove_item
(
    input_data in varchar2,
    output_data out varchar2
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
item_sql1 := 'drop index idx_reply_'|| input_data;
item_sql2 := 'drop sequence seq_like_'|| input_data;
item_sql3 := 'drop sequence seq_reply_'|| input_data;
item_sql4 := 'drop sequence seq_board_'|| input_data;
item_sql5 := 'drop sequence seq_'|| input_data;
item_sql6 := 'drop table like_'|| input_data;
item_sql7 := 'drop table reply_'|| input_data;
item_sql8 := 'drop table board_'|| input_data;
item_sql9 := 'drop table '|| input_data;
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
output_data := 'success';
commit;
end;
/
