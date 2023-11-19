-- ******************** COMMENT ********************
--테이블 삭제 (POSTCOMMENT)
DROP TABLE POSTCOMMENT;

--테이블 생성 (POSTCOMMENT)
CREATE TABLE POSTCOMMENT(
    seq NUMBER(8) PRIMARY KEY,          -- 댓글 번호 (기본키 지정)
    postNo NUMBER(8) NOT NULL,          -- 게시글 번호
    writerId VARCHAR(50) NOT NULL,      -- 작성자 아이디
    targetId VARCHAR(50),               -- 대상자 아이디
    content VARCHAR2(4000) NOT NULL,    -- 댓글 내용
    createdDate DATE NOT NULL,          -- 작성일
    modifiedDate DATE,                  -- 수정일
    deletedDate DATE,                   -- 삭제일
    deleteAt NUMBER(1) NOT NULL,        -- 삭제여부 (0: false, 1: true)
    
    --답글 관련
    groupNo NUMBER(8), -- 그룹번호
    ref NUMBER(8),     -- 참조번호
    step NUMBER(8),    -- 행번호
    depth NUMBER(8)    -- 깊이
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_POSTCOMMENT
START WITH 1
INCREMENT BY 1;