-- 실습 3)
SELECT e1.EMPNO "직원 사번"
      ,e1.ENAME "직원 이름"
      ,e1.MGR   "상사 사번"
      ,e2.ENAME "상사 이름"
  FROM emp e1
      ,emp e2
 WHERE e1.MGR = e2.EMPNO(+)
   AND e1.MGR IS NULL
;
/*
6666	JJ		
7777	J%JONES		
8888	J		
9999	J_JUNE		
7839	KING		
*/

-- 실습 4)
SELECT e2.EMPNO "직원 사번"
      ,e2.ENAME "직원 이름"
      ,e1.EMPNO "부하 직원 사번"
  FROM emp e1
      ,emp e2
 WHERE e1.MGR(+) = e2.EMPNO
   AND e1.MGR IS NULL
;
/*
8888	J	
7844	TURNER	
7777	J%JONES	
7521	WARD	
7654	MARTIN	
6666	JJ	
7499	ALLEN	
7934	MILLER	
9999	J_JUNE	
7369	SMITH	
7900	JAMES	
*/

-- 실습 5)
SELECT e.ENAME "직원 이름"
      ,e.JOB "직무"
  FROM emp e
 WHERE e.JOB = (SELECT e.JOB
                  FROM emp e
                 WHERE e.ENAME = 'JAMES')
;
/*
SMITH	CLERK
JAMES	CLERK
MILLER	CLERK
J_JUNE	CLERK
J	    CLERK
J%JONES	CLERK
*/

