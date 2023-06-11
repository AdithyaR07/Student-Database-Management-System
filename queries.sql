--- JOIN

---1
---	Name and adminssion number of students with attendance <=95

SELECT Name,`Admission Number`
FROM student_details
INNER JOIN attendence ON student_details.`Student ID` =  attendence.`Student ID` 
WHERE attendence.Percentage <= 95;

---2
---	Name of students with internal marks In maths >=19

SELECT Name, internals_marks.`Subject Code`, internals_marks.Average
FROM student_details
JOIN internals_marks ON student_details.`Student ID` =  internals_marks.`Student ID` 
WHERE internals_marks.`Subject Code` = "54MAT" AND internals_marks.Average >= 19;

---3
--- Name of tchrs ,student ids and subject code whose subject >= 98 marks in exam and order by total marks in ascending order

SELECT `Instructor Name`,exam_marks.`Student ID`,exam_marks.`Subject Code`,exam_marks.Total
FROM subject_details
JOIN exam_marks ON exam_marks.`Subject Code` = subject_details.`Subject Code`  
WHERE exam_marks.Total >= 98
ORDER BY exam_marks.Total;

---4
--- Admin has to contact the parents of students < 85 total marks in exam. Write a query for this.

SELECT Name,exam_marks.`Student ID`,exam_marks.`Subject Code`,exam_marks.Total, `Father PhoneNum`,`Mother PhoneNum`
FROM student_details
JOIN exam_marks ON exam_marks.`Student ID` = student_details.`Student ID` 
WHERE exam_marks.Total < 85
ORDER BY exam_marks.Total;





--- Aggregate

---1.	Count the number of students in the database

SELECT COUNT(`Student ID`) FROM student_details;

---2.	StudentID with Social marks > avg of social 

SELECT * 
FROM exam_marks
WHERE exam_marks.`Subject Code` = "56SOC" AND Total > (SELECT AVG(Total) FROM exam_marks)


---3.	Minimum attendance

SELECT *
FROM attendence
WHERE Percentage = (SELECT MIN(Percentage) FROM attendence)

---4.	Max external marks in “55SCI”

SELECT *
FROM exam_marks
WHERE `Subject Code` = "55SCI" AND `External Marks` = (SELECT MAX(`External Marks`) FROM exam_marks)



--- SET Operations

---1.	Student details of blood group AB+ or O+

SELECT *
FROM student_details
WHERE `Blood Group` = "AB+" 

UNION

SELECT *
FROM student_details
WHERE `Blood Group` = "O+"


---2.	Student id who students who have the same amount of marks in Kannada and English

SELECT em.`Student ID`,em.Total
FROM exam_marks em
WHERE em.`subject Code` = "51ENG"
AND EXISTS (SELECT em1.`Student ID`,em1.Total
			FROM exam_marks em1
			WHERE em1.`subject Code` = "52KAN" AND
            em.Total = em1.Total);


---3.	Students with different maths and science marks in IA1

SELECT im.`Student ID`
FROM internals_marks im
where im.`Subject Code` = '54MAT'
AND NOT EXISTS (SELECT im1.`Student ID`
				FROM internals_marks im1
				WHERE im1.`Subject Code` = '55SCI' AND
				im.IA1 = im1.IA1);

---4.	Name, Class and Gender of students who are Muslim or Christian

SELECT Name,Class,Gender,Religion
FROM student_details
WHERE Religion = "Muslim" 

UNION

SELECT Name,Class,Gender,Religion
FROM student_details
WHERE Religion = "Christian";





--- TRIGGERS:

CREATE TRIGGER `Add Student ID into attendance Table after new student` 
AFTER INSERT ON `student_details`
FOR EACH ROW INSERT INTO `attendence`
(`Student ID`) VALUES (new.`Student ID`)

INSERT INTO `student_details` (`Student ID`, `Name`, `Class`, `Gender`, `Blood Group`, `DOB`, `Email`, `Admission Number`, `Admission Date`, `Religion`, `Nationality`, `Father Name`, `Father Occupation`, `Father PhoneNum`, `Mother Name`, `Mother Occupation`, `Mother PhoneNum`, `Present Address`, `Permanent Address`) VALUES
('ST015', 'Afridi Shaheen', 'V A', 'Male', 'AB-', '21 Feb, 2011', 'afrsha@gmail.com', 200567, '2022-08-05', 'Muslim', 'Indian', 'Mohommad', 'Mechanic', '+91 9232545457', 'Fatima', 'House-wife', '+91 9844735514', '16/1, 1st C Main Rd, Mookambika Nagar, Banashankari 3rd Stage, Hosakerehalli, Bengaluru, Karnataka 560085', '16/1, 1st C Main Rd, Mookambika Nagar, Banashankari 3rd Stage, Hosakerehalli, Bengaluru, Karnataka 560085')



--- FUNCTIONS

DELIMITER $$
CREATE FUNCTION grade(Total int)
RETURNS VARCHAR(50)
BEGIN
DECLARE remark VARCHAR(50);

IF Total > 95 THEN
SET remark = 'EXCELLENT';

ELSEIF (Total <= 95 AND Total > 87) THEN
SET remark = 'VERY GOOD';

ELSEIF (Total <= 87 AND Total > 80) THEN
SET remark = 'GOOD';

ELSEIF (Total <= 80 AND Total > 75) THEN
SET remark = 'SATISFACTORY';

ELSE
SET remark= 'POOR';
END IF;
RETURN remark;
END; $$
DELIMITER ;


---

SELECT exam_marks.`Student ID`, student_details.Name , `Subject Code` , Total, grade(Total)
FROM exam_marks
JOIN student_details ON exam_marks.`Student ID` = student_details.`Student ID`;



--- PROCEDURES AND CURSORS



---Convert the mail id of male students into upper case using procedures and cursors


DELIMITER $$
CREATE PROCEDURE maleemailid()

    DECLARE finished int default 0;    
    DECLARE u_email varchar(50) default "";    
    DECLARE emails_list varchar(200) default "";
    
    DECLARE email_cursor CURSOR FOR 
        SELECT email from student_details WHERE Gender = "Male";
        
    DECLARE CONTINUE HANDLER For NOT FOUND SET  finished = 1;     
    open email_cursor;
    
    get_email_point:LOOP
    
    FETCH email_cursor into u_email;
    
    if finished = 1 THEN
        
        LEAVE get_email_point;
    
    END IF;
    
    SET emails_list = CONCAT(emails_list,", ",UPPER(u_email));
    
    END LOOP get_email_point;
    
    CLOSE email_cursor;
    
    SELECT emails_list;

END;$$
DELIMITER ;


---

CALL maleemailid();
