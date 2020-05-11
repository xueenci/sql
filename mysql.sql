--mysql 学习笔记
--关系型数据库
1、终端使用
2、可视化使用
create TABLE pet(
name VARCHAR(20),
owner VARCHAR(20),
gender CHAR(1),
birth DATE);


INSERT INTO P
INSERT INTO pet
VALUES ("Puffball","diane","f","1996-04-20");


INSERT INTO pet
VALUES ("sss","she","m",NULL);


create TABLE user3(
id int primary key auto_increment,
name VARCHAR(20)
);

INSERT into user3 (name) VALUES ('zhangsan');


create TABLE user4(
id int,
name VARCHAR(20)
);

# tian jia zhujian 
alter table user4 add primary key(id);

#shanchu zhujian
alter table user4 drop primary key;

alter table user4 modify id int primary key;

#wei yi yueshu  (gaiziduan buke chong fu )
create table user5 (
id int,
name VARCHAR(20));

alter table user5 add unique (name);

INSERT into user5 VALUES(1,'zhangsan');
mysql> INSERT into user5 VALUES(1,'zhangsan');
ERROR 1062 (23000): Duplicate entry 'zhangsan' for key 'user5.name'


create table user6 (
id int,
name VARCHAR(20) unique);


alter table user6 drop index name;

alter table user6 modify name VARCHAR(20) unique;

# feikong yue shu
create table user7(
id int ,
name VARCHAR(20) not null );

insert into user7 values (1,'zhangsan');

#moren yue shu 
create table user8(
id int,
name VARCHAR(39),
age int default 10);

insert into  user8 (id,name ) values (1,'zhangsan');


#waijian yue shu yue
涉及到两个表，主表 副表

create table classes(
id int primary key,
name varchar(20));

create table students(
id int primary key,
name varchar(30),
class_id int,
foreign key (class_id) references classes(id));

insert into students values(1001,'zhangsan','1');
insert into students values(1002,'zhangsan','2');
insert into students values(1003,'zhangsan','3');
insert into students values(1004,'zhangsan','4');

insert into classes values(1,'一班');
insert into classes values(2,'二班');
insert into classes values(3,'三班');
insert into classes values(4,'四班');
z

insert into students values(1005,'zhangsan','5');
\
主表中没有的数据值，副表中是不能使用的

增删改查
insert into xxx values(
);

delete from xxx where ...

update xxx set xx=... where

select * from xxx where...



三大数据范式
1数据表中所有字段都是不可分割的原子值

2满足第一范式的前提下，第二范式要求，除主键歪的每一列都必须完全依赖于主键


查询练习

学生
students
学号姓名性别出生年月日 所在班级



课程
课程号 课程名称 教师编号


成绩
学号 课程号 成绩

教师

教师编号 教师名字 教师性别 出生年月日 职称 所在部门


create table student(
sno varchar(20) primary key,
sname varchar(20) not null,
ssex varchar(10) not null,
sbirthday datetime,
class varchar(20));


create table teacher(
tno varchar (20) primary key,
tname varchar(20) not null,
tsex varchar (20) not null,
tbirthday datetime,
prof varchar(20)not null,
depart varchar(20)not null);

create table course (
cno varchar (20) primary key,
cname varchar (20)not null,
tno varchar (20)not null,
foreign key (tno) references teacher (tno));


create table score(
sno varchar(20) not null ,
cno varchar(20) not null,
degree decimal,
foreign key(sno) references student(sno),
foreign key (cno) references course(cno),
primary key (sno,cno)
);


insert into student values ('101','曾华','男','1977-09-01','953033');
insert into student values ('105','匡明','男','1975-09-01','953031');
insert into student values ('107','王丽','女','1976-09-01','953033');
insert into student values ('101','李军','男','1977-09-01','953033');
insert into student values ('109','王芳','女','1975-02-10','953031');
insert into student values ('103','陆君','男','1974-09-01','953031');

insert into teacher values ('804','李程','男','1974-09-01','副教授','计算机系');
insert into teacher values ('856','张旭','男','1974-09-01','讲师','电子工程系');
insert into teacher values ('825','王萍','男','1974-09-01','助教','计算机系');
insert into teacher values ('831','刘冰','男','1974-09-01','助教','电子工程系');

insert into course values ('3-105','gaoshu','825');
insert into course values ('3-245','jisuanji','804');
insert into course values ('6-166','shudian','856');
insert into course values ('9-888','xitong','831');


insert into score values('103','3-245','86');
insert into score values('105','3-245','75');
insert into score values('109','3-245','68');
insert into score values('103','3-105','86');
insert into score values('105','3-105','86');
insert into score values('109','3-150','86');
insert into score values('103','3-150','91');
insert into score values('105','3-105','80');
insert into score values('109','3-105','86');
insert into score values('103','6-166','85');
insert into score values('105','6-166','79');
insert into score values('109','6-166','81');



select * from student; (*代表所有字段)
select sno,ssex from student;

查找不重复的列 distinct
select distinct depart from teacher;

查询区间 between and 
select * from score where degree between 60 and 80;

select * from score where degree>60 and degree <80;

IN
select * from score where degree in (75,79);

select * from student where class= '95031' or ssex ='女';


升序降序
select * from student order by class desc;
select * from student order by class asc;
select * from score order by cno asc, degree desc;


统计 count 
select count ()from student where class="95031";



select sno,cno from score where degree=(select max(degree) from score);


分组计算平均数 group by 
select * from course;
 
select avg(degree) from score where cno='3-105';
select avg(degree) from score group by cno;


select cno,avg(degree), count(*) from score group by cno having count(cno)>=2 and cno like '3%';
模糊查询 like

select sno,degree, from score where degree>70 and degree<90;


多表查询；
select sno,sname from student;
select sno,cno,degree from score;

select sname ,cno ,degree from student ,score where student.sno=score.sno;


事务 sql 语句的最小执行单元，一组同时成功或者失败的语句

默认是开启的
select @@autocommit;

set autocommit = 0;

设置关闭后，可以通过rollback取消上一条命令，
最终可以通过commit 提交

begin 或者 start tanscation 可以手动开启一个事务，就可以Rollback 

事务的四大特征
A 原子性：不可分割
C 一致性：同时成功或者失败
I 隔离性 事务之间有隔离性
D 持久性 事务一旦结束（commit） 就不可以返回（rollback）



隔离性
read uncommited ; 读未提交的  会出现脏读
read  commit; 读已经提交的   会出现前后不一致
repeatable read  可以重复读    会出现幻读，两个事务同时操作一张表，一个事务的操作无法被另一个数据读到

serializable  串行化  当表呗另一个事务操作的时候，其他事务里面的写操作是不可以进行的，要进入排队状态。当另一边commit后才能进行操作。
串行化性能差

隔离级别越高性能越差，问题越少。
