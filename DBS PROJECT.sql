--===============================================================
--               --:( Univerity ERP Portal ):---                          
--===============================================================
DROP DATABASE IF EXISTS S_portal;
CREATE DATABASE S_portal;
USE project;

--SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS fees;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS departments;
--SET FOREIGN_KEY_CHECKS = 1;

--SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE attendance;
TRUNCATE TABLE enrollments;
TRUNCATE TABLE fees;
TRUNCATE TABLE courses;
TRUNCATE TABLE students;
TRUNCATE TABLE faculty;
TRUNCATE TABLE teachers;
TRUNCATE TABLE users;
TRUNCATE TABLE departments;

--SET FOREIGN_KEY_CHECKS = 1;


-- 1) DEPARTMENTS

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    head_of_dept_id INT NULL
);

-- 2) USERS

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    related_entity_id INT NULL
);

-- 3) TEACHERS

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    user_id INT UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    designation VARCHAR(50),
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 4) FACULTY

CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    user_id INT UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    designation VARCHAR(50),
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 5) Class Schedule

CREATE TABLE c_schedule(
    schedule_id INT PRIMARY KEY,
    faculty_id INT NOT NULL,
    room_num VARCHAR(50) NOT NULL,
    day_of_week VARCHAR(20) NOT NULL,   
    start_time VARCHAR(50) NOT NULL,
    end_time VARCHAR(50) NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);


-- 6) STUDENTS

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    user_id INT UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    enrollment_date DATE NOT NULL,
    department_id INT NOT NULL,
    status VARCHAR(50) DEFAULT 'Active',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 7) COURSES

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE,
    title VARCHAR(150) NOT NULL,
    credits INT NOT NULL,
    department_id INT NOT NULL,
    faculty_id INT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- 8) ENROLLMENTS

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(50) NOT NULL,
    grade VARCHAR(4),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 9) ATTENDANCE

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    is_present VARCHAR(50) NOT NULL,
    UNIQUE (student_id, course_id, attendance_date),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 10) FEES

