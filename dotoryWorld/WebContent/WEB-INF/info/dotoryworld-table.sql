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

CREATE TABLE dotorylist(
	dotory_id VARCHAR2(300) PRIMARY KEY,
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_dotorylist_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)

/*DROP TABLE dotorylist*/

CREATE TABLE photobook(
	photobook_no NUMBER PRIMARY KEY,
	photobook_url VARCHAR2(2000),
	id VARCHAR2(300) NOT NULL,
	CONSTRAINT FK_photobook_id FOREIGN KEY (id) REFERENCES member (id)
	ON DELETE CASCADE
)

CREATE SEQUENCE photobook_no_seq;

DROP TABLE photobook

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

CREATE SEQUENCE toryhome_no_seq
/* 시퀀스 검색*/
SELECT * FROM USER_SEQUENCES  
SELECT * FROM TAB;
/* ON DELETE CASCADE */ 


DROP TABLE member
DROP TABLE category
DROP TABLE hobbyboard
DROP TABLE hobby_post
DROP TABLE bookmark
DROP TABLE dotorylist
DROP TABLE photobook
DROP TABLE toryhome_board

