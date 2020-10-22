------------------------------------------------------------
---------------------------- 차례 ----------------------------



------------------------------------------------------------
--------------------- TABLE SELECT 모음 ---------------------
SELECT * FROM tab -- 전체 테이블 조회
SELECT * FROM user_sequences; -- 전체 시퀀스 조회
SELECT * FROM member -- 회원/관리자 정보 테이블 조회
SELECT * FROM category -- 취미 카테고리(큰항목) 테이블 조회 (공지/신고 포함)
SELECT * FROM hobbyboard -- 취미 게시판(작은항목) 테이블 조회 (공지/신고 포함)
SELECT * FROM hobbypost -- 취미 게시판 커뮤니티글 테이블 조회 (공지/신고 게시글 포함)
SELECT * FROM dotorylist -- 친구리스트 정보 테이블 조회
SELECT * FROM bookmark -- 커뮤니티글/게시판 즐겨찾기 정보 테이블 조회
SELECT * FROM toryhome_board -- 개인 미니홈페이지(토리홈) 정보 테이블 조회
SELECT * FROM hobbypostlike -- 커뮤니티글 좋아요 정보 테이블 조회

------------------------------------------------------------
---------------------- CREATE TABLE 모음 ---------------------
-- 도토리, 다람쥐 정보 관리 테이블 생성
CREATE TABLE member(
	id VARCHAR2(300) PRIMARY KEY,
	password VARCHAR2(300) NOT NULL,
	name VARCHAR2(300) NOT NULL,
	address VARCHAR2(300) NOT NULL,
	email VARCHAR2(300) NOT NULL,
	nickname VARCHAR2(300) NOT NULL,
	profile_photo VARCHAR2(300), /* NOT NULL 설정 -> NULL 설정으로 변경함  */
	profile_content VARCHAR2(300) NOT NULL,
	grade VARCHAR2(300)	NOT NULL
)
-- 1차 기획에서 profile_photo 요소에 대해 NOT NULL을 부여함.
-- 하지만 프로필 사진을 업로드 하는 기능을 회원 가입시에는 제공하지 않으므로
-- NOT NULL을 부여할 경우 회원 가입기능 구현에 장애가 발생하는 것을 확인함.
-- 이에 NULL로 설정을 변경하였으며 해당 요소가 NULL일 경우 기본 프로필 사진이
-- 화면에 노출되도록 설정함. 

-- 취미 카테고리(큰항목) 테이블 생성 (공지/신고 포함)
CREATE TABLE category(
	category_no NUMBER PRIMARY KEY,
	category_name VARCHAR2(300) NOT NULL,
	category_content CLOB NOT NULL /* 추가 */
)
-- 1차 기획에서 category_content CLOB NOT NULL을 설정하지 않음.
-- 기능 구헌중 카테고리에 대한 소개글이 필요하게 되어 추가함.

-- 취미 카테고리 테이블 category_no 시퀀스 생성 (비정상 종료로 인해 시퀀스가 증가하는 것을 방지하기 위해 NOCACHE 추가)
CREATE SEQUENCE category_no_seq NOCACHE;

-- 취미 게시판(작은항목) 테이블 생성 (공지/신고 포함)
CREATE TABLE hobbyboard(
	hobbyboard_no NUMBER PRIMARY KEY,
	hobbyboard_title VARCHAR2(300) NOT NULL,
	category_no NUMBER NOT NULL,
	hobbyboard_imgName VARCHAR2(500), /* 추가 */
	CONSTRAINT FK_hobbyboard_category_no FOREIGN KEY (category_no) REFERENCES category (category_no)
	ON DELETE CASCADE /* 비설정 -> 설정 */
)
-- 1차 기획에서 ON DELETE CASCADE 부여하지 않음. 기능 구현중 추가함.
-- hobbyboard_content CLOB NOT NULL, 삭제  (2차 기획에서 취미 게시판 대신 상위 테이블인 카테고리 테이블에
-- 소개글 기능을 넣기고 하고 이에 해당하는 category_content 요소를 카테고리 테이블에 추가함)
-- hobbyboard_like DEFAULT 0, 삭제 (2차 기획에서 좋아요 기능의 특성상 기본 값이 0이므로 2차기획에서 DEFAULT 0으로 수정하기로 하였다가
-- 취미 게시판의 좋아요 기능을 삭제하고 즐겨찾기 기능만 유지하기로 함.)
-- 2차 기획에서 취미 게시판(작은항목)의 대문 이미지를 넣기로 하면서 hobbyboard_imgName VARCHAR2(500)를 추가함.

