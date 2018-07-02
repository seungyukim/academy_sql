-- day05 : SQL
---------------------------------------------------
-- ORACLE 의 특별한 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
--            물리적으로 저장된 위치이므로 한 행당 반드시 유일할 수 밖에 없음,
--            ORDER BY 절에 의해서 변경되지 않는 값
--  예) emp 테이블에서 'SMITH'인 사람의 정보를 조회
SELECT e.EMPNO
      ,e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH' 
;

- rowid 를 같이 조회
SELECT e.rowid
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH' 
;

-- rowid 는 ORDER BY 에 의해 변경되지 않는다.
SELECT e.rowid
      ,e.EMPNO
      ,e.ENAME
  FROM emp e 
 ORDER BY e.EMPNO
;

-- 2. ROWNUM : 조회된 결과의 첫번째 행부터 1로 증가하는 값
SELECT rownum -- e.rownum 이라 쓰지 않음
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH'
;
/* ROWNUM, EMPNO, ENAME
------------------------
1	7369	SMITH
*/

SELECT rownum -- e.rownum 이라 쓰지 않음 
      ,e.EMPNO
      ,e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%'
 ORDER BY e.ENAME
;
/*ROWNUM, EMPNO, ENAME
------------------------
4	8888	J
5	7777	J%JONES
2	7900	JAMES
6	6666	JJ
1	7566	JONES
3	9999	J_JUNE
*/
-- 위의 두 결과를 비교하면 rownum도 ORDER BY에 영향을 
-- 받지 않는 것 처럼 보일 수 있으나
-- SUB-QUERY 로 사용할 때 영향을 받음.

SELECT rownum
      ,a.EMPNO
      ,a.ENAME
      ,a.numrow
  FROM (SELECT rownum 
              ,e.EMPNO
              ,e.ENAME
              ,rownum as numrow
         FROM emp e
        WHERE e.ENAME LIKE 'J%'
        ORDER BY e.ENAME) a
;

-------------------------------------------------------------
-- DML : 데이터 조작어
-- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령

-- 데이터를 넣을 테이블의 형태
DROP TABLE member; -- Table MEMBER이(가) 삭제되었습니다.
CREATE TABLE member
( member_id    VARCHAR2(3)   
 ,member_name  VARCHAR2(15)  NOT NULL
 ,phone        VARCHAR2(4) -- NULL 허용시 제약조건 비우면 됨
 ,reg_date     DATE          DEFAULT sysdate
 ,address      VARCHAR2(30)
 ,birth_month  NUMBER(2)
 ,gender       VARCHAR2(1)   
 ,CONSTRAINT pk_member PRIMARY KEY (member_id)
 ,CONSTRAINT ck_member_gender CHECK (gender IN('M','F'))
 ,CONSTRAINT ck_member_birth  CHECK (birth_month > 0 AND birth_month <= 12)
);

-- 테이블 구조 확인
DESC member; 

--- 1. INTO 구문에 컬럼 이름 생략시 데이터 추가
-- 전체 데이터 추가
INSERT INTO member
VALUES ('M01', '전현찬', '5250', sysdate, '덕명동', 11, 'M');

INSERT INTO member
VALUES ('M02', '조성철', '9034', sysdate, '오정동', 8, 'M');

INSERT INTO member
VALUES ('M03', '김승유', '5219', sysdate, '오정동', 1, 'M');

-- 몇몇 컬럼에 NULL 데이터 추가
INSERT INTO member
VALUES ('M04', '박길수', '4003', sysdate, NULL, NULL, 'M');

INSERT INTO member
VALUES ('M05', '강현', NULL, NULL, '홍도동', 6, 'M');

INSERT INTO member
VALUES ('M06', '김소민', NULL, sysdate, '월평동', NULL, NULL);

-- 입력데이터 조회
SELECT m.*
  FROM member m
