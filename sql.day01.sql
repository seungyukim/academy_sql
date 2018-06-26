-- SQL day01
-- 1. SCOTT 계정 활성화 : sys 계정으로 접속하여 스크립트 실행
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
-- 2. 접속 유저 확인 명령
show user
-- 3. HR 계정 활성화 : sys 계정으로 접속하여 
--                   다른 사용자 확장 후 HR 계정의
--                   계정잠심, 비밀번호 만료 상태 해제
--------------------------------------------------------------------                        
-- SCOTT 계정의 데이터 구조
-- (1) EMP 테이블 내용 조회
SELECT * 
  FROM EMP
; 

/* -----------------------------------------------------------------
EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
----------------------------------------------------------------- */
-- (2) DEPT 테이블 내용 조회
SELECT *
  FROM DEPT
;

/* -----------------------
DEPTNO, DNAME, LOC
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
------------------------ */
-- (3) SELGRADE 테이블 내용 조회
SELECT *
  FROM salgrade
;

/* ---------------
GRADE, LOSAL, HISAL
1	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
----------------- */

-- 01. DQL : SELECT
-- (1) SELECT 구문
-- emp 테이블에서 사번, 이름, 직무를 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
  FROM emp e --소문자 e는 alias(별칭)
;

-- emp 테이블에서 직무만 조회
SELECT e.JOB
  FROM emp e
;

/* -------
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT
SALESMAN
CLERK
ANALYST
CLERK
--------- */

-- (2) DISTINCT 문 : SELECT 문 사용시 중복을 배제하여 조회
-- emp 테이블에서 job 컬럼의 중복을 배제하여 조회
SELECT DISTINCT e.JOB
  FROM emp e
;

/* --------
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
--------- */

-- * SQL SELECT 구문의 작동 원리 : 테이블의 한 행을 기본 단위로 실행함.
--                               테이블 행의 개수만큼 반복 실행.
SELECT 'Hello, SQL~'
  FROM emp e
;

/* ---------
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
--------- */

-- emp 테이블에서 job, deptno 에 대해 중복을 제거하여 조회
SELECT DISTINCT e.JOB
               ,e.DEPTNO
  FROM emp e
;

/* ------------
MANAGER	    20
PRESIDENT	10
CLERK	    10
SALESMAN	30
ANALYST	    20
MANAGER	    30
MANAGER	    10
CLERK	    30
CLERK	    20
------------ */

-- (3) ORDER BY 절 : 정렬
-- emp 테이블에서 job을 중복배제하여 조회하고 결과는 오름차순으로 정렬
SELECT DISTINCT e.JOB
  FROM emp e
  ORDER BY e.JOB asc
;

/* --------
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
--------- */

-- emp 테이블에서 job 을 중복배제하여 조회하고 내림차순으로 정렬
SELECT DISTINCT e.JOB
  FROM emp e
  ORDER BY e.JOB DESC
;

/* --------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
--------- */

-- 7) emp 테이블에서 comm 을 가장 많이 받는 순서대로 출력
--    사번, 이름, 직무, 입사일, 커미션 순으로 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.HIREDATE
      ,e.COMM
  FROM emp e
  ORDER BY e.COMM desc
;

/* ------------------------------------------
7369	SMITH	CLERK	    80/12/17	
7698	BLAKE	MANAGER	    81/05/01	
7902	FORD	ANALYST	    81/12/03	
7900	JAMES	CLERK	    81/12/03	
7839	KING	PRESIDENT	81/11/17	
7566	JONES	MANAGER	    81/04/02	
7934	MILLER	CLERK	    82/01/23	
7782	CLARK	MANAGER	    81/06/09	
7654	MARTIN	SALESMAN	81/09/28	1400
7521	WARD	SALESMAN	81/02/22	500
7499	ALLEN	SALESMAN	81/02/20	300
7844	TURNER	SALESMAN	81/09/08	0
------------------------------------------ */

-- 8) emp 테이블에서 comm 이 적은 순서대로, 직무별 오름차순, 이름별 오름차순으로 조회
--    사번, 이름, 직무, 입사일, 커미션을 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.HIREDATE
      ,e.COMM
  FROM emp e
  ORDER BY e.COMM, e.JOB, e.ENAME
;

/* ---------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7900	JAMES	CLERK	    81/12/03	
7934	MILLER	CLERK	    82/01/23	
7369	SMITH	CLERK	    80/12/17	
7698	BLAKE	MANAGER	    81/05/01	
7782	CLARK	MANAGER	    81/06/09	
7566	JONES	MANAGER	    81/04/02	
7839	KING	PRESIDENT	81/11/17	
--------------------------------------------- */