-- 취미 게시판 테이블 hobbyboard_no 시퀀스 생성 (비정상 종료로 인해 시퀀스가 증가하는 것을 방지하기 위해 NOCACHE 추가)
CREATE SEQUENCE hobbyboard_no_seq NOCACHE;

-- 취미 게시판 커뮤니티글 테이블 테이블 생성 (공지/신고 게시글 포함)
CREATE TABLE hobby_post(
	hobbypost_no NUMBER PRIMARY KEY,
	hobby_title VARCHAR2(300) NOT NULL,
	hobby_content CLOB NOT NULL, 
	hobbypost_date DATE NOT NULL,
	hobby_like NUMBER DEFAULT 0, /* NOT NULL -> DEFAULT 0 */
	hobbypost_viewcount NUMBER DEFAULT 0, /* NOT NULL -> DEFAULT 0 */
	hobbyboard_no NUMBER NOT NULL,
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_hobby_post_id FOREIGN KEY (id) REFERENCES member (id) 	ON DELETE CASCADE,
	CONSTRAINT FK_hobby_post_hobbyboard_no FOREIGN KEY (hobbyboard_no) REFERENCES hobbyboard (hobbyboard_no)
	ON DELETE CASCADE /* 비설정 -> 설정 */
)
-- 1차 기획에서 ON DELETE CASCADE 부여하지 않음. 기능 구현중 추가함.
-- 1차 기획에서 hobby_like를 NOT NULL로 설정하였으나 좋아요 기능의 특성상 기본 값이 0이므로 2차기획에서 DEFAULT 0으로 수정함.
-- 2차 기획에서 좋아요 기능의 특성상 기본 값이 0이므로 2차기획에서 DEFAULT 0으로 수정함.

-- 취미 게시판 커뮤니티글 테이블 hobbypost_no 시퀀스 생성 (비정상 종료로 인해 시퀀스가 증가하는 것을 방지하기 위해 NOCACHE 추가)
CREATE SEQUENCE hobbypost_no_seq NOCACHE;

-- 친구리스트 정보 테이블 생성
CREATE TABLE dotorylist(
	dotory_id VARCHAR2(300),
	id VARCHAR2(300),
	CONSTRAINT PK_dotorylist PRIMARY KEY (dotory_id,id),
	CONSTRAINT FK_dotorylist_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)
--20년10월20일[id 까지 PK 복합키로 설정]


-- 커뮤니티글/게시판 즐겨찾기 정보 테이블 생성
CREATE TABLE bookmark(
	bookmark_no NUMBER PRIMARY KEY,
	link VARCHAR2(2000) NOT NULL,
	bookmark_divide VARCHAR2(300) NOT NULL,
	id VARCHAR2(300) NOT NULL,
	bookmark_title VARCHAR2(300)NOT NULL, /* 추가 */
	CONSTRAINT FK_bookmark_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)
-- 커뮤니티글 즐겨찾기(북마크)와 게시판 즐겨찾기(즐겨찾기) 를 한 테이블에서 구분하기 위해 추가함.

-- 커뮤니티글/게시판 즐겨찾기 정보 테이블 bookmark_no 시퀀스 생성 (비정상 종료로 인해 시퀀스가 증가하는 것을 방지하기 위해 NOCACHE 추가)
CREATE SEQUENCE bookmark_no_seq NOCACHE;

