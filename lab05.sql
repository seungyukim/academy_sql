----------------------------------------------------------------------------------------- 실습 1)INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)VALUES ('C001', '김수현', 1988, sysdate, '경기');INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)VALUES ('C002', '이효리', 1979, sysdate, '제주');INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)VALUES ('C003', '원빈', 1977, sysdate, '강원');SELECT c.*  FROM customer c;/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE----------------------------------------------------C001	김수현	1988	18/07/02	경기	C002	이효리	1979	18/07/02	제주	C003	원빈	    1977	18/07/02	강원	*/-- 실습 2)UPDATE customer c   SET c.NAME = '차태현'      ,c.BIRTHYEAR = 1976 WHERE USERID = 'C001';/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE-----------------------------------------------------C001	차태현	1976	18/07/02	경기	C002	이효리	1979	18/07/02	제주	C003	원빈	    1977	18/07/02	강원	*/-- 실습 3)UPDATE customer c   SET c.ADDRESS = '서울';/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE-----------------------------------------------------C001	차태현	1976	18/07/02	서울	C002	이효리	1979	18/07/02	서울	C003	원빈	    1977	18/07/02	서울	*/-- 실습 4)DELETE FROM customer  WHERE USERID = 'C003';/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE-----------------------------------------------------C001	차태현	1976	18/07/02	서울	C002	이효리	1979	18/07/02	서울	*/-- 실습 5)DELETE customer;SELECT c.*  FROM customer c;-- 인출된 모든 행 : 0-- 실습 6)TRUNCATE TABLE customer;-- Table CUSTOMER이(가) 잘렸습니다.-- 실습 7)CREATE SEQUENCE seq_cust_useridSTART WITH 1MAXVALUE 99NOCYCLE;-- Sequence SEQ_CUST_USERID이(가) 생성되었습니다.-- 실습 2)SELECT s.SEQUENCE_NAME      ,s.MIN_VALUE      ,s.MAX_VALUE      ,s.CYCLE_FLAG      ,s.INCREMENT_BY  FROM user_sequences s WHERE s.SEQUENCE_NAME = 'SEQ_CUST_USERID';/* SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, CYCLE_FLAG, INCREMENT_BY-----------------------------------------------------------------SEQ_CUST_USERID	    1	        99      	N	        1*/-- 실습 3)CREATE INDEX idx_cust_useridON customer(userid);-- ORA-01408: such column list already indexedCREATE TABLE new_cust    ASSELECT c.*  FROM customer c WHERE 1 = 1;CREATE INDEX idx_cust_useridON new_cust(userid);-- Index IDX_CUST_USERID이(가) 생성되었습니다.  -- 실습 4)SELECT i.INDEX_NAME      ,i.INDEX_TYPE      ,i.TABLE_NAME      ,i.TABLE_OWNER      ,i.INCLUDE_COLUMN  FROM user_indexes i;/*PK_SUB_TABLE	    NORMAL	SUB_TABLE	SCOTT	IDX_NEW_MEMBER_ID	NORMAL	NEW_MEMBER	SCOTT	IDX_CUST_USERID	    NORMAL	NEW_CUST	SCOTT	PK_MEMBER       	NORMAL	MEMBER	    SCOTT	PK_EMP	            NORMAL	EMP     	SCOTT	PK_DEPT         	NORMAL	DEPT	    SCOTT	PK_CUSTOMER	        NORMAL	CUSTOMER	SCOTT	 	*/DESC USER_IND_COLUMNS;SELECT u.COLUMN_NAME      ,u.COLUMN_LENGTH      ,u.COLUMN_POSITION       ,u.INDEX_NAME      ,u.TABLE_NAME       ,u.CHAR_LENGTH      ,u.DESCEND  FROM USER_IND_COLUMNS u;-- 실습 5)SELECT i.INDEX_NAME      ,i.INDEX_TYPE      ,i.TABLE_NAME      ,i.TABLE_OWNER      ,i.INCLUDE_COLUMN  FROM user_indexes i WHERE i.INDEX_NAME = 'IDX_CUST_USERID';/* INDEX_NAME, INDEX_TYPE, TABLE_NAME, TABLE_OWNER, INCLUDE_COLUMN-------------------------------------------------------------------- IDX_CUST_USERID 	NORMAL	  NEW_CUST	  SCOTT	*/-- 실습 6)SELECT u.COLUMN_NAME      ,u.COLUMN_LENGTH      ,u.COLUMN_POSITION       ,u.INDEX_NAME      ,u.TABLE_NAME       ,u.CHAR_LENGTH      ,u.DESCEND  FROM USER_IND_COLUMNS u WHERE u.INDEX_NAME = 'IDX_CUST_USERID';/* COLUMN_NAME, COLUMN_LENGTH, COLUMN_POSITION, INDEX_NAME, TABLE_NAME, CHAR_LENGTH, DESCEND---------------------------------------------------------------------------------------------       USERID	       4	            1	   IDX_CUST_USERID 	NEW_CUST      4	        ASC*/-- 실습 7)DROP INDEX IDX_CUST_USERID;-- Index IDX_CUST_USERID이(가) 삭제되었습니다.-- 실습 8)SELECT u.COLUMN_NAME      ,u.COLUMN_LENGTH      ,u.COLUMN_POSITION       ,u.INDEX_NAME      ,u.TABLE_NAME       ,u.CHAR_LENGTH      ,u.DESCEND  FROM USER_IND_COLUMNS u;-------------------------------------------------------------------   출력 설정 SQL*PLUS 설정-- 기본 OFF 설정일 것임SHOW SERVEROUTPUT;-- ON 설정으로 변경SET SERVEROUTPUT ON;-- 실습 1)BEGIN    DBMS_OUTPUT.PUT_LINE ('Hello, PL/SQL Worid!');END;/-- 실습 2) DECLARE    message    VARCHAR2(100);BEGIN    message := 'Hello, PL/SQL Worid!';        DBMS_OUTPUT.PUT_LINE(message);END;/