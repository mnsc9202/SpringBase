-- ******************** POST ********************
--테이블 삭제 (POST)
DROP TABLE POST;

--테이블 생성 (POST)
CREATE TABLE POST(
    seq NUMBER(8) PRIMARY KEY,          -- 게시글 번호 (기본키 지정)
    boardNo NUMBER(8) NOT NULL,         -- 게시판 번호
    writer VARCHAR2(50) NOT NULL,       -- 작성자
    title VARCHAR2(200) NOT NULL,       -- 제목
    content VARCHAR2(4000) NOT NULL,    -- 내용
    createdDate DATE NOT NULL,          -- 작성일
    modifiedDate DATE,                  -- 수정일
    deleteAt NUMBER(1) NOT NULL,        -- 삭제여부 (0: false, 1: true)
    readCount NUMBER(8) NOT NULL        -- 조회수
);

--시퀀스 생성
CREATE SEQUENCE SEQ_POST
START WITH 1
INCREMENT BY 1;