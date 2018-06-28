-- 실습 16) Simple CASE
SELECT e.EMPNO 사원번호
      ,e.ENAME 이름
      ,e.SAL 급여
      ,TO_CHAR(CASE e.JOB WHEN 'CLERK'     THEN 300
                          WHEN 'SALESMAN'  THEN 450
                          WHEN 'MANAGER'   THEN 600
                          WHEN 'ANALYST'   THEN 800
                          WHEN 'PRESIDENT' THEN 1000
                          ELSE 0
                END, '$9,999') as "자기 계발비"
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
6666	JJ	    2800	     $0
*/

-- 실습 17) Searched CASE
SELECT e.EMPNO 사원번호
      ,e.ENAME 이름
      ,e.SAL 급여
      ,TO_CHAR(CASE WHEN e.JOB = 'CLERK'     THEN 300
                    WHEN e.JOB = 'SALESMAN'  THEN 450
                    WHEN e.JOB = 'MANAGER'   THEN 600
                    WHEN e.JOB = 'ANALYST'   THEN 800
                    WHEN e.JOB = 'PRESIDENT' THEN 1000
                    ELSE 0
                END, '$9,999') as "자기 계발비"
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
6666	JJ	    2800	     $0
*/

-- 실습 18)
SELECT COUNT(*) as "전체 행 개수"
  FROM emp e
; -- 16

-- 실습 19)
SELECT COUNT(DISTINCT e.JOB) as "직무의 개수"
  FROM emp e
; -- 5
  
-- 실습 20)
SELECT COUNT(e.COMM) as "커미션을 받는 사원 수"
  FROM emp e
; -- 4

-- 실습 21)
SELECT SUM(e.SAL) as "급여 총합"
  FROM emp e
; -- 28925

-- 실습 22)
SELECT AVG(e.SAL) as "급여 평균"
  FROM emp e
; -- 1807.8125

-- 실습 23)
SELECT TO_CHAR(SUM(e.SAL),'$9,999.99') as "급여 총합"
      ,TO_CHAR(AVG(e.SAL),'$9,999.99') as "급여 평균"
      ,TO_CHAR(MAX(e.SAL),'$9,999.99') as "최대 급여"
      ,TO_CHAR(MIN(e.SAL),'$9,999.99') as "최소 급여"
  FROM emp e
 WHERE e.DEPTNO = 20 
;
/* 급여 총합, 급여 평균, 최대 급여, 최소 급여
----------------------------------------------
 $6,775.00	 $2,258.33	 $3,000.00	   $800.00
*/

-- 실습 24)
SELECT TO_CHAR(STDDEV(e.SAL),'$9,999,999.99') as "급여 표준 편차"
      ,TO_CHAR(VARIANCE(e.SAL),'$9,999,999.99') as "급여 분산"
  FROM emp e
;
/* 급여 표준 편차, 급여 분산
------------------------------
     $1,269.96	 $1,612,809.90
*/

-- 실습 25)
SELECT TO_CHAR(STDDEV(e.SAL),'$9,999,999.99') as "급여 표준 편차"
      ,TO_CHAR(VARIANCE(e.SAL),'$9,999,999.99') as "급여 분산"
  FROM emp e
 WHERE e.JOB = 'SALESMAN' 
;
/* 급여 표준 편차, 급여 분산
------------------------------
       $177.95	    $31,666.67
*/

-- 실습 26)
SELECT nvl(e.DEPTNO||'','미배정') 부서번호
      ,TO_CHAR(AVG(DECODE(e.JOB
             ,'CLERK','300'
             ,'SALESMAN','450'
             ,'MANAGER','600'
             ,'ANALYST','800'
             ,'PRESIDENT','1000')),'$9,999.00') as "급여 평균"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY 부서번호
;
/*
10	       $633.33
20	       $566.67
30	       $450.00
미배정	   $300.00
*/

-- 실습 27)
SELECT nvl(e.DEPTNO||'','부서 미배정') 부서번호
      ,nvl(e.JOB||'','직무 미배정') 직무
      ,TO_CHAR(AVG(DECODE(e.JOB
             ,'CLERK','300'
             ,'SALESMAN','450'
             ,'MANAGER','600'
             ,'ANALYST','800'
             ,'PRESIDENT','1000'
             ,0)),'$9,999.00') as "급여 평균"  
  FROM emp e
 GROUP BY e.DEPTNO, e.JOB
 ORDER BY e.DEPTNO, e.JOB DESC
;
/*
10	        PRESIDENT	 $1,000.00
10	        MANAGER	     $600.00
10	        CLERK	     $300.00
20	        MANAGER	     $600.00
20	        CLERK	     $300.00
20	        ANALYST	     $800.00
30	        SALESMAN	 $450.00
30	        MANAGER	     $600.00
30	        CLERK	     $300.00
부서 미배정	직무 미배정	 $.00
부서 미배정	CLERK	     $300.00
*/

-- 실습 1)
SELECT e.ENAME
      ,d.DNAME
  FROM emp e NATURAL JOIN dept d
;
/*
SMITH	RESEARCH
ALLEN	SALES
WARD	SALES
JONES	RESEARCH
MARTIN	SALES
BLAKE	SALES
CLARK	ACCOUNTING
KING	ACCOUNTING
TURNER	SALES
JAMES	SALES
FORD	RESEARCH
*/

-- 실습 2)
SELECT e.ENAME
      ,d.DNAME
  FROM emp e JOIN dept d USING (deptno)
;
/*
SMITH	RESEARCH
ALLEN	SALES
WARD	SALES
JONES	RESEARCH
MARTIN	SALES
BLAKE	SALES
CLARK	ACCOUNTING
KING	ACCOUNTING
TURNER	SALES
JAMES	SALES
FORD	RESEARCH
*/
