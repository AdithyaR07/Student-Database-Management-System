--- AGGREGATE FUNCTIONS

---1. Count the number of students in the database

SELECT COUNT(`Student ID`) FROM student_details;

---2. Student ID of students with Social marks > average of social marks

SELECT * 
FROM exam_marks
WHERE exam_marks.`Subject Code` = "56SOC" AND Total > (SELECT AVG(Total) FROM exam_marks);

---3. Student ID of student with Minimum attendance

SELECT *
FROM attendence
WHERE Percentage = (SELECT MIN(Percentage) FROM attendence);

---4. Student ID of students with max external marks in “55SCI”

SELECT *
FROM exam_marks
WHERE `Subject Code` = "55SCI" AND `External Marks` = (SELECT MAX(`External Marks`) FROM exam_marks);

-----------------------------------------------------------------------------------------------------------
