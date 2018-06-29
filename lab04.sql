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

-- 실습 1)
DROP TABLE customer;
CREATE TABLE customer
( userid     VARCHAR2(4)
 ,name       VARCHAR2(30) NOT NULL
 ,birthyear  NUMBER(4)
 ,regdate    DATE         DEFAULT sysdate
 ,address    VARCHAR2(30)
 ,CONSTRAINT pk_customer PRIMARY KEY (userid)
);

-- 실습 2)
DESC customer;
/*
이름        널?       유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
*/


-- 실습 3)
DROP TABLE new_cust;
CREATE TABLE new_cust
AS
SELECT *
  FROM customer
 WHERE 1 = 2
;

-- 실습 4)
DESC new_cust;
/*
이름        널?       유형           
--------- -------- ------------ 
USERID             VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
*/

-- 실습 5)
DROP TABLE salesman;
CREATE TABLE salesman
AS
SELECT *
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;

-- 실습 6)
SELECT *
  FROM salesman
;
/*
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
*/

-- 실습 7)
ALTER TABLE customer ADD 
( phone VARCHAR2(11)
 ,grade VARCHAR2(30)
 ,CONSTRAINT ck_customer_grade CHECK (grade IN ('VIP','GOLD','SILVER'))
);

-- 실습 8)
ALTER TABLE customer DROP COLUMN grade;

-- 실습 9)
ALTER TABLE customer MODIFY phone VARCHAR2(4)
                     MODIFY userid NUMBER(4)
;
ALTER TABLE customer MODIFY userid VARCHAR2(30);        
DESC customer;
/*
이름        널?       유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(30) 
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(4)  
*/

