--- SET OPERATIONS

---1. Student details of blood group AB+ or O+

SELECT *
FROM student_details
WHERE `Blood Group` = "AB+" 
UNION
SELECT *
FROM student_details
WHERE `Blood Group` = "O+"

---2. Student id who students who have the same number of marks in Kannada and English

SELECT em.`Student ID`,em.Total
FROM exam_marks em
WHERE em.`subject Code` = "51ENG"
AND EXISTS (SELECT em1.`Student ID`,em1.Total
            FROM exam_marks em1
            WHERE em1.`subject Code` = "52KAN" AND em.Total = em1.Total);

---3. Students with different maths and science marks in IA1

SELECT im.`Student ID`
FROM internals_marks im
WHERE im.`Subject Code` = '54MAT'
AND NOT EXISTS (SELECT im1.`Student ID`
                FROM internals_marks im1
                WHERE im1.`Subject Code` = '55SCI' AND im.IA1 = im1.IA1);

---4. Name, Class, and Gender of students who are Muslim or Christian

SELECT Name,Class,Gender,Religion
FROM student_details
WHERE Religion = "Muslim" 
UNION
SELECT Name,Class,Gender,Religion
FROM student_details
WHERE Religion = "Christian";

------------------------------------------------------------------------------------------------------------
