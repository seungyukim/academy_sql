-- 실습(23)
SELECT *
  FROM emp e
 WHERE e.SAL BETWEEN 2500 AND 3000
;

/* ---------------------------------------------------------
7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7902	FORD	ANALYST	7566	81/12/03	3000		20
--------------------------------------------------------- */
-- 실습(24)
SELECT *
  FROM emp e
 WHERE e.COMM IS NULL
;

/* ---------------------------------------------------------
7369	SMITH	CLERK	7902	80/12/17	800		    20
7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7839	KING	PRESIDENT		81/11/17	5000		10
7900	JAMES	CLERK	7698	81/12/03	950		    30
7902	FORD	ANALYST	7566	81/12/03	3000		20
7934	MILLER	CLERK	7782	82/01/23	1300		10
--------------------------------------------------------- */
-- 실습(25)
SELECT *
  FROM emp e
 WHERE e.COMM IS NOT NULL
;

/* ------------------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
------------------------------------------------------------------ */
-- 실습(26)
SELECT e.EMPNO as 사번
      ,e.ENAME || '의 월급은 $' || e.SAL || '입니다'  as 월급여
  FROM emp e 
;

/* -------------------------------
사번, 월급여
7369	SMITH의 월급은 $800입니다
7499	ALLEN의 월급은 $1600입니다
7521	WARD의 월급은 $1250입니다
7566	JONES의 월급은 $2975입니다
7654	MARTIN의 월급은 $1250입니다
7698	BLAKE의 월급은 $2850입니다
7782	CLARK의 월급은 $2450입니다
7839	KING의 월급은 $5000입니다
7844	TURNER의 월급은 $1500입니다
7900	JAMES의 월급은 $950입니다
7902	FORD의 월급은 $3000입니다
7934	MILLER의 월급은 $1300입니다
------------------------------- */

-- 실습 1)
SELECT e.EMPNO
      ,INITCAP(e.ENAME)
  FROM emp e
;
/*
7369	Smith
7499	Allen
7521	Ward
7566	Jones
7654	Martin
7698	Blake
7782	Clark
7839	King
7844	Turner
7900	James
7902	Ford
7934	Miller
9999	J_June
8888	J
7777	J%Jones
*/

-- 실습 2)
SELECT e.EMPNO
      ,LOWER(e.ENAME)
  FROM emp e
;
/*
7369	smith
7499	allen
7521	ward
7566	jones
7654	martin
7698	blake
7782	clark
7839	king
7844	turner
7900	james
7902	ford
7934	miller
9999	j_june
8888	j
7777	j%jones
*/

-- 실습 3)
SELECT e.EMPNO
      ,UPPER(e.ENAME)
  FROM emp e
;
/*
7369	SMITH
7499	ALLEN
7521	WARD
7566	JONES
7654	MARTIN
7698	BLAKE
7782	CLARK
7839	KING
7844	TURNER
7900	JAMES
7902	FORD
7934	MILLER
9999	J_JUNE
8888	J
7777	J%JONES
*/

-- 실습 4)
SELECT LENGTH('korea')
  FROM dual
; -- 5

SELECT LENGTHB('korea')
  FROM dual
; -- 5

-- 실습 5)
SELECT LENGTH('김승유')
  FROM dual
; -- 3

SELECT LENGTHB('김승유')
  FROM dual
; -- 9

-- 실습 6)
SELECT CONCAT('SQL', '배우기') FROM dual; -- SQL배우기

-- 실습 7)
SELECT SUBSTR('SQL 배우기', 5, 2) FROM dual; -- 배우

-- 실습 8)
SELECT LPAD('SQL', 7, '$') FROM dual; -- $$$$SQL

-- 실습 9)
SELECT RPAD('SQL', 7, '$') FROM dual; -- SQL$$$$

-- 실습 10)
SELECT LTRIM('   sql 배우기    ') FROM dual; -- sql 배우기    

-- 실습 11)
SELECT RTRIM('   sql 배우기    ') FROM dual; --    sql 배우기

-- 실습 12)
SELECT TRIM('   sql 배우기    ') FROM dual;  -- sql 배우기

-- 실습 13)
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
      ,NVL(e.COMM, 0)
  FROM emp e
;

/*
7369	SMITH	800	    0
7499	ALLEN	1600	300
7521	WARD	1250	500
7566	JONES	2975	0
7654	MARTIN	1250	1400
7698	BLAKE	2850	0
7782	CLARK	2450	0
7839	KING	5000	0
7844	TURNER	1500	0
7900	JAMES	950	    0
7902	FORD	3000	0
7934	MILLER	1300	0
9999	J_JUNE	500	    0
8888	J	    400	    0
7777	J%JONES	300	    0
*/

-- 실습 14)
SELECT e.EMPNO
      ,e.ENAME
      ,NVL2(e.COMM, (e.SAL + e.COMM), 0) as "급여 + 커미션"
  FROM emp e
;

/*
7369	SMITH	0
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	0
7654	MARTIN	2650
7698	BLAKE	0
7782	CLARK	0
7839	KING	0
7844	TURNER	1500
7900	JAMES	0
7902	FORD	0
7934	MILLER	0
9999	J_JUNE	0
8888	J	0
7777	J%JONES	0
*/

-- 실습 15)
SELECT e.EMPNO 사원번호
      ,e.ENAME 이름
      ,e.SAL 급여
      ,TO_CHAR(DECODE(e.JOB
             ,'CLERK', 300
             ,'SALESMAN', 450
             ,'MANAGER', 600
             ,'ANALYST', 800
             ,'PRESIDENT', 1000
             ,'자기 계발비가 없습니다.'), '$9,999') as "자기 계발비"
  FROM emp e
;

/*
7369	SMITH	800	       $300
7499	ALLEN	1600	   $450
7521	WARD	1250	   $450
7566	JONES	2975	   $600
7654	MARTIN	1250	   $450
7698	BLAKE	2850	   $600
7782	CLARK	2450	   $600
7839	KING	5000	 $1,000
7844	TURNER	1500	   $450
7900	JAMES	950	       $300
7902	FORD	3000	   $800
7934	MILLER	1300	   $300
9999	J_JUNE	500	       $300
8888	J	    400	       $300
7777	J%JONES	300	       $300
*/