-- 개인 미니홈페이지(토리홈) 정보 테이블 생성
CREATE TABLE toryhome_board(
	toryhome_no NUMBER PRIMARY KEY,
	toryhome_title VARCHAR2(300) NOT NULL,
	toryhome_content CLOB NOT NULL,
	toryhome_date DATE NOT NULL,
	id_writer VARCHAR2(300) NOT NULL,
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_toryhome_board_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)

-- 개인 미니홈페이지(토리홈) 정보 테이블 toryhome_no 시퀀스 생성 (비정상 종료로 인해 시퀀스가 증가하는 것을 방지하기 위해 NOCACHE 추가)
CREATE SEQUENCE toryhome_no_seq NOCACHE;

-- 커뮤니티글 좋아요 테이블 (2차 기획에서 추가함)
CREATE TABLE hobbypostlike(
	ID VARCHAR2(400),
	HOBBYPOST_NO NUMBER,
	CONSTRAINT pk_hobbypostlike PRIMARY KEY(id,hobbypost_no),
	CONSTRAINT fk_hobbypostlike_id FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE,
	CONSTRAINT fk_hobbypostlike_no FOREIGN KEY(hobbypost_no) REFERENCES hobby_post(hobbypost_no) ON DELETE CASCADE
)
-- 2차 구현 대상인 커뮤니티글 좋아요 기능을 구현하기로 2차 기획에서 결정하면서 추가로 생성함.
------------------------------------------------------------
-------------------------- 테이블 삭제 -------------------------
DROP TABLE member -- 회원/관리자 정보 테이블 삭제
DROP TABLE category -- 취미 카테고리(큰항목) 테이블 삭제 (공지/신고 포함)
DROP TABLE hobbyboard -- 취미 게시판(작은항목) 테이블 삭제 (공지/신고 포함)
DROP TABLE hobby_post -- 취미 게시판 커뮤니티글 테이블 삭제 (공지/신고 게시글 포함)
DROP TABLE dotorylist -- 친구리스트 정보 테이블 삭제
DROP TABLE bookmark -- 커뮤니티글/게시판 즐겨찾기 정보 테이블 삭제
DROP TABLE toryhome_board -- 개인 미니홈페이지(토리홈) 정보 테이블 삭제
DROP TABLE report_post -- 신고 게시물 테이블 삭제
DROP TABLE notice_post -- 공지 게시물 테이블 삭제
DROP TABLE photobook -- 사진첩 테이블 삭제
------------------------------------------------------------
-------------------------- 시퀀스 삭제 -------------------------
DROP SEQUENCE category_no_seq -- 취미 카테고리(큰항목) 테이블 시퀀스 삭제 (공지/신고 포함)
DROP SEQUENCE hobbyboard_no_seq -- 취미 게시판(작은항목) 테이블 시퀀스 삭제 (공지/신고 포함)
DROP SEQUENCE hobbypost_no_seq -- 취미 게시판 커뮤니티글 테이블 시퀀스 삭제 (공지/신고 게시글 포함)
DROP SEQUENCE bookmark_no_seq -- 친구리스트 정보 테이블 시퀀스 삭제
DROP SEQUENCE toryhome_no_seq -- 개인 미니홈페이지(토리홈) 정보 테이블 시퀀스 삭제
DROP SEQUENCE reportpost_no_seq -- 신고 게시물 테이블 시퀀스 삭제
DROP SEQUENCE noticepost_no_seq -- 공지 게시물 테이블 시퀀스 삭제
DROP SEQUENCE photobook_no_seq -- 사진첩 테이블 시퀀스 삭제

