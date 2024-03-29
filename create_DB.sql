create table groups_(
group_id int primary key generated always as identity,
group_name char(1),
unique(group_name)
);

create table journal (
record_id int primary key generated always as identity,
Student_ID int,
Class_ID int,
Grade int,
date_ TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
unique(Student_ID, Class_ID, Grade, date_)
 );

create table students (
student_id int primary key generated always as identity,
first_name varchar(10),
second_name varchar(30),
group_id int,
constraint fk_group 
foreign key (group_id)
references groups_(group_id)
ON DELETE SET NULL
ON UPDATE CASCADE
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
unique(class_name, teacher_id),
constraint fk_teacher
foreign key (teacher_id)
references teachers(teacher_id)
ON DELETE SET NULL
ON UPDATE CASCADE
);


create Table Schedule(
ID int primary key generated always as identity,
Class_ID int,
Student_ID int,
unique (class_id, student_id),
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


update  classes set teacher_id  = 1 where class_name = 'linear algebra';
update  classes set teacher_id  = 1 where class_name = 'statistic';
update  classes set teacher_id  = 3 where class_name = 'data bases';
update  classes set teacher_id  = 2 where class_name = 'big data analyzes';
update  classes set teacher_id  = 2 where class_name = 'differential equations';


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

/*
#RUN THIS SCRIPT TO FILL IN TABLE JOURNAL WITH RANDOM DATA
import psycopg2
import datetime
from datetime import timedelta
import random

    
def set_journal_data():
# please input your database credentials in the row below:
	with psycopg2.connect("dbname=postgres user=postgres password = '1234'") as conn:
        	cur = conn.cursor()
        	get_list_sql = '''select s.student_id, sdl.class_id  from students as s inner join schedule as sdl on sdl.student_id = s.student_id;'''   
        	insert_sql = """insert into journal (student_id, class_id, grade, date_) values (%s,%s,%s,%s)"""
        	cur.execute(get_list_sql)
        	res = cur.fetchall()
        	start_date = datetime.date(year=2020, month=1, day=1)
        	for r in res:
            		for i in range(7):
                		task= (*(r), random.randrange(7, 12, 1), str(start_date+timedelta(days = random.randrange(2, 363, 1))))
                		# some times there are error with unique constraint because random values is not really random....
                		# so after inserting every row we have to commit changes
                		try:
                    			cur.execute(insert_sql, task)
                    			conn.commit()
                		except:
                    			continue
        	cur.close()

if __name__ == '__main__':
    set_journal_data()
*/