CREATE TABLE fees (
    fee_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    invoice_number VARCHAR(50) UNIQUE,
    amount_due DECIMAL(12,2) NOT NULL,
    amount_paid DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    due_date DATE NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Insert Values

-- Departments

INSERT INTO departments (department_id, name) VALUES
(1,'Computer Science'),
(2,'Business Administration'),
(3,'Electrical Engineering'),
(4,'Mathematics');

SELECT * FROM departments

SELECT * FROM departments
RIGHT JOIN users
ON department_id = user_id

-- Users

INSERT INTO users (user_id, username, password, role) VALUES
(1,'admin', 'Admin@2024', 'Admin'),
(2,'sarah.khan', 'Pass123', 'Faculty'),
(3,'bilal.hassan', 'Pass456', 'Faculty'),
(4,'t_hamza', 'Teach@001', 'Teacher'),
(5,'t_aisha', 'Teach@002', 'Teacher'),
(6,'t_bilal', 'Teach@003', 'Teacher'),
(7,'t_fatima', 'Teach@004', 'Teacher'),
(8,'hamza.ali', 'Stud@321', 'Student'),
(9,'fatima.nasir', 'Stud@123', 'Student'),
(10,'usman.arif', 'Stud@555', 'Student'),
(11,'maheen.saeed', 'Stud@785', 'Student');

SELECT * FROM users

-- Teachers 

INSERT INTO teachers (teacher_id, user_id, full_name, email, designation, department_id, hire_date, salary)
VALUES
(1, 4, 'Mr. Hamza Sherwani', 'hamza.sherwani@example.com', 'Lecturer', 1, '2020-01-10', 60000.00),
(2, 5, 'Ms. Aisha Khan', 'aisha.khan@example.com', 'Lecturer', 2, '2021-03-05', 55000.00),
(3, 6, 'Mr. Bilal Ahmed', 'bilal.ahmed@example.com', 'Senior Lecturer', 1, '2019-07-20', 65000.00),
(4, 7, 'Ms. Fatima Iqbal', 'fatima.iqbal@example.com', 'Assistant Professor', 2, '2022-05-15', 50000.00);

SELECT * FROM teachers

-- Faculty 

INSERT INTO faculty (faculty_id, user_id, full_name, email, designation, department_id, hire_date, salary)
VALUES
(1, 2, 'Sarah Khan', 'sarah.khan@university.com', 'Associate Professor', 1, '2018-02-15', 185000),
(2, 3, 'Bilal Hassan', 'bilal.hassan@university.com', 'Lecturer', 2, '2020-01-10', 145000),
(3, 4, 'Ali Khan', 'khanALi@university.com', 'Associate Professor', 1, '2018-02-15', 195000),
(4, 5, 'Usama', 'Usama.@university.com', 'Examinar Contoller', 2, '2020-01-10', 135000);

SELECT * FROM faculty

-- Class Schedule 

INSERT INTO c_schedule (schedule_id, faculty_id, room_num, day_of_week, start_time, end_time)
VALUES(1, 1, 'Room-101', 'Monday', '09:00:00', '10:30:00'),
(2, 2, 'Room-202', 'Tuesday', '11:00:00', '12:30:00'),
(3, 1, 'Room-103', 'Wednesday', '13:00:00', '14:30:00'),
(4, 3, 'Room-305', 'Thursday', '10:00:00', '11:30:00'),
(5, 2, 'Room-210', 'Friday', '09:00:00', '10:00:00');


-- Students 

INSERT INTO students (student_id, user_id, full_name, email, enrollment_date, department_id, status)
VALUES
(1, 8, 'Hamza Ali', 'hamza.ali@students.com', '2022-09-05', 1, 'Active'),
(2, 9, 'Fatima Nasir', 'fatima.nasir@students.com', '2023-02-01', 1, 'Active'),
(3, 10, 'Usman Arif', 'usman.arif@students.com', '2021-09-12', 2, 'Graduated'),
(4, 11, 'Maheen Saeed', 'maheen.saeed@students.com', '2023-01-15', 3, 'Active');

SELECT * FROM students

-- Courses 

INSERT INTO courses (course_id, course_code, title, credits, department_id, faculty_id)
VALUES
(1,'CS101', 'Introduction to Programming', 3, 1, 1),
(2,'CS202', 'Database Systems', 3, 1, 1),
(3,'BA110', 'Principles of Management', 3, 2, 2),
(4,'EE120', 'Circuit Analysis', 3, 3, NULL);

SELECT * FROM courses

-- Enrollments

INSERT INTO enrollments (enrollment_id, student_id, course_id, semester, grade)
VALUES
(1, 1, 1, 'Fall 2024', 'A'),
(2, 1, 2, 'Fall 2024', 'B'),
(3, 2, 1, 'Fall 2024', 'A'),
(4, 3, 3, 'Spring 2024', 'A'),
(5, 4, 4, 'Spring 2024', NULL);

SELECT * FROM enrollments

INSERT INTO attendance (attendance_id, student_id, course_id, attendance_date, is_present)
VALUES
(1, 1, 1, '2024-09-02', 'Present'),
(2, 1, 1, '2024-09-03', 'Present'),
(3, 1, 1, '2024-09-04', 'Present'),
(4, 2, 1, '2024-09-02', 'Present'),
(5, 2, 1, '2024-09-03', 'Present'),
(6, 3, 3, '2024-09-02', 'Present'),
(7, 4, 4, '2024-09-06', 'Absent');

SELECT * FROM attendance

-- Fees

INSERT INTO fees (fee_id, student_id, invoice_number, amount_due, amount_paid, due_date, payment_status)
VALUES
(1, 1, 'INV-2024-001', 52000, 25000, '2024-09-30', 'Pending'),
(2, 2, 'INV-2024-002', 52000, 52000, '2024-09-30', 'Paid'),
(3, 3, 'INV-2024-003', 60000, 0, '2024-07-15', 'Overdue'),
(4, 4, 'INV-2024-004', 65000, 22000, '2024-10-10', 'Pending');

UPDATE fees
SET payment_status = 'Struck Off'
WHERE student_id = 3

SELECT * FROM fees

-- Views

CREATE VIEW fee_summary AS
SELECT
    s.student_id,
    s.full_name,
    s.email,
    f.invoice_number,
    f.amount_due,
    f.amount_paid,
    (f.amount_due - f.amount_paid) AS remaining_amount,
    f.payment_status
FROM students s
JOIN fees f
ON s.student_id = f.student_id;
SELECT * FROM fee_summary;

-- Restore Procedure

DELIMITER $$
CREATE PROCEDURE update_fee_status()
BEGIN
    UPDATE fees
    SET payment_status =
        CASE
            WHEN amount_paid >= amount_due THEN 'Paid'
            WHEN due_date < CURDATE() AND amount_paid < amount_due THEN 'Overdue'
            ELSE 'Pending'
        END;
END$$
DELIMITER ;
CALL update_fee_status();

--Functions

DELIMITER $$
CREATE FUNCTION get_remaining_fee(studentId INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE remaining DECIMAL(12,2);

    SELECT (amount_due - amount_paid)
    INTO remaining
    FROM fees
    WHERE student_id = studentId;

    RETURN remaining;
END$$
DELIMITER ;
SELECT get_remaining_fee(1);

-- Update Commands

UPDATE students
SET email = 'itxHazma8080@gmail.com'
WHERE student_id = 1;

UPDATE students
SET full_name = 'Hamza Javed'
WHERE student_id = 4;

UPDATE students
SET status = 'Pending'
WHERE user_id = 11;

UPDATE courses
SET faculty_id = 2
WHERE course_id = 1;

UPDATE fees
SET amount_paid = amount_due, payment_status = 'Paid'
WHERE fee_id = 1;

UPDATE attendance
SET is_present = 'Absent'
WHERE attendance_id = 3;

UPDATE faculty
SET salary = salary + 7000
WHERE faculty_id = 1;

UPDATE users
SET role = 'Registrar'
WHERE user_id = 11;

-- Delete Commands 

DELETE FROM attendance
WHERE attendance_date = '2024-08-06';

DELETE FROM enrollments
WHERE student_id = 1 AND course_id = 2;

DELETE FROM attendance 
WHERE student_id = 4;

DELETE FROM enrollments 
WHERE student_id = 4;

DELETE FROM fees
WHERE student_id = 4;

DELETE FROM students
WHERE student_id = 4;

DELETE FROM courses
WHERE course_id = 4;

DELETE FROM users
WHERE password = 'Admin@2024';

-- Aggregates 

SELECT d.name, COUNT(*)
AS total_students
FROM students s
JOIN departments d
ON s.department_id = d.department_id
GROUP BY d.name;

SELECT SUM(amount_paid)
AS total_amount
FROM fees;
select * from fees;


SELECT AVG(salary)
AS average_salary
FROM faculty;

SELECT COUNT(*)
AS total_courses
FROM courses;
select * from courses

SELECT MAX(amount_due)
AS highest_fee
FROM fees;

SELECT MIN(salary)
AS lowest_salary
FROM faculty;

SELECT MAX(salary)
AS highest_salary
FROM faculty;

SELECT * FROM faculty;

SELECT SUM(amount_due - amount_paid) 
AS total_pending
FROM fees;

SELECT SUM(amount_due)
AS remain_amount
FROM fees;

SELECT * FROM departments;
SELECT * FROM users;
SELECT * FROM teachers;
SELECT * FROM faculty;
SELECT * FROM c_schedule;
SELECT * FROM students
SELECT * FROM courses
SELECT * FROM enrollments;
SELECT * FROM attendance;
SELECT * FROM fees;

-- Joins

SELECT * 
FROM departments
INNER JOIN users
ON department_id = user_id
INNER JOIN fees
ON user_id = student_id

SELECT * FROM departments
RIGHT JOIN users
ON department_id = user_id

SELECT * FROM departments
RIGHT JOIN users
ON department_id = user_id