------------------------------------------------------------
----------------------- 사용하지 않는 테이블 -----------------------
-- 개인 미니홈페이지 사진첩 테이블 생성(3차 구현에 해당하는 사진첩 기능을 구현하지 않아 사용하지 않음.)
/* 
 *	CREATE TABLE photobook(
 *		photobook_no NUMBER PRIMARY KEY,
 *		photobook_url VARCHAR2(2000),
 *		id VARCHAR2(300) NOT NULL,
 *		CONSTRAINT FK_photobook_id FOREIGN KEY (id) REFERENCES member (id)
 *		ON DELETE CASCADE
 *	)
 */

-- 개인 미니홈페이지 사진첩 테이블 photobook_no 시퀀스 생성 
/*
 *	CREATE SEQUENCE photobook_no_seq NOCACHE;
 */

------------------------------------------------------------
------------------------- 삭제된 테이블 -------------------------

-- 신고게시판 게시물 테이블 생성(취미 카테고리(큰항목) 테이블 하위에 바로 게시물 테이블을 만들어 사용하려고 하였으나
-- 취미(일반) 게시판과 일원화 하면서  테이블을 삭제함.)
/*
 *	CREATE TABLE report_post(
 *		reportpost_no NUMBER PRIMARY KEY,
 *		report_title VARCHAR2(300) NOT NULL,
 *		report_content CLOB NOT NULL, 
 *		reportpost_date DATE NOT NULL,
 *		category_no NUMBER NOT NULL,
 *		id VARCHAR2(300) NOT NULL,
 *		CONSTRAINT FK_report_post_id FOREIGN KEY (id) REFERENCES member (id),
 *		CONSTRAINT FK_report_post_category_no FOREIGN KEY (category_no) REFERENCES category (category_no)
 *		ON DELETE CASCADE
 *	)
 */	

-- 신고게시판 게시물 테이블 reportpost_no 시퀀스 생성
/*
 *	CREATE SEQUENCE reportpost_no_seq NOCACHE;
 */

-- 공지게시판 게시물 테이블 생성(취미 카테고리(큰항목) 테이블 하위에 바로 게시물 테이블을 만들어 사용하려고 하였으나
-- 취미(일반) 게시판과 일원화 하면서  테이블을 삭제함.)
/*
 *	CREATE TABLE notice_post(
 *		noticepost_no NUMBER PRIMARY KEY,
 *		notice_title VARCHAR2(300) NOT NULL,
 *		notice_content CLOB NOT NULL, 
 *		noticepost_date DATE NOT NULL,
 *		notice_like NUMBER DEFAULT 0, /* NOT NULL -> DEFAULT 0 */
 *		category_no NUMBER NOT NULL,
 *		id VARCHAR2(300) NOT NULL,
 *		CONSTRAINT FK_notice_post_id FOREIGN KEY (id) REFERENCES member (id),
 *		CONSTRAINT FK_notice_post_category_no FOREIGN KEY (category_no) REFERENCES category (category_no)
 *		ON DELETE CASCADE
 *	)
 */

-- 공지게시판 게시물 테이블 noticepost_no 시퀀스 생성
/*
 * 	CREATE SEQUENCE noticepost_no_seq NOCACHE;
 */

------------------------------------------------------------
--------------------- 테이블 변경사항 (적용함) ---------------------
--카테고리 소개글 생김
/*
 *	ALTER TABLE category ADD(category_content CLOB NOT NULL); --
 */

--게시판에 좋아요 기본 0 설정, 게시판 소개글 삭제
/*
 *	ALTER TABLE hobbyboard MODIFY(hobbyboard_like DEFAULT 0);
 *	ALTER TABLE hobbyboard DROP COLUMN hobbyboard_content;
 */

--게시판 좋아요 삭제
/*
 *	ALTER TABLE hobbyboard DROP COLUMN hobbyboard_like;
 */

--게시글 좋아요 기본 0 설정, 게시글 조회수 기본 0 설정
/*
 *	ALTER TABLE hobby_post MODIFY(hobby_like DEFAULT 0);
 *	ALTER TABLE hobby_post MODIFY(hobbypost_viewcount DEFAULT 0);
 */

