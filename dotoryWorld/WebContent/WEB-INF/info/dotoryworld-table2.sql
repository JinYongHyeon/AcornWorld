------------------------------------------------------------
---------------------------- 차례 ----------------------------

--line 24  ~ TABLE SELECT 모음
--line 37  ~ CREATE TABLE 모음
--line 157 ~ DROP TABLE 모음
--line 171 ~ DROP SEQUENCE 모음
--line 182 ~ SAMPLE DATA 모음
	--line 184 ~ id
	--line 209 ~ category
	--line 216 ~ category board
	--line 244 ~ 취미게시판 샘플데이터
	--line 294 ~ 공지게시판(17번 게시판) 샘플 데이터
	--line 298 ~ 신고게시판(18번 게시판) 샘플 데이터
	--line 306 ~ 내 도토리 목록 데이터
	--line 314 ~ 취미 게시판 대문 사진
	--line 336 ~ 카테고리 소개글
	--line 354 ~ 방명록 샘플 데이터
--line 369 ~ 사용하지 않는 테이블
--line 387 ~ 삭제된 테이블
--line 433 ~ 테이블 변경사항 (적용함)

------------------------------------------------------------
--------------------- TABLE SELECT 모음 ---------------------
SELECT * FROM tab -- 전체 테이블 조회
SELECT * FROM user_sequences; -- 전체 시퀀스 조회
SELECT * FROM member -- 회원/관리자 정보 테이블 조회
SELECT * FROM category -- 취미 카테고리(큰항목) 테이블 조회 (공지/신고 포함)
SELECT * FROM hobbyboard -- 취미 게시판(작은항목) 테이블 조회 (공지/신고 포함)
SELECT * FROM hobby_post -- 취미 게시판 커뮤니티글 테이블 조회 (공지/신고 게시글 포함)
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
drop SEQUENCE category_no_seq;

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
	CONSTRAINT FK_bookmark_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)

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
----------------------- DROP TABLE 모음 ----------------------
DROP TABLE member -- 회원/관리자 정보 테이블 삭제
DROP TABLE category -- 취미 카테고리(큰항목) 테이블 삭제 (공지/신고 포함)
DROP TABLE hobbyboard -- 취미 게시판(작은항목) 테이블 삭제 (공지/신고 포함)
DROP TABLE hobby_post -- 취미 게시판 커뮤니티글 테이블 삭제 (공지/신고 게시글 포함)
DROP TABLE hobbypostlike 
DROP TABLE dotorylist -- 친구리스트 정보 테이블 삭제
DROP TABLE bookmark -- 커뮤니티글/게시판 즐겨찾기 정보 테이블 삭제
DROP TABLE toryhome_board -- 개인 미니홈페이지(토리홈) 정보 테이블 삭제
DROP TABLE report_post -- 신고 게시물 테이블 삭제
DROP TABLE notice_post -- 공지 게시물 테이블 삭제
DROP TABLE photobook -- 사진첩 테이블 삭제
DROP TABLE hobbypostlike -- 좋아요 테이블 삭제

------------------------------------------------------------
--------------------- DROP SEQUENCE 모음 ---------------------
DROP SEQUENCE category_no_seq -- 취미 카테고리(큰항목) 테이블 시퀀스 삭제 (공지/신고 포함)
DROP SEQUENCE hobbyboard_no_seq -- 취미 게시판(작은항목) 테이블 시퀀스 삭제 (공지/신고 포함)
DROP SEQUENCE hobbypost_no_seq -- 취미 게시판 커뮤니티글 테이블 시퀀스 삭제 (공지/신고 게시글 포함)
DROP SEQUENCE bookmark_no_seq -- 친구리스트 정보 테이블 시퀀스 삭제
DROP SEQUENCE toryhome_no_seq -- 개인 미니홈페이지(토리홈) 정보 테이블 시퀀스 삭제
DROP SEQUENCE reportpost_no_seq -- 신고 게시물 테이블 시퀀스 삭제
DROP SEQUENCE noticepost_no_seq -- 공지 게시물 테이블 시퀀스 삭제
DROP SEQUENCE photobook_no_seq -- 사진첩 테이블 시퀀스 삭제

------------------------------------------------------------

