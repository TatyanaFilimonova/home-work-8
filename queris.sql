/*
 Here are the HW8 queries implementation
 */


/*
 Query 1: select 5 students with the biggest avg grade for all classes
 */

select s.first_name||' '||s.second_name as student, avg(j.grade) as avg_grade 
from students as s 
right join journal as j 
on s.student_id = j.student_id 
group by student 
order by avg_grade desc
limit 5;

/*
 Query 2: select 1 students with the biggest avg grade for one class
 */

select s.first_name||' '||s.second_name as student, c.class_name as _class_, avg(j.grade) as avg_grade 
from students as s 
inner join journal as j 
on s.student_id = j.student_id 
inner join classes as c 
on j.class_id = c.class_id
group by student, _class_ 
order by avg_grade desc
limit 1;

/*
 Query 3: select avg grade for a group for a class
 */

select g.group_name group_, c.class_name as _class_, avg(j.grade) as avg_grade 
from groups_ as g 
inner join students as s 
on g.group_id = s.group_id 
inner join journal as j 
on s.student_id = j.student_id
inner join classes as c
on j.class_id = c.class_id
group by group_, _class_ 
order by group_, _class_;

/* 
 Query 4: average grade for all groups 
 */

select avg(j.grade) as average_grade from journal as j;

/* 
 Query 5: What classes are reading by each teacher
 */

select t.first_name||' '||t.second_name as teacher, c.class_name as class_name
from teachers as t
inner join classes as c 
on t.teacher_id = c.teacher_id
order by teacher, class_name;

/* 
 Query 6: List of students for paticular group
 */

select s.first_name||' '||s.second_name as student, g.group_name as group
from students as s
inner join groups_ as g 
on s.group_id = g.group_id 
where g.group_name = 'A';

/* 
 Query 7: List of grades for students from the particular group and particular class
 */


select s.first_name||' '||s.second_name as student, g.group_name, j.date_ as date, j.grade
from students as s
inner join groups_ as g 
on s.group_id = g.group_id 
inner join journal as j
on s.student_id = j.student_id 
inner join classes as c 
on j.class_id = c.class_id
where g.group_name = 'C' and c.class_name = 'linear algebra' 
order by student, date asc;

/* 
 Query 8: List of grades for students from the particular group and particular 
 class on the last date in journal for this class&group
 */

select s.first_name||' '||s.second_name as student, j.grade, j.date_ as date
from students as s
inner join groups_ as g 
on s.group_id = g.group_id 
inner join journal as j
on s.student_id = j.student_id 
inner join classes as c 
on j.class_id = c.class_id
where g.group_name = 'C' and c.class_name = 'linear algebra' and j.date_ = 
(select max(j2.date_) from journal as j2 
inner join students as s2 
on j2.student_id = s2.student_id
inner join groups_ as g2
on s2.group_id = g2.group_id
inner join classes as c2
on j2.class_id = c2.class_id 
where g2.group_name = 'C' and c2.class_name = 'linear algebra')   
order by student
;


/* 
 Query 9: List of classes that student is subcscribed for
  */

select s.first_name||' '||s.second_name as student, c.class_name as title
from  students as s 
inner join schedule as sch 
on s.student_id = sch.student_id
inner join classes as c 
on sch.class_id = c.class_id
where s.first_name = 'Aarush' and s.second_name= 'Shaw'
order by student, title
;

/* 
 Query 10: List of classes that teacher reading for particular student
  */

select s.first_name||' '||s.second_name as student, t.first_name||' '||t.second_name as teacher, c.class_name as class
from  students as s 
inner join schedule as sch 
on s.student_id = sch.student_id
inner join classes as c 
on sch.class_id = c.class_id
inner join teachers as t
on c.teacher_id = t.teacher_id 
where (s.first_name = 'Aarush' and s.second_name= 'Shaw' ) and (t.first_name = 'Marko' and t.second_name= 'Polo' )
order by student, class;

/* 
 Query 11: Average grade that teacher set up for particular student
  */

select s.first_name||' '||s.second_name as student, t.first_name||' '||t.second_name as teacher, avg(j.grade) as average_grade
from  students as s 
inner join journal as j
on s.student_id = j.student_id
inner join classes as c 
on j.class_id = c.class_id
inner join teachers as t
on c.teacher_id = t.teacher_id
where (s.first_name = 'Aarush' and s.second_name= 'Shaw' ) and (t.first_name = 'Marko' and t.second_name= 'Polo' )
group by student, teacher;

/* 
 Query 12: Average grade that teacher set up for all the students
  */

select t.first_name||' '||t.second_name as teacher, avg(j.grade) as average_grade
from  journal as j 
inner join classes as c
on j.class_id = c.class_id
inner join teachers as t 
on c.teacher_id = t.teacher_id
where t.first_name = 'Marko' and t.second_name= 'Polo'
group by teacher;