;
-- check 옵션에 위배되는 데이터 추가 시도
INSERT INTO member
VALUES ('M07', '강병우', '2260', sysdate, '사정동', 2, 'N'); -- gender 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_GENDER) violated
*/

INSERT INTO member
VALUES ('M08', '정준호', NULL, sysdate, '나성동', 0, NULL); -- birth_month 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_BIRTH) violated
*/

-- 수정
INSERT INTO member
VALUES ('M07', '강병우', '2260', sysdate, '사정동', 2, 'M');

INSERT INTO member
VALUES ('M08', '정준호', NULL, sysdate, '나성동', 1, NULL);

--- 2. INTO 구문에 컬럼 이름 명시하여 데이터 추가
--    : VALUES 절에 INTO 의 순서대로 
--      값의 타입, 개수를 맞추어서 작성
INSERT INTO member (member_id, member_name, gender)
VALUES ('M09', '윤홍식', 'M');
-- reg_date 컬럼 : DEFAULT 설정이 작동하여 시스템 날짜가 자동 입력
-- phone, address 컬럼 : NULL 값으로 입력되는 것 확인

-- INTO 절에 컬럼 나열시 테이블 정의 순서와 별개로 나열 가능
INSERT INTO member (member_name, address, member_id)
VALUES ('이주영', '용전동', 'M10');

-- PK 값이 중복되는 입력시도
INSERT INTO member (member_name, member_id)
VALUES ('남정규', 'M10');
/*
오류 보고 -
ORA-00001: unique constraint (SCOTT.PK_MEMBER) violated
*/
-- 수정 : 이름 컬럼에 주소가 들어가는 데이터
--       이름, 주소 모두 문자 데이터이기 때문에 타입이 맞아서
--       논리오류 발생
INSERT INTO member (member_name, member_id)
VALUES ('목동', 'M11');

-- 필수 입력 컬럼인 member_name 누락
INSERT INTO member (member_id)
VALUES ('M12');
오류 보고 -
ORA-01400: cannot insert NULL into ("SCOTT"."MEMBER"."MEMBER_NAME")
INSERT INTO member (member_id, member_name)
VALUES ('M12', '이동희');

-- INTO 절에 나열된 컬럼과 VALUES 절의 값의 개수 불일치
INSERT INTO member (member_id, member_name, gender)
VALUES ('M13', '유재성');
-- SQL 오류: ORA-00947: not enough values

-- INTO 절에 나열된 컬럼과 VALUES 절의 데이터 타입이 불일치
INSERT INTO member (member_id, member_name, birth_month)
VALUES ('M13', '유재성', 'M');
-- 숫자가 들어가느느 컬럼에 문자 입력 ORA-01722: invalid number
INSERT INTO member (member_id, member_name, birth_month)
VALUES ('M13', '유재성', 3);

---------------------------------------------------------------------
-- 다중 행 입력 : SUB-QUERY를 사용하여 가능

-- 구문구조
INSERT INTO 테이블이름
VALUES(문장); -- 서브쿼리

-- CREATE AS SELECT 는 데이터를 복사하여 테이블 생성
-- INSERT INTO ~ SELECT 는 이미 만들어진 테이블에
--   데이터만 복사 추가

-- member 테이블의 내용을 조회해서 new_member 로 insert 
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.PHONE IS NOT NULL
;
--5개 행 이(가) 삽입되었습니다.
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.MEMBER_ID > 'M09' 
;
-- 4개 행 이(가) 삽입되었습니다.
-- NEW_MEMBER 테이블 데이터 삭제 X 버튼 클릭 후 -> 데이터반영

-- 성이 '김'인 멤버데이터를 복사 입력
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.MEMBER_NAME LIKE '김%' 
;

-- 짝수달에 태어난 멤버데이터를 복사 
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE MOD(m.BIRTH_MONTH,2) = 0
;

-----------------------------------------------------------------
-- 2) UPDATE : 테이블의 행을 수정
--             WHERE 조건절의 조합에 따라 1행 혹은 다행 수정이 가능