insert into DOTORYLIST (dotory_id, id) values('gang','baebae');
insert into DOTORYLIST (dotory_id, id) values('quiett','baebae');
insert into DOTORYLIST (dotory_id, id) values('daewee','baebae');
insert into DOTORYLIST (dotory_id, id) values('jungwoo','baebae');
insert into DOTORYLIST (dotory_id, id) values('hellchang','baebae');

------------------------------------------------------------
---------------------- SAMPLE DATA 모음 ----------------------

-- id 
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('admin','1234','가짜개발자','판교','fake@gmail.com','가짜개발자','진짜가 되고 싶은 가짜','다람쥐');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('hellchang','1234','김행창','스포짐','2du@gmail.com','창헬','운동을 사랑하는 강한 남자.','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('chukku','1234','추국공','판교','chukku@gmail.com','축사모','내 드리블은 메시 급','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('badbad','1234','배민턱','서울','hamington@gmail.com','배해밍턴','날아올라..!','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('kimdudu','1234','제니','서울','jeni@gmail.com','빛이나는농구','슛볼은 나의친구','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('sorrykim','1234','안미해','광주','sorrykim@gmail.com','숄희숄희','반갑습니다^^~','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('quiett','1234','정재우','수원','quiett@gmail.com','정콰이엇','관리자에 의해 소개글이 삭제되었습니다.','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('gang','1234','정지윤','부천','gang@gmail.com','정깡','쉿! 조용히하세요.','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('daewee','1234','강희석','판교','daewee@gmail.com','강대위','헤헤... 헷..','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('baebae','1234','배율휘','판교','baebae@gmail.com','배배로','금주중','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('dragon','1234','진용현','용인','dragon@gmail.com','진드래곤','코딩, 너, 성공적','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('ddol','1234','강지훈','판교','ddol@gmail.com','강똘','카데고리가 어때서!','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('wool','1234','정예울','판교','wool@gmail.com','예울쓰','밀크 넘 귀여워','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('ssang','1234','강상훈','판교','ssang@gmail.com','샹훈','인생은 한방이지!','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('sungsik','1234','양성식','수원','sungsik@gmail.com','성식희','ㅋ','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('richi','1234','박세리','서울','richi@gmail.com','리치언니','예쁜 가을 하늘^^','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('jungwoo','1234','서정우','종로','jungwoo@gmail.com','코딩의신','원 인터페이스 멀티 임플리먼츠','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('june','1234','정준상','판교','june@gmail.com','준상씨','푸시푸시 베이비','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('sagi','1234','김사기','판교','sagi@gmail.com','사긱훈','사기치기 꿀잼','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('back','1234','백종원','서울','back@gmail.com','백종원','그러면 돼유 안돼유','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('sleep','1234','김숙면','서울','sleep@gmail.com','졸려죽어','zzZZZ','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('bang','1234','김방구','서울','bang@gmail.com','뿡뿡이','뿌앙','도토리');
INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES('star','1234','정별','용인','star@gmail.com','별로야','별로다진짜','도토리');

-- category
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'운동','운동설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'요리','요리설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'영화','요리설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'음악','음악설명');
INSERT INTO category(category_no,category_name,category_content) VALUES(category_no_seq.nextval,'공지/신고','공지/신고사항');

-- category1 board
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'축구',1);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'배드민턴',1);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'농구',1);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'야구',1);

-- category2 board
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'일식',2);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'양식',2);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'중식',2);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'한식',2);

-- category3 board
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'로맨스',3);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'스릴러',3);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'공포',3);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'액션',3);

-- category4 board
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'댄스',4);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'클래식',4);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'발라드',4);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'팝',4);

-- category5 board
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'공지',5);
INSERT INTO hobbyboard(hobbyboard_no,hobbyboard_title,category_no) VALUES(hobbyboard_no_seq.nextval,'신고',5);

-- 취미게시판 샘플데이터
-- category1 board1
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 축구 게시판입니다.','축구~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'chukku');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'세상에서 제일예쁜 예','축구~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'wool');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'저는 진짜 왕년에 슛돌이었어요','축구~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'jungwoo');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'지금 시간이 메시죠?','축구~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'dragon');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'야야야야야 길막지마 야','축구~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'sungsik');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'춤추고싶다갑자기','축구~~',TO_DATE(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),1,'quiett');

