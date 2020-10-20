CREATE TABLE member(
	id VARCHAR2(300) PRIMARY KEY,
	password VARCHAR2(300) NOT NULL,
	name VARCHAR2(300) NOT NULL,
	address VARCHAR2(300) NOT NULL,
	email VARCHAR2(300) NOT NULL,
	nickname VARCHAR2(300) NOT NULL,
	profile_photo VARCHAR2(300), /* NULL 설정 */
	profile_content VARCHAR2(300) NOT NULL,
	grade VARCHAR2(300)	NOT NULL
)

select * from tab
select * from member
delete from member where password='a';

CREATE TABLE category(
	category_no NUMBER PRIMARY KEY,
	category_name VARCHAR2(300) NOT NULL
)


CREATE SEQUENCE category_no_seq;

CREATE TABLE hobbyboard(
	hobbyboard_no NUMBER PRIMARY KEY,
	hobbyboard_title VARCHAR2(300) NOT NULL,
	hobbyboard_content CLOB NOT NULL,
	hobbyboard_like NUMBER NOT NULL,
	category_no NUMBER NOT NULL,
	CONSTRAINT FK_hobbyboard_category_no FOREIGN KEY (category_no) REFERENCES category (category_no)
	ON DELETE CASCADE
)

CREATE SEQUENCE hobbyboard_no_seq;

CREATE TABLE hobby_post(
	hobbypost_no NUMBER PRIMARY KEY,
	hobby_title VARCHAR2(300) NOT NULL,
	hobby_content CLOB NOT NULL, 
	hobbypost_date DATE NOT NULL,
	hobby_like NUMBER NOT NULL,
	hobbypost_viewcount NUMBER NOT NULL,
	hobbyboard_no NUMBER NOT NULL,
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_hobby_post_id FOREIGN KEY (id) REFERENCES member (id) 	ON DELETE CASCADE,
	CONSTRAINT FK_hobby_post_hobbyboard_no FOREIGN KEY (hobbyboard_no) REFERENCES hobbyboard (hobbyboard_no)
	ON DELETE CASCADE
)

SELECT * FROM hobby_post

CREATE SEQUENCE hobbypost_no_seq;

CREATE TABLE bookmark(
	bookmark_no NUMBER PRIMARY KEY,
	link VARCHAR2(2000) NOT NULL,
	bookmark_divide VARCHAR2(300) NOT NULL,
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_bookmark_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)

CREATE SEQUENCE bookmark_no_seq;
	
	--20년10월20일[id 까지 PK 복합키로 설정]
CREATE TABLE dotorylist(
	dotory_id VARCHAR2(300),
	id VARCHAR2(300),
	CONSTRAINT PK_dotorylist PRIMARY KEY (dotory_id,id),
	CONSTRAINT FK_dotorylist_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)

DROP TABLE dotorylist

CREATE TABLE photobook(
	photobook_no NUMBER PRIMARY KEY,
	photobook_url VARCHAR2(2000),
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_photobook_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)

CREATE SEQUENCE photobook_no_seq;


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

/* 신고게시판 게시물 테이블 */
CREATE TABLE report_post(
	reportpost_no NUMBER PRIMARY KEY,
	report_title VARCHAR2(300) NOT NULL,
	report_content CLOB NOT NULL, 
	reportpost_date DATE NOT NULL,
	category_no NUMBER NOT NULL,
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_report_post_id FOREIGN KEY (id) REFERENCES member (id),
	CONSTRAINT FK_report_post_category_no FOREIGN KEY (category_no) REFERENCES category (category_no)
	ON DELETE CASCADE
)
CREATE SEQUENCE reportpost_no_seq NOCACHE;

CREATE SEQUENCE toryhome_no_seq

--게시물 좋아요 테이블
CREATE TABLE hobbypostlike(
	ID VARCHAR2(400),
	HOBBYPOST_NO NUMBER,
	CONSTRAINT pk_hobbypostlike PRIMARY KEY(id,hobbypost_no),
	CONSTRAINT fk_hobbypostlike_id FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE,
	CONSTRAINT fk_hobbypostlike_no FOREIGN KEY(hobbypost_no) REFERENCES hobby_post(hobbypost_no) ON DELETE CASCADE
)




/* 시퀀스 검색*/
SELECT * FROM USER_SEQUENCES;
SELECT * FROM TAB;
/* ON DELETE CASCADE */ 

--삭제 테이블
DROP TABLE member
DROP TABLE category
DROP TABLE hobbyboard
DROP TABLE hobby_post
DROP TABLE bookmark
DROP TABLE dotorylist
DROP TABLE photobook
DROP TABLE toryhome_board

--삭제 시퀀스
DROP SEQUENCE bookmark_no_seq
DROP SEQUENCE category_no_seq 
DROP SEQUENCE hobbyboard_no_seq
DROP SEQUENCE hobbypost_no_seq
DROP SEQUENCE photobook_no_seq
DROP SEQUENCE toryhome_no_seq


--캐쉬 기능 비활성화(비정상 종료 방지)
ALTER SEQUENCE bookmark_no_seq NOCACHE;
ALTER SEQUENCE category_no_seq NOCACHE;
ALTER SEQUENCE hobbyboard_no_seq NOCACHE;
ALTER SEQUENCE hobbypost_no_seq NOCACHE;
ALTER SEQUENCE photobook_no_seq NOCACHE;
ALTER SEQUENCE toryhome_no_seq NOCACHE;

--테이블 변경사항

--카테고리 소개글 생김
ALTER TABLE category ADD(category_content CLOB NOT NULL); 

--게시판에 좋아요 기본 0 설정, 게시판 소개글 삭제
ALTER TABLE hobbyboard MODIFY(hobbyboard_like DEFAULT 0);
ALTER TABLE hobbyboard DROP COLUMN hobbyboard_content;

--게시글 좋아요 기본 0 설정, 게시글 조회수 기본 0 설정
ALTER TABLE hobby_post MODIFY(hobby_like DEFAULT 0);
ALTER TABLE hobby_post MODIFY(hobbypost_viewcount DEFAULT 0);

--작은항목 이미지 URL 주소 컬럼 추가
ALTER TABLE HOBBYBOARD ADD(hobbyboard_imgName VARCHAR2(500))

UPDATE category SET category_content='운동'||CHR(13)||'설명' where category_name = '운동'

select * from category

--샘플 데이터
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
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'음악','요리설명');

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
INSERT INTO report_post(reportpost_no,report_title,report_content,reportpost_date,category_no,id)
VALUES(reportpost_no_seq.NEXTVAL,'메시는 메시다..','메시~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),3,'user4');

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
INSERT INTO toryhome_board(toryhome_no, toryhome_title,
toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.',
SYSDATE, 'user1','user4');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.user2', SYSDATE, 'user2','user4');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user2', SYSDATE, 'user2','user3');

delete from TORYHOME_BOARD where id='';

SELECT toryhome_no, toryhome_title,
toryhome_content, 
to_char(toryhome_date, 'YYYY-MM-DD HH24:MI:SS'),
id_writer, id FROM toryhome_board;

--북마크 샘플
INSERT INTO bookmark(bookmark_no,link,bookmark_divide,id) VALUES(bookmark_no_seq.NEXTVAL,'56','북마크','user1');

SELECT * FROM bookmark



