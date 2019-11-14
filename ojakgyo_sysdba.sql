<!-- sysdba -->
grant connect, resource, dba, create sequence to javaDB; <!-- javaDB 계정에 권한 부여 -->

<!-- 관리자가 그룹생성 요청을 수락할 시 테이블 생성을 위한 프로시저 -->
CREATE OR REPLACE PROCEDURE create_item(indata IN VARCHAR, outdata OUT VARCHAR)
IS
cursor1 INTEGER;
sql1 VARCHAR2(500);
sql2 VARCHAR2(500);
sql3 VARCHAR2(500);
sql4 VARCHAR2(500);
sql5 VARCHAR2(500);
sql6 VARCHAR2(500);
sql7 VARCHAR2(500);
sql8 VARCHAR2(500);
sql9 VARCHAR2(500);
BEGIN
-- CREATE TABLE명령어 생성
sql1 := 'CREATE TABLE ' || indata || ' (
    mno NUMBER CONSTRAINT pk_' || indata || ' PRIMARY KEY,
    userId VARCHAR2(50),
    nickName VARCHAR2(50),
    score NUMBER,
    regDate DATE DEFAULT SYSDATE,
    CONSTRAINT fk_userId_' || indata || ' FOREIGN KEY (userId) REFERENCES members (userId),
    CONSTRAINT fk_nickName_' || indata || ' FOREIGN KEY (nickName) REFERENCES members (nickName))';

sql2 := 'CREATE TABLE board_' || indata || ' (
    bno NUMBER CONSTRAINT pk_board_' || indata || ' PRIMARY KEY,
    title VARCHAR2(200) not null,
	content VARCHAR2(3000) not null,
    writer VARCHAR2(50) not null,
    regDate DATE DEFAULT SYSDATE,
    readCount NUMBER,
	likeCount NUMBER
)';

sql3 := 'CREATE TABLE reply_' || indata || ' (
	rno NUMBER CONSTRAINT pk_reply_' || indata || ' PRIMARY KEY,
	bno NUMBER,
	reply VARCHAR2(1000) not null,
	replyer VARCHAR2(50) not null,
	replyDate DATE DEFAULT SYSDATE, 
	CONSTRAINT fk_reply_bno_' || indata || ' FOREIGN KEY (bno) REFERENCES board_' || indata || ' (bno)
)';
sql4 := 'CREATE TABLE like_' || indata || ' (
	lno NUMBER CONSTRAINT pk_like_' || indata || ' primary key,
	bno NUMBER,
	nickName VARCHAR2(50),
	CONSTRAINT fk_like_bno_' || indata || ' FOREIGN KEY (bno) REFERENCES board_' || indata || ' (bno),
	CONSTRAINT fk_like_nickName_' || indata || ' FOREIGN KEY (nickName) REFERENCES members (nickName)
)';
sql5 := 'CREATE SEQUENCE seq_'|| indata;
sql6 := 'CREATE SEQUENCE seq_board_'|| indata;
sql7 := 'CREATE SEQUENCE seq_reply_'|| indata;
sql8 := 'CREATE SEQUENCE seq_like_'|| indata;
sql9 := 'CREATE INDEX idx_reply_'|| indata ||' ON reply_'|| indata ||' (bno desc, rno asc)';

-- 테이블 생성
cursor1 := DBMS_SQL.OPEN_CURSOR;  
DBMS_SQL.PARSE(cursor1, sql1, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql2, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql3, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql4, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql5, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql6, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql7, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql8, dbms_sql.v7);
DBMS_SQL.PARSE(cursor1, sql9, dbms_sql.v7);
DBMS_SQL.CLOSE_CURSOR(cursor1);

outdata := 'success';
COMMIT;
END;
/

<!-- 그룹을 삭제할 경우 실행되는 프로시저 -->
CREATE OR replace PROCEDURE remove_item
(
    input_data in varchar2,
    output_data out varchar2
)
IS
item_cursor integer;
sql1 varchar2(100);
sql2 varchar2(100);
sql3 varchar2(100);
sql4 varchar2(100);
sql5 varchar2(100);
sql6 varchar2(100);
sql7 varchar2(100);
sql8 varchar2(100);
sql9 varchar2(100);
BEGIN
-- drop table, sequence, index 제거
sql1 := 'drop index idx_reply_'|| input_data;
sql2 := 'drop sequence seq_like_'|| input_data;
sql3 := 'drop sequence seq_reply_'|| input_data;
sql4 := 'drop sequence seq_board_'|| input_data;
sql5 := 'drop sequence seq_'|| input_data;
sql6 := 'drop table like_'|| input_data;
sql7 := 'drop table reply_'|| input_data;
sql8 := 'drop table board_'|| input_data;
sql9 := 'drop table '|| input_data;
-- 테이블 제거
item_cursor := DBMS_SQL.OPEN_CURSOR;   
DBMS_SQL.PARSE(item_cursor, sql1, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql2, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql3, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql4, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql5, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql6, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql7, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql8, dbms_sql.v7);
DBMS_SQL.PARSE(item_cursor, sql9, dbms_sql.v7);
DBMS_SQL.CLOSE_CURSOR(item_cursor);
output_data := 'success';
COMMIT;
END;
/
