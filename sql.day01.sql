-- SQL day01
-- 1. SCOTT ���� Ȱ��ȭ : sys �������� �����Ͽ� ��ũ��Ʈ ����
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
-- 2. ���� ���� Ȯ�� ���
show user
-- 3. HR ���� Ȱ��ȭ : sys �������� �����Ͽ� 
--                   �ٸ� ����� Ȯ�� �� HR ������
--                   �������, ��й�ȣ ���� ���� ����
--------------------------------------------------------------------                        
-- SCOTT ������ ������ ����
-- (1) EMP ���̺� ���� ��ȸ
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
-- (2) DEPT ���̺� ���� ��ȸ
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
-- (3) SELGRADE ���̺� ���� ��ȸ
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
-- (1) SELECT ����
-- emp ���̺��� ���, �̸�, ������ ��ȸ
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
  FROM emp e --�ҹ��� e�� alias(��Ī)
;

-- emp ���̺��� ������ ��ȸ
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

-- (2) DISTINCT �� : SELECT �� ���� �ߺ��� �����Ͽ� ��ȸ
-- emp ���̺��� job �÷��� �ߺ��� �����Ͽ� ��ȸ
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

-- * SQL SELECT ������ �۵� ���� : ���̺��� �� ���� �⺻ ������ ������.
--                               ���̺� ���� ������ŭ �ݺ� ����.
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

-- emp ���̺��� job, deptno �� ���� �ߺ��� �����Ͽ� ��ȸ
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

-- (3) ORDER BY �� : ����
-- emp ���̺��� job�� �ߺ������Ͽ� ��ȸ�ϰ� ����� ������������ ����
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

-- emp ���̺��� job �� �ߺ������Ͽ� ��ȸ�ϰ� ������������ ����
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

-- 7) emp ���̺��� comm �� ���� ���� �޴� ������� ���
--    ���, �̸�, ����, �Ի���, Ŀ�̼� ������ ��ȸ
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

-- 8) emp ���̺��� comm �� ���� �������, ������ ��������, �̸��� ������������ ��ȸ
--    ���, �̸�, ����, �Ի���, Ŀ�̼��� ��ȸ
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

-- 9) emp ���̺��� comm �� ���� �������, ������ ��������, �̸��� ������������ ����
--    ���, �̸�, ����, �Ի���, Ŀ�̼��� ��ȸ
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

-- �ǽ�(1)
SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,e.SAL
  FROM emp e
  ORDER BY SAL DESC
;

/* ------------------------------
7839	KING	PRESIDENT	5000
7902	FORD	ANALYST	    3000
7566	JONES	MANAGER	    2975
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7499	ALLEN	SALESMAN	1600
7844	TURNER	SALESMAN	1500
7934	MILLER	CLERK	    1300
7654	MARTIN	SALESMAN	1250
7521	WARD	SALESMAN	1250
7900	JAMES	CLERK	    950
7369	SMITH	CLERK	    800
------------------------------ */
-- �ǽ�(2)
SELECT e.EMPNO
      ,e.ENAME
      ,e.HIREDATE
  FROM emp e
  ORDER BY HIREDATE ASC
;

/* -----------------------
7369	SMITH	80/12/17
7499	ALLEN	81/02/20
7521	WARD	81/02/22
7566	JONES	81/04/02
7698	BLAKE	81/05/01
7782	CLARK	81/06/09
7844	TURNER	81/09/08
7654	MARTIN	81/09/28
7839	KING	81/11/17
7900	JAMES	81/12/03
7902	FORD	81/12/03
7934	MILLER	82/01/23
----------------------- */
-- �ǽ�(3)
SELECT e.EMPNO
      ,e.ENAME
      ,e.COMM
  FROM emp e
  ORDER BY e.COMM ASC
;

/* ------------------
7844	TURNER	0
7499	ALLEN	300
7521	WARD	500
7654	MARTIN	1400
7839	KING	
7900	JAMES	
7902	FORD	
7782	CLARK	
7934	MILLER	
7566	JONES	
7369	SMITH	
7698	BLAKE	
------------------ */
-- �ǽ�(4)
SELECT e.EMPNO
      ,e.ENAME
      ,e.COMM
  FROM emp e
  ORDER BY e.COMM DESC
;

/* -------------------
7369	SMITH	
7698	BLAKE	
7902	FORD	
7900	JAMES	
7839	KING	
7566	JONES	
7934	MILLER	
7782	CLARK	
7654	MARTIN	1400
7521	WARD	500
7499	ALLEN	300
7844	TURNER	0
-------------------- */
-- �ǽ�(5)
SELECT e.EMPNO AS "���"
      ,e.ENAME AS "�̸�"
      ,e.SAL AS "�޿�"
      ,e.HIREDATE AS "�Ի���"
  FROM emp e
;

/* ------------------------------
7369	SMITH	800	    80/12/17
7499	ALLEN	1600	81/02/20
7521	WARD	1250	81/02/22
7566	JONES	2975	81/04/02
7654	MARTIN	1250	81/09/28
7698	BLAKE	2850	81/05/01
7782	CLARK	2450	81/06/09
7839	KING	5000	81/11/17
7844	TURNER	1500	81/09/08
7900	JAMES	950	    81/12/03
7902	FORD	3000	81/12/03
7934	MILLER	1300	82/01/23
------------------------------ */
-- �ǽ�(6)
SELECT *
  FROM emp
;

/* ------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER  	7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
------------------------------------------------------------------ */
-- �ǽ�(7)
SELECT *
  FROM emp e
  WHERE e.ENAME = "ALLEN"
;
-- �ǽ�(8)
-- �ǽ�(9)
-- �ǽ�(10)
-- �ǽ�(11)
-- �ǽ�(12)
-- �ǽ�(13)
-- �ǽ�(14)
-- �ǽ�(15)
-- �ǽ�(16)
-- �ǽ�(17)
-- �ǽ�(18)
-- �ǽ�(19)
-- �ǽ�(20)
-- �ǽ�(21)
-- �ǽ�(22)
-- �ǽ�(23)
-- �ǽ�(24)
-- �ǽ�(25)
-- �ǽ�(26)