--작은항목 이미지 URL 주소 컬럼 추가
/*
 *	ALTER TABLE HOBBYBOARD ADD(hobbyboard_imgName VARCHAR2(500));
 */

--북마크 제목 추가
/*
 *	ALTER TABLE bookmark ADD(bookmark_title VARCHAR2(300)NOT NULL);
 */

------------------------------------------------------------
--------------------- 샘플 데이터 ---------------------

INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('admin','1234','관리자','판교','admin@gmail.com','다람쥐','관리자입니다','다람쥐');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('user1','1234','사용자1','판교','user1@gmail.com','도토리1','도토리1입니다','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('user2','1234','사용자2','판교','user2@gmail.com','도토리2','도토리2입니다','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('user3','1234','사용자3','판교','user3@gmail.com','도토리3','도토리3입니다','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('user4','1234','사용자4','판교','user4@gmail.com','도토리4','도토리4입니다','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('user5','1234','꽈꽈','북극','user5@gmail.com','도토리5','도토리5입니다','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('user6','1234','꾸꾸','남극','user6@gmail.com','도토리6','도토리6입니다','도토리');

INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'운동','운동설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'요리','요리설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'영화','요리설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'음악','음악설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'공지/신고','공지/신고사항');


INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'축구',1);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'배드민턴',1);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'농구',1);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'야구',1);

INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'일식',2);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'양식',2);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'중식',2);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'한식',2);

INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'로맨스',3);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'스릴러',3);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'공포',3);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'액션',3);

INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'댄스',4);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'클래식',4);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'발라드',4);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'팝',4);

INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'공지',5);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'신고',5);

-- 취미게시판 샘플데이터
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'메시는 메시다..','메시~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'user4');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'네이마르는 네이마르다..','네이마르~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'user3');

INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'고구마는 고구마..','고구마',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'user3');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'고구마는 고구마..','고구마',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'user3');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'고구마는 고구마..','고구마',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'user3');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'고구마는 고구마..','고구마',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'user3');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'고구마는 고구마..','고구마',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'user3');

/* 신고게시판 샘플 데이터 */
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'어젯밤 술마시고 지각한 정깡을 신고합니다','신고',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),18,'user3');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'11시까지 기능 구현을 완료하기로 거짓말한 정콰이엇을 신고합니다','신고',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),18,'user3');

-- 공지게시판 샘플 데이터
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'이제 술안마시기로 한 배베로가 술마시는 모습을 목격하면 신고해주세요','공지',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),17,'user3');

-- 내 도토리 목록 데이터
INSERT INTO dotorylist VALUES('user2','user1');
INSERT INTO dotorylist VALUES('user3','user1');
INSERT INTO dotorylist VALUES('user4','user1');
INSERT INTO dotorylist VALUES('user5','user1');
INSERT INTO dotorylist VALUES('user6','user1');

SELECT ROW_NUMBER() OVER(ORDER BY hobbyboard_no ASC),hobbyboard_title from HOBBYBOARD WHERE category_no = ?;

UPDATE hobbyboard SET hobbyboard_imgName = 'soccer.jpg' WHERE hobbyboard_no='1';
UPDATE hobbyboard SET hobbyboard_imgName = 'badminton.jpg' WHERE hobbyboard_no='2';
UPDATE hobbyboard SET hobbyboard_imgName = 'basketball.jpg' WHERE hobbyboard_no='5';
UPDATE hobbyboard SET hobbyboard_imgName = 'baseball.jpg' WHERE hobbyboard_no='6';

