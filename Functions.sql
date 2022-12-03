--- FUNCTIONS

/*
The objective of the function is to grade students for the total exam 
marks according to the following schema:
Total > 95 : EXCELLENT
Total <= 95 AND Total > 87 : VERY GOOD
Total <= 87 AND Total > 80 : GOOD
Total <= 80 AND Total > 75 : SATISFACTORY
Total <=75 : POOR
*/

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



SELECT exam_marks.`Student ID`, student_details.Name , `Subject Code` , Total, grade(Total)
FROM exam_marks
JOIN student_details ON exam_marks.`Student ID` = student_details.`Student ID`;

-----------------------------------------------------------------------------------------------------------
