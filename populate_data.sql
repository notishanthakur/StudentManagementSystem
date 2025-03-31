USE SMS;

-- Populate Student Table
INSERT INTO Student (Student_ID, First_Name, Last_Name) VALUES
(1, 'Aarav', 'Sharma'),
(2, 'Vihaan', 'Verma'),
(3, 'Ishaan', 'Mehta'),
(4, 'Rohan', 'Kapoor'),
(5, 'Kabir', 'Chopra');

-- Populate Address Table
INSERT INTO Address (Address_ID, Street, City, State, PostalCode, Country) VALUES
(1, 'MG Road', 'Mumbai', 'Maharashtra', '400001', 'India'),
(2, 'Brigade Road', 'Bangalore', 'Karnataka', '560001', 'India'),
(3, 'Connaught Place', 'Delhi', 'Delhi', '110001', 'India'),
(4, 'Park Street', 'Kolkata', 'West Bengal', '700016', 'India'),
(5, 'Anna Salai', 'Chennai', 'Tamil Nadu', '600002', 'India');

-- Populate StudentAddress Table
INSERT INTO StudentAddress (Student_Address_ID, Student_ID, Address_ID, Address_Type, Is_Current) VALUES
(1, 1, 1, 'Permanent', 1),
(2, 2, 2, 'Temporary', 0),
(3, 3, 3, 'Permanent', 1),
(4, 4, 4, 'Temporary', 0),
(5, 5, 5, 'Permanent', 1);

-- Populate StudentContact Table
INSERT INTO StudentContact (Contact_ID, Student_ID, Contact_Type, Contact_Value, Is_Primary) VALUES
(1, 1, 'Mobile', '+91-9876543210', 1),
(2, 2, 'Mobile', '+91-9823456789', 1),
(3, 3, 'Email', 'ishaan.mehta@example.com', 1),
(4, 4, 'Email', 'rohan.kapoor@example.com', 1),
(5, 5, 'Mobile', '+91-9012345678', 1);

-- Populate CourseDescription Table
INSERT INTO CourseDescription (Course_ID, Description, Learning_Objectives, Prerequisites) VALUES
(1, 'Data Structures', 'Understand Linked Lists, Trees, Graphs', 'Basic Programming'),
(2, 'Database Management', 'SQL, Normalization, Transactions', 'Basic SQL'),
(3, 'Operating Systems', 'Processes, Memory Management, Scheduling', 'C Programming'),
(4, 'Machine Learning', 'Supervised and Unsupervised Learning', 'Statistics'),
(5, 'Web Development', 'HTML, CSS, JavaScript, Node.js', 'Basic Coding');

-- Populate Course Table
INSERT INTO Course (Course_ID, Course_Code, Course_Name, Credits) VALUES
(1, 'CS101', 'Data Structures', 4),
(2, 'CS102', 'Database Management', 3),
(3, 'CS103', 'Operating Systems', 4),
(4, 'CS104', 'Machine Learning', 3),
(5, 'CS105', 'Web Development', 3);

-- Populate Instructor Table
INSERT INTO Instructor (Instructor_ID, First_Name, Last_Name) VALUES
(1, 'Amit', 'Singh'),
(2, 'Neha', 'Gupta'),
(3, 'Rajesh', 'Kumar'),
(4, 'Pooja', 'Desai'),
(5, 'Arun', 'Malhotra');

-- Populate Department Table
INSERT INTO Department (Department_ID, Department_Name, Description) VALUES
(1, 'Computer Science', 'CS and AI Courses'),
(2, 'Electrical', 'Power and Electronics'),
(3, 'Mechanical', 'Automobile and Machines'),
(4, 'Civil', 'Construction and Architecture'),
(5, 'Biotechnology', 'Bioengineering Research');

-- Populate DepartmentInstructor Table
INSERT INTO DepartmentInstructor (Dept_Instructor_ID, Department_ID, Instructor_ID, Start_Date, End_Date, Is_Active) VALUES
(1, 1, 1, '2020-01-01', NULL, 1),
(2, 2, 2, '2019-07-01', NULL, 1),
(3, 3, 3, '2021-03-15', NULL, 1),
(4, 4, 4, '2018-06-10', NULL, 1),
(5, 5, 5, '2017-09-05', NULL, 1);

-- Populate CourseOffering Table
INSERT INTO CourseOffering (Offering_ID, Course_ID, Instructor_ID, Academic_Term, Academic_Year) VALUES
(1, 1, 1, 'Spring', '2024'),
(2, 2, 2, 'Fall', '2024'),
(3, 3, 3, 'Summer', '2024'),
(4, 4, 4, 'Winter', '2024'),
(5, 5, 5, 'Spring', '2024');

-- Populate StudentCourse Table
INSERT INTO StudentCourse (Enrollment_ID, Student_ID, Offering_ID, Enroll_Date, Status) VALUES
(1, 1, 1, '2024-01-15', 'Active'),
(2, 2, 2, '2024-01-16', 'Active'),
(3, 3, 3, '2024-01-17', 'Active'),
(4, 4, 4, '2024-01-18', 'Active'),
(5, 5, 5, '2024-01-19', 'Active');

-- Populate Grade Table
INSERT INTO Grade (Grade_ID, Enrollment_ID, Assessment_Type, Marks, Letter_Grade, Grading_Date) VALUES
(1, 1, 'Midterm', 85, 'A', '2024-02-15'),
(2, 2, 'Final', 78, 'B+', '2024-03-01'),
(3, 3, 'Assignment', 92, 'A+', '2024-03-10'),
(4, 4, 'Project', 88, 'A', '2024-03-15'),
(5, 5, 'Midterm', 80, 'B+', '2024-02-20');

-- Populate Room Table
INSERT INTO Room (Room_ID, Building, Room_Number, Capacity) VALUES
(1, 'Academic Block A', '101', 60),
(2, 'Academic Block B', '202', 50),
(3, 'Engineering Block C', '303', 70),
(4, 'Library Block', '404', 30),
(5, 'Research Block', '505', 40);

-- Populate CourseSchedule Table
INSERT INTO CourseSchedule (Schedule_ID, Offering_ID, Day, Start_Time, End_Time) VALUES
(1, 1, 'Monday', '09:00', '10:30'),
(2, 2, 'Wednesday', '11:00', '12:30'),
(3, 3, 'Friday', '14:00', '15:30'),
(4, 4, 'Tuesday', '10:00', '11:30'),
(5, 5, 'Thursday', '13:00', '14:30');

-- Populate Attendance Table
INSERT INTO Attendance (Attendance_ID, Schedule_ID, Attendance_Date) VALUES
(1, 1, '2024-02-01'),
(2, 2, '2024-02-02'),
(3, 3, '2024-02-03'),
(4, 4, '2024-02-04'),
(5, 5, '2024-02-05');

-- Populate AttendanceDetail Table
INSERT INTO AttendanceDetail (Detail_ID, Attendance_ID, Student_ID, Status, Time_In, Time_Out) VALUES
(1, 1, 1, 'Present', '09:00', '10:30'),
(2, 2, 2, 'Absent', NULL, NULL),
(3, 3, 3, 'Present', '14:00', '15:30'),
(4, 4, 4, 'Present', '10:00', '11:30'),
(5, 5, 5, 'Late', '13:10', '14:30');