-- member 테이블에서 이름이 잘못들어간 'M11' 멤버 정보를 수정

-- 데이터 수정 전에 영구반영을 실행
commit; -- 커밋 완료.

UPDATE member m
   SET m.MEMBER_NAME = '남정규'
 WHERE m.MEMBER_ID = 'M11'
;
-- 1 행 이(가) 업데이트되었습니다.

-- 'M05' 회원의 전화번호 필드를 업데이트
commit; -- 커밋 완료.
UPDATE member m
   SET m.PHONE = '1743'
-- WHERE m.MEMBER_ID = 'M05'
;
-- 13개 행 이(가) 업데이트되었습니다.
-- WHERE 조건절의 실수로 DML 작업 실수가 발생
-- 데이터 상태 되돌리기
rollback; -- 롤백 완료. / 마지막 커밋 상태까지 되돌림

-- 2개 이상의 컬럼을 한번에 업데이트 SET 절에 나열
UPDATE member m
   SET m.PHONE = '0000'
      ,m.REG_DATE = sysdate
 WHERE m.MEMBER_ID = 'M05'
;
commit;

-- '월평동' 사는 '김소민' 멤버의 NULL 업데이트
UPDATE member m
   SET m.PHONE = '4724'
      ,m.BIRTH_MONTH = 1
      ,m.GENDER = 'F'
 WHERE m.ADDRESS = '월평동'
-- m.MEMBER_ID = 'M06'
;
-- 위의 실행 결과는 의도대로 반영되는 것처럼 보이나
-- 월평동에 사는 사람이 많다면 
-- 월평동의 모든 사람정보가 수정될 것.
-- 따라서, UPDATE 구문 작성시 WHERE 조건은 
-- 주의를 기울여서 작성해야 함.

/* DML : UPDATE, DELETE 작업시 주의 점

 딱 하나의 데이터를 수정/삭제 하려면
 WHERE 절의 비교 조건에 반드시 PK 로 설정한 
 컬럼의 값을 비교하도록 권장.
 
 PK 는 전체 행에서 유일하고, NOT NULL 임이 보장
 되기 때문.
 
 UPDATE, DELETE 는 구문에 물리적 오류가 없으면 
 WHERE 조건에 맞는 전체 행 대상으로 작업하는 
 것이 기본이므로 항상 주의!!!!

*/













---------------------------------------------------------------------------------------
-- 실습 1)
INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)
VALUES ('C001', '김수현', 1988, sysdate, '경기');
INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)
VALUES ('C002', '이효리', 1979, sysdate, '제주');
INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)
VALUES ('C003', '원빈', 1977, sysdate, '강원');

SELECT c.*
  FROM customer c
;
/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE
----------------------------------------------------
C001	김수현	1988	18/07/02	경기	
C002	이효리	1979	18/07/02	제주	
C003	원빈	    1977	18/07/02	강원	
*/

-- 실습 2)
UPDATE customer c
   SET c.NAME = '차태현'
      ,c.BIRTHYEAR = 1976
 WHERE USERID = 'C001'
;
/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE
-----------------------------------------------------
C001	차태현	1976	18/07/02	경기	
C002	이효리	1979	18/07/02	제주	
C003	원빈	    1977	18/07/02	강원	
*/

-- 실습 3)
UPDATE customer c
   SET c.ADDRESS = '서울'
;
/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE
-----------------------------------------------------
C001	차태현	1976	18/07/02	서울	
C002	이효리	1979	18/07/02	서울	
C003	원빈	    1977	18/07/02	서울	
*/

-- 실습 4)
DELETE FROM customer 
 WHERE USERID = 'C003'
;
/* USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE
-----------------------------------------------------
C001	차태현	1976	18/07/02	서울	
C002	이효리	1979	18/07/02	서울	
*/

-- 실습 5)