-- category1 board2
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 배드민턴 게시판입니다.','배드민턴~~',SYSDATE,2,'badbad');

-- category1 board3
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 농구 게시판입니다.','농구~~',SYSDATE,3,'hellchang');

-- category1 board4
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 야구 게시판입니다.','야구~~',SYSDATE,4,'kimdudu');

-- category2 board1
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 일식 게시판입니다.','일식~~',SYSDATE,5,'sorrykim');

-- category2 board2
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 양식 게시판입니다.','양식~~',SYSDATE,6,'quiett');

-- category2 board3
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 중식 게시판입니다.','중식~~',SYSDATE,7,'gang');

-- category2 board4
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 한식 게시판입니다.','한식~~',SYSDATE,8,'daewee');

-- category3 board1
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 로맨스 게시판입니다.','로맨스~~',SYSDATE,9,'baebae');

-- category3 board2
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 스릴러 게시판입니다.','스릴러~~',SYSDATE,10,'dragon');

-- category3 board3
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 공포 게시판입니다.','공포~~',SYSDATE,11,'ddol');

-- category3 board4
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 액션 게시판입니다.','액션~~',SYSDATE,12,'wool');

-- category4 board1
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 댄스 게시판입니다.','댄스~~',SYSDATE,13,'ssang');

-- category4 board2
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 클래식 게시판입니다.','클래식~~',SYSDATE,14,'sungsik');

-- category4 board3
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 발라드 게시판입니다.','발라드~~',SYSDATE,15,'richi');

-- category4 board4
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'여기는 팝 게시판입니다.','팝~~',SYSDATE,16,'jungwoo');

-- 공지게시판(17번 게시판) 샘플 데이터
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'이제 술안마시기로 한 배베로가 술마시는 모습을 목격하면 신고해주세요','공지',TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),17,'ddol');

-- 신고게시판(18번 게시판) 샘플 데이터

INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'어젯밤 술마시고 지각한 정깡을 신고합니다','신고',TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),18,'ddol');
INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id)
VALUES(hobbypost_no_seq.NEXTVAL,'11시까지 기능 구현을 완료하기로 거짓말한 정콰이엇을 신고합니다','신고',TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),18,'ddol');


-- 내 도토리 목록 데이터
INSERT INTO dotorylist VALUES('ddol','quiett');
INSERT INTO dotorylist VALUES('quiett','ddol');
INSERT INTO dotorylist VALUES('gang','ddol');
INSERT INTO dotorylist VALUES('daewee','ddol');
INSERT INTO dotorylist VALUES('baebae','ddol');
INSERT INTO dotorylist VALUES('dragon','ddol');

-- 취미 게시판 대문 사진
UPDATE hobbyboard SET hobbyboard_imgName = 'soccer.jpg' WHERE hobbyboard_no='1';
UPDATE hobbyboard SET hobbyboard_imgName = 'badminton.jpg' WHERE hobbyboard_no='2';
UPDATE hobbyboard SET hobbyboard_imgName = 'basketball.jpg' WHERE hobbyboard_no='3';
UPDATE hobbyboard SET hobbyboard_imgName = 'baseball.jpg' WHERE hobbyboard_no='4';

UPDATE hobbyboard SET hobbyboard_imgName = 'japan_food.jpg' WHERE hobbyboard_no='5';
UPDATE hobbyboard SET hobbyboard_imgName = 'italian_food.jpg' WHERE hobbyboard_no='6';
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


-- 카테고리 소개글
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

-- 방명록 샘플 데이터
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.', SYSDATE, 'ddol','quiett');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.user2', SYSDATE, 'quiett','ddol');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user2', SYSDATE, 'gang','ddol');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중입니다.user1', SYSDATE, 'daewee','ddol');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user4', SYSDATE, 'baebae','ddol');
INSERT INTO toryhome_board(toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id)
VALUES(toryhome_no_seq.nextval,'방명록','테스트 중user5', SYSDATE, 'dragon','ddol');


ALTER TABLE bookmark DROP COLUMN bookmark_title;
-------------------------------------------------------------
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

------------------------------------------------------------