-- 9) emp 테이블에서 comm 이 적은 순서대로, 직무별 오름차순, 이름별 내림차순으로 정렬
--    사번, 이름, 직무, 입사일, 커미션을 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.HIREDATE
      ,e.COMM
  FROM emp e
  ORDER BY e.COMM, e.JOB, e.ENAME DESC
;

/* ------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7369	SMITH	CLERK	    80/12/17	
7934	MILLER	CLERK	    82/01/23	
7900	JAMES	CLERK	    81/12/03	
7566	JONES	MANAGER	    81/04/02	
7782	CLARK	MANAGER	    81/06/09	
7698	BLAKE	MANAGER	    81/05/01	
7839	KING	PRESIDENT	81/11/17	
------------------------------------------ */

-- (4) Alias : 별칭
-- 10) emp 테이블에서
--     empno --> Employee No.
--     ename --> Employee Name
--     job   --> job Name
SELECT e.EMPNO as "Employee No."
      ,e.ENAME as "Employee Name"
      ,e.JOB as "job Name"
  FROM emp e
;

-- 11) 10번과 동일 as 키워드 생략하여 조회 
--     empno --> 사번
--     ename --> 사원 이름
--     job   --> 직무
SELECT e.EMPNO as 사번
      ,e.ENAME as "사원 이름"
      ,e.JOB as 직무
  FROM emp e
;

-- 12) 테이블에 붙이는 별칭을 주지 않았을 때
SELECT EMPNO
  FROM emp 
;

SELECT emp.EMPNO
  FROM emp 
;

SELECT e.EMPNO
  FROM emp e
;

SELECT d.DEPTNO
  FROM dept d
;

-- 13) 영문별칭 사용시 특수기호 _ 사용하는 경우
SELECT e.EMPNO Employee_No
      ,e.ENAME "Employee Name" --대소문자 구분을 위해 " "을 씀
  FROM emp e
;

-- 14) 별칭과 정렬의 조합 : SELECT 절에 별칭을 준 경우 ORDER BY 절에서 사용가능
--     emp 테이블에서 사번, 이름, 직무, 입사일, 커미션을 조회할 때
--     정렬은 커미션, 직무, 이름을 오름차순 정렬
SELECT e.EMPNO 사번
      ,e.ENAME 이름
      ,e.JOB 직무
      ,e.HIREDATE 입사일
      ,e.COMM 커미션
  FROM emp e
  ORDER BY 커미션, 직무, 이름
;

-- 15) DISTINCT, 별칭, 정렬의 조합
-- job 을 중복으로 제거하여 직무 라는 별칭을 조회하고
-- 내림차순으로 정렬
SELECT DISTINCT e.JOB as 직무
  FROM emp e
  ORDER BY 직무 DESC
;

-- 16) emp 테이블에서 empno 이 7900인 사원의
--     사번, 이름, 직무, 입사일, 급여, 부서번호
SELECT e.EMPNO as 사번
      ,e.ENAME as 이름
      ,e.JOB as 직무
      ,e.HIREDATE as 급여
      ,e.DEPTNO as 부서번호
  FROM emp e
  WHERE e.EMPNO = 7900
; 

/* ------------------------------------
7900	JAMES	CLERK	81/12/03	30
------------------------------------ */

-- 17) emp 테이블에서 empno 는 7900 이거나 deptno 가 20인 직원의 정보를 조회
--     사번, 이름, 직무, 입사일, 급여, 부서번호
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.HIREDATE
      ,e.SAL
      ,e.DEPTNO
  FROM emp e
  WHERE e.EMPNO = 7900 
     OR e.DEPTNO = 20
;

/* --------------------------------------------
7369	SMITH	CLERK	80/12/17	800	    20
7566	JONES	MANAGER	81/04/02	2975	20
7900	JAMES	CLERK	81/12/03	950	    30
7902	FORD	ANALYST	81/12/03	3000	20
-------------------------------------------- */

-- 18) 17번의 조회조건을 AND 조건으로 조합
--     emp 테이블에서 empno 가 7900 이고 deptno 가 20인 직원의 정보를 조회
--     사번, 이름, 직무, 입사일, 급여, 부서번호
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.HIREDATE
      ,e.SAL
      ,e.DEPTNO
  FROM emp e
  WHERE e.EMPNO = 7900 
    AND e.DEPTNO = 20
;
-- 인출된 모든 행 : 0