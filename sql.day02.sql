-- SQL day02
-------------------------------------------------------------------- 
--- IS NULL, IS NOT NULL 연산자
/*  
IS NULL : 비교하려는 컬럼의 값이 NULL 이면 true, NULL 이 아니면 false
IS NOT NULL : 비교하려는 컬럼의 값이 NULL 이 아니면 true, NULL 이면 false
    
NULL 값은 컬럼은 비교연산자와 연산이 불가능 하므로
NULL 값 비교 연산자가 따로 존재함
    
col1 = null ==> NULL 값에 대해서는 = 비교 연산자 사용 불가능
col1 != null ==> NULL 값에 대해서는 !=, <> 비교 연산자 사용 불가능
*/
--- 27) 어떤 직원의 mgr가 지정되지 않은 직원 정보 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.MGR
  FROM emp e
 WHERE e.MGR IS NULL
;
--- mgr이 지정된 직원의 직원 정보 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.MGR
  FROM emp e
 WHERE e.MGR IS NOT NULL
;
--- IS NOT NULL 대신에 <>
SELECT e.EMPNO
      ,e.ENAME
      ,e.MGR
  FROM emp e
 WHERE e.MGR <> NULL
;
-- > 인출된 모든 행 : 0
-- > 실행에 오류는 없지만 올바른 결과가 아님

--- BETWEEN ~ AND ~ : 범위 비교 연산자 범위 포함
--  a <= sal <= b : 이러한 범위 연산과 동일

--- 28) 급여가 500 ~ 1200 사이인 직원 정보 조회
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
  FROM emp e
 WHERE e.SAL BETWEEN 500 AND 1200
;
--BETWEEN 500 AND 1200 과 같은 결과를 내는 비교연산자
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
  FROM emp e
 WHERE e.SAL >= 500 
   AND e.SAL <= 1200 -- 등호가 들어가는 비교 연산자를 사용
;

--- EXISTS 연산자 : 조회한 결과가 1행 이상 있다.
--                 어떤 SELECT 구문을 실행했을 때 조회 결과가 1행 이상 있으면
--                 이 연산자의 결과가 true
--                 조회 결과 : <인출된 모든 행 : 0> 인 경우 false
--                 따라서 서브쿼리와 함께 사용됨

--- 29) 급여가 3000이 넘는 사람이 있는가?
--   (1) 급여가 3000이 넘는 사람을 찾는 구문을 작성
SELECT e.ENAME
  FROM emp e
 WHERE e.SAL > 3000 
;

/*
위의 쿼리 실행 결과가 1행 이라도 존재하면 화면에
"급여가 3000이 넘는 직원이 존재함" 이라고 출력
*/

SELECT '급여가 3000이 넘는 직원이 존재함' as "시스템 메시지"
  FROM dual
 WHERE EXISTS (SELECT e.ENAME
                 FROM emp e
                WHERE e.SAL > 3000 )
;

/*
위의 쿼리 실행 결과가 1행 이라도 존재하지 않으면 화면에
"급여가 10000이 넘는 직원이 존재하지 않음" 이라고 출력
*/

SELECT '급여가 10000이 넘는 직원이 존재하지 않음' as "시스템 메시지"
  FROM dual
 WHERE NOT EXISTS (SELECT e.ENAME
                 FROM emp e
                WHERE e.SAL > 10000 )
;

-- (6) 연산자 : 결합연산자 (||)
--  오라클에만 존재, 문자열 결합(접합)
--  다른 자바 등의 프로그래밍 언어에서는 OR 논리 연산자로 사용되므로
--  혼동에 주의

-- 오늘의 날짜를 화면에 조회
SELECT sysdate
  FROM dual
;

-- 오늘의 날짜를 알려주는 문장을 만들려면
SELECT '오늘의 날짜는 ' || sysdate || '입니다.' as "오늘의 날짜"
  FROM dual
;

-- 직원의 사번을 알려주는 구문을 || 연산자를 사용하여 작성
SELECT '안녕하세요. ' || e.ENAME || '씨, 당신의 사번은 ' || e.EMPNO || '입니다.' as "사번 알리미"
  FROM emp e
;

--- 4) 데이터 타입 변환 함수
/*
  TO_CHAR()    : 숫자, 날짜 ==> 문자
  TO_DATE()    : 날짜 형식의 문자 ===> 날짜
  TO_NUMBER()  : 숫자로만 구성된 문자데이터 ===> 숫자
*/

