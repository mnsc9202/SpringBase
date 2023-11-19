-- ******************** MEMBER ********************
--테이블 삭제 (MEMBER)
DROP TABLE MEMBER;

--테이블 생성 (MEMBER)
CREATE TABLE MEMBER(
    id VARCHAR(50),     -- 아이디
    pwd VARCHAR(50),    -- 비밀번호
    name VARCHAR(50),   -- 이름
    email VARCHAR(50),  -- 이메일
    auth NUMBER(1),     -- 권한
    
    --기본키 지정
    CONSTRAINT member_pk PRIMARY KEY (id)
);
