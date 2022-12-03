
--- TRIGGERS

--- There are multiple triggers which have been used in the database for the proper working of the system

/*
After a new student has been added into the database, add the student id of 
the new student into attendence table,stud_users,exam_marks,internal_marks 
to keep a record of the attendence,login and marks of the new student 
*/

CREATE TRIGGER `Add Student ID into attendance Table` AFTER INSERT ON `student_details`
FOR EACH ROW INSERT INTO `attendence`
(`Student ID`) VALUES (new.`Student ID`);

CREATE TRIGGER `Add Student ID into Stud_users Table` AFTER INSERT ON `student_details`
FOR EACH ROW INSERT INTO `stud_users`
(`Unique_ID`) VALUES (new.`Student ID`);

CREATE TRIGGER `Add Student ID into exam_marks Table` AFTER INSERT ON `student_details`
FOR EACH ROW INSERT INTO `exam_marks`
(`Student ID`) VALUES (new.`Student ID`);

CREATE TRIGGER `Add Student ID into internals_marks Table` AFTER INSERT ON `student_details`
FOR EACH ROW INSERT INTO `internals_marks`
(`Student ID`) VALUES (new.`Student ID`);

/*
After a new teacher has been added into the database, add the Subject Code 
of the subject the teacher takes into exam_marks and internal_marks for the updation
of marks in the respective subject
*/

CREATE TRIGGER `Add Subject Code into exam_marks Table` AFTER INSERT ON `subject_details`
FOR EACH ROW INSERT INTO `exam_marks`
(`Subject Code`) VALUES (new.`Subject Code`);

CREATE TRIGGER `Add Subject Code into internals_marks Table` AFTER INSERT ON `subject_details`
FOR EACH ROW INSERT INTO `internals_marks`
(`Subject Code`) VALUES (new.`Subject Code`);
