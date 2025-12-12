show databases;

drop database sunbeam;

create database Sunbeam_Project;

use Sunbeam_Project;

create table users(
   email VARCHAR(30) NOT NULL PRIMARY KEY,
   password VARCHAR(15) NOT NULL,
   roles enum('student','Admin') NOT NULL
);

create table Courses(
  course_id int NOT NULL PRIMARY KEY auto_increment,
  course_name VARCHAR(30) NOT NULL,
  descrip VARCHAR(60),
  fees INT NOT NULL,
  start_date date not null,
  end_date date not null,
  video_expire_days int not null

);

INSERT INTO Courses values
(100,'maths','algebra,MCS maths',1000,'2025-09-10','2025-10-10',30),
(200,'C lang',' ',2000,'2025-05-10','2025-06-10',30),
(201,'C++',' ',4000,'2025-08-10','2025-09-10',30),
(202,'Java',' ',5000,'2025-04-01','2025-05-01',30),
(203,'Web Programming',' ',5500,'2025-03-10','2025-04-10',30);

INSERT INTO Courses values
(400,'MERN','full stack',5000,'2026-01-10','2026-03-10',25),
(401,'Data science',' ',4000,'2026-02-10','2026-03-10',20),
(405,'Machine learning + DS','combo course',8000,'2026-02-10','2026-04-10',35);

create table Students(
 reg_no INT primary KEY NOT NULL,
 s_name varchar(40) not null,
 email VARCHAR(30) NOT NULL,
 course_id int NOT NULL,
 mobile_no INT NOT NULL,
 profile_pic blob,
 
 
 CONSTRAINT fk_mail
 FOREIGN KEY (email)
  REFERENCES Users(email)
  ON UPDATE CASCADE 
  ON DELETE CASCADE,
  
  
  constraint fk_cid
     foreign key (course_id)
     references Courses(course_id)
     ON DELETE CASCADE
	 ON UPDATE CASCADE
  
);


insert into Students values
(1001,"ash","ash04@mail.com",201,1568422,'');


insert into Students values
(1002,"manali","Manali@mail.com",203,876794,''),
(1008,"Jia","jia12@mail.com",203,56744,''),
(1006,"sheero","sheero@mail.com",201,156094,'')
;




create table videos(
video_id int PRIMARY KEY,
course_id int NOT NULL,
title VARCHAR(20),
descrip VARCHAR(60),
youtube_url VARCHAR(50),
added_at date,

constraint fk_cid2
     foreign key (course_id)
     references Courses(course_id)
     ON DELETE CASCADE
	 ON UPDATE CASCADE
);

insert into videos values
(8005,201,'course material','practice','https://youtu.be/P0xFy8V1ZCE?si=yaqcLHGaE6e--w7X','2025-12-08');

insert into videos values
(50014,201,'C++ basics','','https://youtu.be/M1TuNDoxNpk?si=NqEOkN7kmOBHyVBf',now());

insert into videos values
(50015,202,'web programming','','https://youtu.be/9qxX_tMsaX0?si=brmt88nvCYoGmjjG',now()),
(50020,100,'English','','https://youtu.be/G_F3LVtekNM?si=zZYjl05az8gA7iHa',now()),
(50021,200,'Course basics','','https://youtu.be/P0xFy8V1ZCE?si=yaqcLHGaE6e--w7X',now());

select * from videos;

INSERT INTO users values
('abc@mail.com','1234','student'),
('jia12@mail.com','jia123','student'),
('Manali@mail.com','manali01','student'),
('ash04@mail.com','ashwini04','student'),
('sheero@mail.com','bones','student'),
('arya3130@mail.com','aryachou','admin');


-- upcoming courses

select * from courses where start_date>current_date();


-- fetch all the registered students along with course name

select  s.reg_no , s.s_name , s.email, s.mobile_no , c.course_id , c.course_name
from Students s JOIN Courses c on c.course_id=s.course_id;

-- fetch the complete details of a student(based on their email) along with the details of the course they are enrolled in.

select s.reg_no , s.s_name , s.email, s.mobile_no , c.course_id , c.course_name , c.descrip , c.fees , c.start_date , c.end_date
from Students s JOIN Courses c on  c.course_id=s.course_id
where s.email='ash04@mail.com';

-- 4th query

select c.course_id , c.course_name , c.start_date , c.end_date , c.video_expire_days , v.video_id , v.title , v.added_at
from Courses c JOIN videos v on c.course_id=v.course_id JOIN Students s on s.course_id=c.course_id
where s.email='ash04@mail.com' and datediff(v.added_at,current_date)<=c.video_expire_days;