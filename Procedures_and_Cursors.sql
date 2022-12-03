--- PROCEDURES AND CURSORS

 ---1. Increment the marks of the students with attendence > 95

DELIMITER $$
CREATE PROCEDURE `increment_mark`()
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE n_total INTEGER DEFAULT 0;
    DECLARE new_total INTEGER DEFAULT 0;
    DECLARE n_stuid VARCHAR(50) DEFAULT "";
    DECLARE n_subid VARCHAR(50) DEFAULT "";  
    DECLARE n_per INTEGER DEFAULT 0;
    DECLARE pc CURSOR FOR 
        SELECT exam_marks.`Student ID`,exam_marks.`Subject Code`, exam_marks.Total , attendence.Percentage  
        FROM exam_marks 
        JOIN attendence ON exam_marks.`Student ID` =  attendence.`Student ID`;
        
    DECLARE CONTINUE HANDLER 
          FOR NOT FOUND SET finished = 1;
    OPEN pc;
        get_mark:LOOP
            FETCH pc into n_stuid,n_subid,n_total,n_per;
            IF (finished = 1) THEN
              LEAVE get_mark;
            END IF;       
            IF (n_total < 100 AND n_per > 95) THEN
                SET new_total = n_total + 1;
            ELSE 
                 SET new_total = n_total ;
            END IF;     
            SELECT n_stuid,n_subid,new_total,n_per;    
        END LOOP get_mark;
  CLOSE pc;
END$$
DELIMITER ;

CALL `increment_mark`();


---2. Converting the mail ids of male students into upper case using procedures and cursors

DELIMITER $$
CREATE PROCEDURE maleemailid()

    DECLARE finished int default 0;    
    DECLARE u_email varchar(50) default "";    
    DECLARE emails_list varchar(200) default "";
    
    DECLARE email_cursor CURSOR FOR 
        SELECT email from student_details WHERE Gender = "Male";
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET  finished = 1;     
    open email_cursor;
    
    get_email_point:LOOP
    
    FETCH email_cursor into u_email;
    
    if finished = 1 THEN
        
        LEAVE get_email_point;
    
    END IF;
    
    SET emails_list = CONCAT(emails_list,"-|-|- ",UPPER(u_email));
    
    END LOOP get_email_point;
    
    CLOSE email_cursor;
    
    SELECT emails_list;

END;$$
DELIMITER ;


CALL maleemailid();


----------------------------------------------------------------------------------------------------------------------------------------------------
