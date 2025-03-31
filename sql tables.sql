CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50)
);

CREATE TABLE Address (
    Address_ID INT PRIMARY KEY,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);

CREATE TABLE StudentAddress (
    Student_Address_ID INT PRIMARY KEY,
    Student_ID INT,
    Address_ID INT,
    Address_Type VARCHAR(50),
    Is_Current BOOLEAN,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID)
);

CREATE TABLE StudentContact (
    Contact_ID INT PRIMARY KEY,
    Student_ID INT,
    Contact_Type VARCHAR(50),
    Contact_Value VARCHAR(100),
    Is_Primary BOOLEAN,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

CREATE TABLE CourseDescription (
    Course_ID INT PRIMARY KEY,
    Description TEXT,
    Learning_Objectives TEXT,
    Prerequisites TEXT
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Code VARCHAR(50),
    Course_Name VARCHAR(100),
    Credits INT,
    FOREIGN KEY (Course_ID) REFERENCES CourseDescription(Course_ID)
);

CREATE TABLE Instructor (
    Instructor_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50)
);

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100),
    Description TEXT
);

CREATE TABLE DepartmentInstructor (
    Dept_Instructor_ID INT PRIMARY KEY,
    Department_ID INT,
    Instructor_ID INT,
    Start_Date DATE,
    End_Date DATE,
    Is_Active BOOLEAN,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);

CREATE TABLE CourseOffering (
    Offering_ID INT PRIMARY KEY,
    Course_ID INT,
    Instructor_ID INT,
    Academic_Term VARCHAR(50),
    Academic_Year VARCHAR(10),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);

CREATE TABLE StudentCourse (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Offering_ID INT,
    Enroll_Date DATE,
    Status VARCHAR(50),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Offering_ID) REFERENCES CourseOffering(Offering_ID)
);

CREATE TABLE Grade (
    Grade_ID INT PRIMARY KEY,
    Enrollment_ID INT,
    Assessment_Type VARCHAR(50),
    Marks FLOAT,
    Letter_Grade VARCHAR(10),
    Grading_Date DATE,
    FOREIGN KEY (Enrollment_ID) REFERENCES StudentCourse(Enrollment_ID)
);

CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Building VARCHAR(100),
    Room_Number VARCHAR(50),
    Capacity INT
);

CREATE TABLE CourseSchedule (
    Schedule_ID INT PRIMARY KEY,
    Offering_ID INT,
    Day VARCHAR(20),
    Start_Time TIME,
    End_Time TIME,
    FOREIGN KEY (Offering_ID) REFERENCES CourseOffering(Offering_ID)
);

CREATE TABLE CourseScheduleRoom (
    Schedule_Room_ID INT PRIMARY KEY,
    Schedule_ID INT,
    Room_ID INT,
    Effective_From DATE,
    Effective_To DATE,
    FOREIGN KEY (Schedule_ID) REFERENCES CourseSchedule(Schedule_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

CREATE TABLE Attendance (
    Attendance_ID INT PRIMARY KEY,
    Schedule_ID INT,
    Attendance_Date DATE,
    FOREIGN KEY (Schedule_ID) REFERENCES CourseSchedule(Schedule_ID)
);

CREATE TABLE AttendanceDetail (
    Detail_ID INT PRIMARY KEY,
    Attendance_ID INT,
    Student_ID INT,
    Status VARCHAR(50),
    Time_In TIME,
    Time_Out TIME,
    FOREIGN KEY (Attendance_ID) REFERENCES Attendance(Attendance_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

CREATE TABLE InstructorContact (
    Contact_ID INT PRIMARY KEY,
    Instructor_ID INT,
    Contact_Type VARCHAR(50),
    Contact_Value VARCHAR(100),
    Is_Primary BOOLEAN,
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);
