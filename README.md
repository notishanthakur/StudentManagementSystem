# StudentManagementSystem

Student Management System
1. Introduction
   
1.1 Purpose
The Student Management System (SMS) is designed to streamline student information handling, course management, performance tracking, and attendance monitoring. It provides a user-friendly platform for administrators, teachers, and students to access and manage academic data efficiently.

1.2 Scope
The system will:

Maintain student records, including personal details and academic history.

Allow students to enroll in courses and manage their academic plans.

Enable teachers to record grades and track student performance.

Provide an attendance tracking module for monitoring class participation.

Support notifications and alerts for critical academic updates.

1.3 Users of the System
Administrators: Manage student records, courses, and system configurations.

Teachers: Enter grades, track attendance, and oversee courses.

Students: Enroll in courses, check grades, and monitor attendance.

1.4 Assumptions & Constraints
The system will be web-based and require user authentication.

Data will be secure and encrypted to protect student privacy.

The system should be scalable to support a growing number of students and courses.

2. Functional Requirements
2.1 Student Management
Add, update, and delete student details.

Store academic history, contact information, and course enrollments.

2.2 Course Management
Create and manage courses with details like name, description, and credits.

Assign teachers to courses.

Allow students to enroll and drop courses.

2.3 Gradebook Management
Teachers can input and update student grades.

Students can view their grades and academic progress.

2.4 Attendance Management
Teachers can mark attendance for each session.

Students can check their attendance records.

2.5 Notifications & Alerts
Notify students of important academic deadlines (enrollment, exam dates).

Alert students and teachers about attendance shortages and grade updates.

3. ER Diagram for Student Management System
The Entity-Relationship (ER) Diagram represents the relationships between different system components:

Entities and Relationships:
Student (Student_ID, Name, Email, Contact, Address)

Enrolls in → Course

Has → Grades

Has → Attendance

Course (Course_ID, Course_Name, Credits, Instructor_ID)

Assigned to → Instructor

Contains → Grades

Has → Attendance

Instructor (Instructor_ID, Name, Email, Department)

Teaches → Course

Assigns → Grades

Manages → Attendance

Gradebook (Grade_ID, Student_ID, Course_ID, Marks, Grade)

Belongs to → Student

Assigned by → Instructor

Attendance (Attendance_ID, Student_ID, Course_ID, Date, Status)

Linked to → Student

Recorded by → Instructor

ER:![ER](https://github.com/user-attachments/assets/44a7a17e-2b84-4457-bf77-96155b0a2cd2)

3NF: ![3NF](https://github.com/user-attachments/assets/a6cad2aa-5a4e-41c7-ad29-e0fce10eecb5)
