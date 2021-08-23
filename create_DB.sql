create database university;

create table groups_(
group_id int primary key generated always as identity,
group_name char(1),
);

create table journal (
record_id int primary key generated always as identity,
Student_ID int,
Class_ID int,
Grade int,
date_ TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 );

create table students (
student_id int primary key generated always as identity,
first_name varchar(10),
second_name varchar(30),
group_id int,
constraint fk_group 
foreign key (group_id)
references groups_(group_id)
);


create table teachers(
Teacher_ID int primary key generated always as identity,
First_name varchar(10),
Second_name varchar(30)
);

create table classes(
Class_ID int primary key generated always as identity,
Class_name varchar(30),
Teacher_ID int,
constraint fk_teacher
foreign key (teacher_id)
references teachers(teacher_id)
);

create Table Schedule(
ID int primary key generated always as identity,
Class_ID int,
Student_ID int,
constraint fk_schedule 
foreign key (student_id) 
references students(student_id)
);

insert into classes(class_name) 
values 
('linear algebra'),
('statistic'),
('data bases'),
('big data analyzes'),
('differential equations');

insert into teachers(first_name, second_name) values 
('Marko', 'Polo'),
('Jiro', 'DiItalia'),
('Niko', 'Rosberg')
;


update  classes set teacher_id  = 3 where class_id = 6;
update  classes set teacher_id  = 1 where class_id in (4,5);
update  classes set teacher_id  = 2 where class_id in (7,8);


insert into groups_(group_name) values
('A'),
('B'),
('C');

insert into students(first_name, second_name, group_id) values
('Jameson', 'Adkins', 1 ),
('Aarush', 'Shaw', 2 ),
('Aishah', 'Wall', 2 ),
('Francesco', 'Hood', 1 ),
('Cristian', 'Bates', 3 ),
('Barry', 'Connolly', 1 ),
('Ebrahim', 'Whelan', 3 ),
('Macauley', 'Lloyd', 3 ),
('Gordon', 'Munro', 2 ),
('Harlen', 'Bourne', 1 ),
('Shayla', 'Everett', 3 ),
('Kimberly', 'Bloom', 1 ),
('Chace', 'Brown', 3 ),
('Cai', 'Wheeler', 1 ),
('May', 'Avery', 2 ),
('Shah', 'Cleveland', 3 ),
('Tiarna', 'Manning', 1 ),
('Sanah', 'Wilkerson', 3 ),
('Casey', 'Mansell', 1 ),
('Klaudia', 'Rowe', 3 ),
('Leyla', 'Drummond', 3 ),
('Dave', 'Chambers', 1 ),
('Xavier', 'Heaton', 2 ),
('Evie-Mae', 'Miranda', 2 ),
('Eshal', 'Atherton', 2 ),
('Karol', 'Tapia', 1 ),
('Kaeden', 'Bray', 2 ),
('Rosie', 'Moses', 1 ),
('Alena', 'Patterson', 3 ),
('Alexandra', 'Milne', 1 )
 ;




insert into schedule(class_id, student_id)  
select c.class_id, s.student_id from students s, classes c where s.group_id in  
(select group_id from groups_ where group_name in ('A','C')) and c.class_name = 'linear algebra'; 

insert into schedule(class_id, student_id)  
select c.class_id, s.student_id from students s, classes c where s.group_id in  
(select group_id from groups_ where group_name in ('A', 'B','C')) and c.class_name = 'statistic'; 

insert into schedule(class_id, student_id)  
select c.class_id, s.student_id from students s, classes c where s.group_id in  
(select group_id from groups_ where group_name in ('A', 'B')) and c.class_name = 'data bases'; 

insert into schedule(class_id, student_id)  
select c.class_id, s.student_id from students s, classes c where s.group_id in  
(select group_id from groups_ where group_name in ('B', 'C')) and c.class_name = 'big data analyzes'; 