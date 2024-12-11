-- Active: 1733322951527@@127.0.0.1@3306@fittrack
CREATE database FitTrack;
use FitTrack;
create table members(
member_id int (11) primary key,
first_name varchar(50),
last_name varchar(50),
gneder enum ('male','female','other'),
date_of_birth date,
phone_number varchar(15),
email varchar(100)
);

create table rooms(
room_id int(11) primary key,
room_member varchar(10),
room_type enum ('cardio','weights','studio'),
capacity int(11)
);
create table memberships(
membership_id int(11) primary key,
member_id int(11),
room_id int(11),
start_date date,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

create table departments(
department_id int (11) primary key,
departments_name varchar(50),
location varchar(100)
);

create table trainers(
trainer_id int(11) primary key,
first_name varchar(50),
last_name varchar(50),
specialization varchar(50),
department_id int (11) ,
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
create table appointments(
appointments_id int(11) primary key,
appointments_date date,
appointments_time time,
trainer_id int,
member_id int,
foreign key(trainer_id) references trainers(trainer_id),
foreign key(member_id) references members(member_id)
);
 CREATE TABLE workour_plans(
    plan_id INT PRIMARY KEY , 
    instructions VARCHAR(255),
    member_id INT,
    trainer_id INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
)


INSERT INTO members (member_id, first_name, last_name, gneder, date_of_birth, phone_number, email) 
VALUES
(1, 'Alex', 'Johnson', 'male', '1990-07-15', '1234567890', 'alex.johnson@example.com'),
(2, 'Emma', 'Brown', 'female', '2005-03-22', '0987654321', 'emma.brown@example.com'),
(3, 'John', 'Smith', 'male', '1998-06-12', '1122334455', NULL),
(4, 'Sophia', 'Taylor', 'female', '2001-09-15', '6677889900', 'sophia.taylor@example.com');


INSERT INTO rooms (room_id, room_member, room_type, capacity) 
VALUES
(1, 'A1', 'cardio', 30),
(2, 'B1', 'weights', 20),
(3, 'C1', 'studio', 25);


INSERT INTO departments (department_id, departments_name, location) 
VALUES
(1, 'Musculation', 'Building A'),
(2, 'Cardio', 'Building B'),
(3, 'Yoga', 'Building C');

INSERT INTO trainers (trainer_id, first_name, last_name, specialization, department_id) 
VALUES
(1, 'Michael', 'Brown', 'Weight Training', 1),
(2, 'Anna', 'Smith', 'Cardio Fitness', 2),
(3, 'Laura', 'Garcia', 'Yoga', 3);

INSERT INTO memberships (membership_id, member_id, room_id, start_date) 
VALUES
(1, 1, 1, '2024-12-01'),
(2, 2, 2, '2024-12-02'),
(3, 3, 3, '2024-12-03'),
(4, 4, 1, '2024-12-04');


INSERT INTO appointments (appointments_id, appointments_date, appointments_time, trainer_id, member_id) 
VALUES
(1, '2024-12-05', '10:00:00', 1, 1),
(2, '2024-12-06', '14:00:00', 2, 2),
(3, '2024-12-07', '16:00:00', 3, 3),
(4, '2024-12-08', '12:00:00', 1, 4);
(5, '2022-12-08', '12:00:00', 1, 4);




INSERT INTO workour_plans (plan_id, instructions, member_id, trainer_id) 
VALUES
(1, 'Basic Cardio Routine', 1, 1),
(2, 'Advanced Weight Training', 2, 1),
(3, 'Yoga Relaxation Plan', 3, 3),
(4, 'Personalized Training Program', 4, 2);

/* EXERCICES*/

/*1 -Opérations CRUD*/

insert into members (member_id,first_name,last_name,gneder,date_of_birth,phone_number) 
values(1,'Alex','Johnson','male','1990-06-15','1234567890');

/*2- Instruction SELECT*/

select * from departments;

/*3- Clause ORDER BY*/
select * from members order by date_of_birth;

/*4-DISTINCT*/
select distinct gneder from members;

/*5- Clause LIMIT*/
 select * from trainers limit 3;
 
 /*6- Clause WHERE*/
select * from members where year(date_of_birth) >2000;

/*7- Opérateurs Logiques*/
;
select * from trainers  where department_id in (select department_id from departments where departments_name in('Musculation', 'Cardio'));

/*8- Opérateurs Spéciaux*/

select * from memberships where start_date between '2024-12-1' and  '2024-12-7';

/*9- Expressions Conditionnelles*/
ALTER TABLE members
ADD COLUMN category_age VARCHAR(10);

UPDATE members
SET category_age = CASE
    WHEN YEAR(CURDATE()) - YEAR(date_of_birth) < 18 THEN 'Junior'
    WHEN YEAR(CURDATE()) - YEAR(date_of_birth) BETWEEN 18 AND 59 THEN 'Adult'
    ELSE 'Senior'
END;


/*10- Fonctions d'Agrégation*/
select count(*) from appointments;

/*11- COUNT avec GROUP BY*/

select count(trainer_id) as 'nombre d entraîneurs' , department_id as 'departement ID  ' from  trainers group by  department_id;

/*12- AVG*/
SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS age_moyen
FROM members;

/*13 -MAX */
select max(appointments_time),max(appointments_date) from  appointments;

/* 14- */
select sum(membership_id) as 'total des abonnements ', room_id  from  memberships group by room_id;

/*15 - Contraintes */
select * from members where email is  null;

/* 16-Jointure*/
 select a.appointments_time,a.appointments_date, CONCAT(m.first_name,' ',m.last_name) as  'member-full name', CONCAT(t.first_name ,' ',t.last_name) as  'trainer-full name'
  from members m join appointments a on m.member_id = a.member_id 
 join trainers t on t.trainer_id =a.trainer_id;
 
 /* 17- DELETE*/    
 delete from appointments where year(appointments_date) < 2024;



/*18 UPDATE */
UPDATE departments
SET departments_name = 'Force et Conditionnement'
WHERE departments_name = 'Musculation';
 /*19- Clause HAVING */
 select gneder as "Gender", COUNT(*) FROM members group BY gneder having count(*)>2;

 /*20- Créer une vue*/
 create  view  Abonnements_current
 as 
 SELECT * from memberships where start_date <= CURDATE(); 

/*BONUUUUUUUUUUUUS*/
/*-----------------*/

/*bonus 1*/
select CONCAT(m.first_name , ' ' , m.last_name) as 'Member Full Name',CONCAT(t.first_name , ' ' ,t.last_name) as 'Trainer Full Name'
 from members m join memberships ms on m.member_id=amsmember_id
 join trainers t on t.trainer_id=a.trainer_id; 
 /*--------------------------------*/

 /*bonus 2*/

 select a.appointments_id,a.appointments_date,a.appointments_time,d.departments_name,d.location
 from appointments a join  trainers t on a.trainer_id = t.trainer_id
join departments d on d.department_id=t.department_id; 
 /*--------------------------------*/

 /*bonus 3*/

 SELECT CONCAT(t.first_name, ' ', t.last_name) AS `Trainer Full Name`, GROUP_CONCAT(wp.plan_id) AS `Plan IDs`, GROUP_CONCAT(wp.instructions SEPARATOR '; ') AS `Instructions`
FROM trainers t JOIN  workour_plans wp  ON  t.trainer_id = wp.trainer_id GROUP BY  
CONCAT(t.first_name, ' ', t.last_name);
 /*--------------------------------*/

/* bonus 4*/

SELECT CONCAT(m.first_name , ' ' , m.last_name) as 'Member Full Name', r.room_type,ms.membership_id FROM
members m join memberships ms on m.member_id = ms.member_id join
rooms r on ms.room_id = r. room_id; 



 /*--------------------------------*/
 /*bonus 5*/

 select d.department_id, COUNT(m.member_id) as 'total de Membres' from memberships ms join
 members m on m.member_id = ms.member_id join workour_plans wp on m.member_id =wp.member_id
 join trainers t on wp.trainer_id=t.trainer_id
 join departments d on d.department_id = t.department_id
 group by d.department_id;