---- 1. TO_CHAR() : 숫자패턴 적용
--    숫자패턴 : 9 ==> 한자리 숫자
SELECT TO_CHAR(12345, '9999') FROM dual; -- #####
SELECT TO_CHAR(12345, '99999') FROM dual; --  12345

SELECT e.EMPNO
      ,e.SAL as 숫자
      ,TO_CHAR(e.SAL) as 문자
  FROM emp e
;

SELECT TO_CHAR(12345, '99999999') data
  FROM dual; --     12345
-- 앞에 빈칸을 0으로 채우기
SELECT TO_CHAR(12345, '09999999') data
  FROM dual; --  00012345
-- 소수점 이하 표현  
SELECT TO_CHAR(12345, '99999999.99') data
  FROM dual; --     12345.00
-- 숫자 패턴에서 3자리씩 끊어 읽기 + 소수점 이하 표현 
SELECT TO_CHAR(12345, '9,999,999.99') data
  FROM dual; --     12,345.00
  
---- 2. TO_DATE() 날짜 패턴에 맞는 문자 값을 날짜 데이터로 변경
SELECT TO_DATE('2018-06-27', 'YYYY-MM-DD') today FROM dual; -- 18/06/27
SELECT '2018-06-27' today FROM dual; -- 2018-06-27

SELECT TO_DATE('2018-06-27', 'YYYY-MM-DD') + 10 today FROM dual; -- 날짜 연산 가능
SELECT '2018-06-27' + 10 today FROM dual;
--ORA-01722: invalid number ==> '2018-06-27' 문자 + 숫자 10의 연산 불가능

---- 3. TO_NUMBER() : 오라클이 자동 형변환을 제공하므로 자주 사용은 안됨
SELECT '1000' + 10 resul FROM dual;
SELECT TO_NUMBER('1000') + 10 result FROM dual;

--- 5) DECODE(expr, search, result [,search, result]..[, default])
/*
   만약에 default 가 설정이 안되었고
   expr 과 일치하는 search가 없는 경우 null 을 리턴
*/
SELECT DECODE('YES' -- expr
             ,'YES', '입력값이 YES 입니다.' -- search, result 세트1
             ,'NO', '입력값이 NO 입니다.'   -- search, result 세트2
             ) as result
  FROM dual
; -- 입력값이 YES 입니다.

SELECT DECODE('NO' -- expr
             ,'YES', '입력값이 YES 입니다.' -- search, result 세트1
             ,'NO', '입력값이 NO 입니다.'   -- search, result 세트2
             ) as result
  FROM dual
; -- 입력값이 NO 입니다.

SELECT DECODE('YY' -- expr
             ,'YES', '입력값이 YES 입니다.' -- search, result 세트1
             ,'NO', '입력값이 NO 입니다.'   -- search, result 세트2
             ) as result
  FROM dual
;
-- >> expr 과 일치하는 search 가 없고, default 설정도 안되었을 때
--    결과가 <인출된 모든 행 : 0> 이 아닌 NULL 이라는 것 확인

SELECT DECODE('예' -- expr
             ,'YES', '입력값이 YES 입니다.' -- search, result 세트1
             ,'NO', '입력값이 NO 입니다.'   -- search, result 세트2
             ,'입력값이 YES/NO 중 어느 것도 아닙니다.') as result
  FROM dual
; -- 입력값이 YES/NO 중 어느 것도 아닙니다.

-- emp 테이블의 hiredate 의 입사년도를 추출하여 몇년 근무했는지를 계산
-- 장기근속 여부를 판단
-- 1) 입사년도 추출 : 날짜 패턴
SELECT e.EMPNO
      ,e.ENAME
      ,TO_CHAR(e.HIREDATE, 'YYYY') hireyear
  FROM emp e
;
-- 2) 몇년근무 판단 : 오늘 시스템 날짜와 연산
SELECT e.EMPNO
      ,e.ENAME
      ,TO_CHAR(sysdate, 'YYYY') - TO_CHAR(e.HIREDATE, 'YYYY') || '년' "근무햇수"
  FROM emp e
;

-- 3) 37년 이상 된 직원을 장기 근속으로 판단
SELECT a.EMPNO
      ,a.ENAME
      ,DECODE(a.workingyear -- expr
             ,37, '장기 근속자 입니다.' -- search, result1
             ,38, '장기 근속자 입니다.' -- search, result2
             ,'장기 근속자가 아닙니다.') as "장기 근속 여부" -- default
  FROM (SELECT e.EMPNO
              ,e.ENAME
              ,TO_CHAR(sysdate, 'YYYY') - TO_CHAR(e.HIREDATE, 'YYYY') workingyear
          FROM emp e) a
;