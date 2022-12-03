---  JOIN Queries

---1. Name and admission number of students with attendance <=95

SELECT Name,`Admission Number`
FROM student_details
INNER JOIN attendence ON student_details.`Student ID` = attendence.`Student ID` 
WHERE attendence.Percentage <= 95;

---2. Name of students with internal marks in maths >=19

SELECT Name, internals_marks.`Subject Code`, internals_marks.Average
FROM student_details
JOIN internals_marks ON student_details.`Student ID` = internals_marks.`Student ID` 
WHERE internals_marks.`Subject Code` = "54MAT" AND internals_marks.Average >= 19;

---3. Name of teachers, student ids and subject code whose subject >= 98 marks in exam and order by total marks in ascending order

SELECT `Instructor Name`,exam_marks.`Student ID`,exam_marks.`Subject Code`,exam_marks.Total
FROM subject_details
JOIN exam_marks ON exam_marks.`Subject Code` = subject_details.`Subject Code` 
WHERE exam_marks.Total >= 98
ORDER BY exam_marks.Total;

---4. Admin must contact the parents of students < 85 total marks in exam. Write a query for to get the phone numbers of both the parents

SELECT Name,exam_marks.`Student ID`,exam_marks.`Subject Code`,exam_marks.Total, `Father PhoneNum`,`Mother PhoneNum`s
FROM student_details
JOIN exam_marks ON exam_marks.`Student ID` = student_details.`Student ID` 
WHERE exam_marks.Total < 85
ORDER BY exam_marks.Total;

-----------------------------------------------------------------------------------------------------------