UPDATE hobbyboard SET hobbyboard_imgName = 'japan_food.jpg' WHERE hobbyboard_no='3';
UPDATE hobbyboard SET hobbyboard_imgName = 'italian_food.jpg' WHERE hobbyboard_no='4';
UPDATE hobbyboard SET hobbyboard_imgName = 'chinese_food.jpg' WHERE hobbyboard_no='7';
UPDATE hobbyboard SET hobbyboard_imgName = 'korea_food.jpg' WHERE hobbyboard_no='8';

UPDATE hobbyboard SET hobbyboard_imgName = 'romance.jpg' WHERE hobbyboard_no='9';
UPDATE hobbyboard SET hobbyboard_imgName = 'thriller.jpg' WHERE hobbyboard_no='10';
UPDATE hobbyboard SET hobbyboard_imgName = 'horror.jpg' WHERE hobbyboard_no='11';
UPDATE hobbyboard SET hobbyboard_imgName = 'action.jpg' WHERE hobbyboard_no='12';

UPDATE hobbyboard SET hobbyboard_imgName = 'dance.jpg' WHERE hobbyboard_no='13';
UPDATE hobbyboard SET hobbyboard_imgName = 'classic.jpg' WHERE hobbyboard_no='14';
UPDATE hobbyboard SET hobbyboard_imgName = 'ballad.png' WHERE hobbyboard_no='15';
UPDATE hobbyboard SET hobbyboard_imgName = 'pop.jpg' WHERE hobbyboard_no='16';

UPDATE category SET category_content = '<h3><b>SPORTS</b></h3><BR> 
<b>You have to exercise, or at some point you will just break down.</b> <BR>
<b>Reading is to the mind what exercise is to the body. </b><BR>
<b>The reason I exercise is for the quality of life I enjoy. </b>' WHERE category_no='1';
UPDATE category SET category_content = '<h3><b>COOKING</b></h3><BR> 
<b>Good food ends with good talk.</b><BR>
<b>There aint no such thing as wrong food.</b><BR>
<b>Food is the most primitive form of comfort.</b> <BR>' WHERE category_no='2';
UPDATE category SET category_content = '<h3><b>MOVIE</b></h3><BR> 
<b>You can never replace anyone, because everyone is made up of such beautiful specific details.</b><BR>
<b>You either die a hero or you live long enough to see yourself become the villain.</b><BR>
<b>Life is like a box of chocolates, You never know what you are gonna get.</b><BR>' WHERE category_no='3';
UPDATE category SET category_content = '<h3><b>MUSIC</b></h3><BR>
<b>Dont need make-up to cover up. Being the way that you are is enough.</b><BR>
<b>Dont hide yourself in regret. Just love yourself and you are set.</b><BR>
<b>A heart thats broke is a heart thats been loved.</b> <BR>' WHERE category_no='4';

update category set category_name='공지/신고' where category_no='5'
select * from category

INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'요리','요리설명');


select * from category;
select * from HOBBYBOARD;


delete from member where password='123'
select * from dotorylist;

delete from member where id='user5'
select * from member;

select * from hobby_post;
select count(*) from hobby_post;

SELECT * FROM hobbypostlike WHERE id='user1' AND hobbypost_no=55

select hobbypost_no,hobby_title,id,hobbypost_date,hobbypost_viewcount from(
select row_number() over(order by hobbypost_no asc) as rnum, hobbypost_no,hobby_title,id,hobbypost_date,hobbypost_viewcount from hobby_post )
where rnum between 1 and 2 ;

select id from DOTORYLIST d;


--친구목록 리스트
SELECT d.dotory_id,m.name FROM dotorylist d, member m WHERE m.id = d.dotory_id AND d.id= 'user1';




-- 방명록 테스트
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.', SYSDATE, 'user1','user4');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.user2', SYSDATE, 'user2','user4');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user2', SYSDATE, 'user2','user3');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.user1', SYSDATE, 'user1','user4');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user4', SYSDATE, 'user4','user3');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user5', SYSDATE, 'user5','user3');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user5', SYSDATE, 'user5','user4');

SELECT toryhome_title, toryhome_content, to_char(toryhome_date, 'YYYY-MM-DD HH24:MI:SS'), id_writer, id
FROM toryhome_board;



ROW_NUMBER() OVER(ORDER BY ) row_num

SELECT toryhome_no, toryhome_title, toryhome_content,   FROM TORYHOME_BOARD

SELECT ROW_NUMBER() OVER(ORDER BY toryhome_no DESC) as rnum
,toryhome_no,TO_CHAR(toryhome_date, 'YYYY-MM-DD HH24:MI:SS')
FROM TORYHOME_BOARD
WHERE ID = 'user4'

SELECT *
FROM (SELECT ROW_NUMBER() OVER(ORDER BY toryhome_no DESC) as rnum
,toryhome_no,TO_CHAR(toryhome_date, 'YYYY-MM-DD HH24:MI:SS')
FROM TORYHOME_BOARD
WHERE ID = 'user4')
WHERE rnum BETWEEN 1 AND 3

SELECT * FROM TORYHOME_BOARD
WHERE TO_CHAR(toryhome_date, 'YYYY-MM-DD HH24:MI:SS')='2020-10-21 10:45:51';

delete from TORYHOME_BOARD
where id_writer='user2' and id='user4' and TO_CHAR(toryhome_date, 'YYYY-MM-DD HH24:MI:SS')='2020-10-21 10:45:51';

SELECT COUNT(*) FROM TORYHOME_BOARD WHERE id='user4';

--북마크 페이징 쿼리문
SELECT no,b.link,h.hobby_title,h.id,ho.hobbyboard_title FROM(
SELECT ROW_NUMBER() OVER(ORDER BY bookmark_no ASC) as no,link FROM bookmark
WHERE id= 'user1' AND bookmark_divide = '북마크')b,hobby_post h,hobbyboard ho
WHERE b.link =h.hobbypost_no AND h.hobbyboard_no = ho.hobbyboard_no AND no BETWEEN 1 AND 20
ORDER BY no ASC

--핫 리스트 쿼리문
SELECT H.RNUM,H.HOBBYBOARD_NO,hb.hobbyboard_imgName,hb.hobbyboard_title FROM(
	SELECT ROW_NUMBER() OVER(ORDER BY HOBBY_LIKE DESC) AS rnum, HOBBYBOARD_NO  FROM (
	SELECT HOBBYBOARD_NO,SUM(HOBBY_LIKE) AS HOBBY_LIKE,SUM(hobbypost_viewcount) FROM HOBBY_POST GROUP BY HOBBYBOARD_NO
))h,HOBBYBOARD hb WHERE h.HOBBYBOARD_NO = hb.HOBBYBOARD_NO AND RNUM<=2

--베스트 쿼리문
SELECT H.RNUM,H.HOBBYBOARD_NO,hb.hobbyboard_imgName,hb.hobbyboard_title FROM(
	SELECT ROW_NUMBER() OVER(ORDER BY hobbypost_viewcount DESC) AS rnum, HOBBYBOARD_NO  FROM (
	SELECT HOBBYBOARD_NO,SUM(HOBBY_LIKE) AS HOBBY_LIKE,SUM(hobbypost_viewcount) AS hobbypost_viewcount FROM HOBBY_POST GROUP BY HOBBYBOARD_NO
))h,HOBBYBOARD hb WHERE h.HOBBYBOARD_NO = hb.HOBBYBOARD_NO AND RNUM<=2




SELECT b.rnum, b.LINK,b.ID,h.hobbyboard_title,h.hobbyboard_imgName 
FROM(SELECT ROW_NUMBER() OVER(ORDER BY bookmark_no ASC) AS rnum,link,id FROM bookmark 
WHERE bookmark_divide='즐겨찾기' AND id='user1')b,hobbyboard h 
WHERE h.hobbyboard_no = b.link AND b.rnum BETWEEN 2 AND 3;



