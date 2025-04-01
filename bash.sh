#!/data/data/com.termux/files/usr/bin/bash

# Ensure script runs with UNIX line endings
sed -i 's/\r$//' "$0"

# Update Termux packages
echo "Updating packages..."
pkg update -y && pkg upgrade -y

# Install Node.js (includes npm)
echo "Installing Node.js and npm..."
pkg install -y nodejs

# Install MariaDB
echo "Installing MariaDB..."
pkg install -y mariadb

# Initialize MariaDB if not already initialized
if [ ! -d "$PREFIX/var/lib/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db
fi

# Start MariaDB server in the background using mysqld_safe
echo "Starting MariaDB server..."
mysqld_safe --datadir=$PREFIX/var/lib/mysql > /dev/null 2>&1 &
sleep 5

# Variables
DEPLOY_PASSWORD="Str0ngPassw0rd!"
DB_NAME="your_database_name"

# Set up MariaDB user and grant privileges
echo "Setting up MariaDB user..."
mysql -u root <<EOF
CREATE USER IF NOT EXISTS 'deploy_user'@'localhost' IDENTIFIED BY '$DEPLOY_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'deploy_user'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Create Database and All Tables
echo "Creating database and tables..."
mysql -u deploy_user -p"$DEPLOY_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
USE ${DB_NAME};

-- Table: Student
CREATE TABLE IF NOT EXISTS Student (
    Student_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50)
);

-- Table: Address
CREATE TABLE IF NOT EXISTS Address (
    Address_ID INT PRIMARY KEY,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);

-- Table: StudentAddress
CREATE TABLE IF NOT EXISTS StudentAddress (
    Student_Address_ID INT PRIMARY KEY,
    Student_ID INT,
    Address_ID INT,
    Address_Type VARCHAR(50),
    Is_Current BOOLEAN,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID)
);

-- Table: StudentContact
CREATE TABLE IF NOT EXISTS StudentContact (
    Contact_ID INT PRIMARY KEY,
    Student_ID INT,
    Contact_Type VARCHAR(50),
    Contact_Value VARCHAR(100),
    Is_Primary BOOLEAN,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

-- Table: CourseDescription
CREATE TABLE IF NOT EXISTS CourseDescription (
    Course_ID INT PRIMARY KEY,
    Description TEXT,
    Learning_Objectives TEXT,
    Prerequisites TEXT
);

-- Table: Course (FK to CourseDescription)
CREATE TABLE IF NOT EXISTS Course (
    Course_ID INT PRIMARY KEY,
    Course_Code VARCHAR(50),
    Course_Name VARCHAR(100),
    Credits INT,
    FOREIGN KEY (Course_ID) REFERENCES CourseDescription(Course_ID)
);

-- Table: Instructor
CREATE TABLE IF NOT EXISTS Instructor (
    Instructor_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50)
);

-- Table: Department
CREATE TABLE IF NOT EXISTS Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100),
    Description TEXT
);

-- Table: DepartmentInstructor
CREATE TABLE IF NOT EXISTS DepartmentInstructor (
    Dept_Instructor_ID INT PRIMARY KEY,
    Department_ID INT,
    Instructor_ID INT,
    Start_Date DATE,
    End_Date DATE,
    Is_Active BOOLEAN,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);

-- Table: CourseOffering
CREATE TABLE IF NOT EXISTS CourseOffering (
    Offering_ID INT PRIMARY KEY,
    Course_ID INT,
    Instructor_ID INT,
    Academic_Term VARCHAR(50),
    Academic_Year VARCHAR(10),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);

-- Table: StudentCourse
CREATE TABLE IF NOT EXISTS StudentCourse (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Offering_ID INT,
    Enroll_Date DATE,
    Status VARCHAR(50),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Offering_ID) REFERENCES CourseOffering(Offering_ID)
);

-- Table: Grade
CREATE TABLE IF NOT EXISTS Grade (
    Grade_ID INT PRIMARY KEY,
    Enrollment_ID INT,
    Assessment_Type VARCHAR(50),
    Marks FLOAT,
    Letter_Grade VARCHAR(10),
    Grading_Date DATE,
    FOREIGN KEY (Enrollment_ID) REFERENCES StudentCourse(Enrollment_ID)
);

-- Table: Room
CREATE TABLE IF NOT EXISTS Room (
    Room_ID INT PRIMARY KEY,
    Building VARCHAR(100),
    Room_Number VARCHAR(50),
    Capacity INT
);

-- Table: CourseSchedule
CREATE TABLE IF NOT EXISTS CourseSchedule (
    Schedule_ID INT PRIMARY KEY,
    Offering_ID INT,
    Day VARCHAR(20),
    Start_Time TIME,
    End_Time TIME,
    FOREIGN KEY (Offering_ID) REFERENCES CourseOffering(Offering_ID)
);

-- Table: CourseScheduleRoom
CREATE TABLE IF NOT EXISTS CourseScheduleRoom (
    Schedule_Room_ID INT PRIMARY KEY,
    Schedule_ID INT,
    Room_ID INT,
    Effective_From DATE,
    Effective_To DATE,
    FOREIGN KEY (Schedule_ID) REFERENCES CourseSchedule(Schedule_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

-- Table: Attendance
CREATE TABLE IF NOT EXISTS Attendance (
    Attendance_ID INT PRIMARY KEY,
    Schedule_ID INT,
    Attendance_Date DATE,
    FOREIGN KEY (Schedule_ID) REFERENCES CourseSchedule(Schedule_ID)
);

-- Table: AttendanceDetail
CREATE TABLE IF NOT EXISTS AttendanceDetail (
    Detail_ID INT PRIMARY KEY,
    Attendance_ID INT,
    Student_ID INT,
    Status VARCHAR(50),
    Time_In TIME,
    Time_Out TIME,
    FOREIGN KEY (Attendance_ID) REFERENCES Attendance(Attendance_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

-- Table: InstructorContact
CREATE TABLE IF NOT EXISTS InstructorContact (
    Contact_ID INT PRIMARY KEY,
    Instructor_ID INT,
    Contact_Type VARCHAR(50),
    Contact_Value VARCHAR(100),
    Is_Primary BOOLEAN,
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);
EOF

echo "Database setup completed."

# Set up backend directory and files
echo "Setting up Node.js backend and frontend..."
mkdir -p backend/public
cd backend

# Initialize Node.js project if not already done
if [ ! -f "package.json" ]; then
    npm init -y
fi

# Install required packages: express, mysql, cors, path
npm install express mysql cors

# Create server.js (backend code)
cat <<'EOL' > server.js
const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const path = require("path");

const app = express();
app.use(cors());
app.use(express.static("public")); // Serve frontend files

// Configure MySQL connection using environment variables
const db = mysql.createConnection({
    host: "localhost",
    user: "deploy_user",
    password: process.env.DB_PASSWORD || "Str0ngPassw0rd!",
    database: process.env.DB_NAME || "your_database_name"
});

db.connect(err => {
    if (err) {
        console.error("Database connection failed:", err);
        return;
    }
    console.log("Connected to database.");
});

// API endpoint to fetch data from a specified table
app.get("/fetchData", (req, res) => {
    const table = req.query.table;
    if (!table) {
        return res.status(400).json({ error: "Table name is required" });
    }
    const sql = "SELECT * FROM ??";
    db.query(sql, [table], (err, results) => {
        if (err) {
            console.error("Database query error:", err);
            return res.status(500).json({ error: "Database query failed" });
        }
        res.json(results);
    });
});

// Serve frontend index.html
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "public", "index.html"));
});

app.listen(3000, () => {
    console.log("Server is running on port 3000");
});
EOL

# Create frontend files in backend/public

# index.html
cat <<'EOL' > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Data Fetcher</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1>Fetch Data from Database</h1>
  <label for="tableSelect">Select Table:</label>
  <select id="tableSelect">
    <option value="Student">Student</option>
    <option value="Address">Address</option>
    <option value="StudentAddress">StudentAddress</option>
    <option value="StudentContact">StudentContact</option>
    <option value="CourseDescription">CourseDescription</option>
    <option value="Course">Course</option>
    <option value="Instructor">Instructor</option>
    <option value="Department">Department</option>
    <option value="DepartmentInstructor">DepartmentInstructor</option>
    <option value="CourseOffering">CourseOffering</option>
    <option value="StudentCourse">StudentCourse</option>
    <option value="Grade">Grade</option>
    <option value="Room">Room</option>
    <option value="CourseSchedule">CourseSchedule</option>
    <option value="CourseScheduleRoom">CourseScheduleRoom</option>
    <option value="Attendance">Attendance</option>
    <option value="AttendanceDetail">AttendanceDetail</option>
    <option value="InstructorContact">InstructorContact</option>
  </select>
  <button onclick="fetchData()">Fetch Data</button>
  <table id="dataTable">
    <thead></thead>
    <tbody></tbody>
  </table>
  <script src="script.js"></script>
</body>
</html>
EOL

# styles.css
cat <<'EOL' > public/styles.css
body {
  font-family: Arial, sans-serif;
  text-align: center;
  margin: 20px;
}
table {
  width: 80%;
  margin: 20px auto;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #ddd;
  padding: 8px;
}
th {
  background-color: #f4f4f4;
}
EOL

# script.js
cat <<'EOL' > public/script.js
function fetchData() {
  const table = document.getElementById("tableSelect").value;
  fetch(`/fetchData?table=${table}`)
    .then(response => response.json())
    .then(data => {
      const tableHead = document.querySelector("#dataTable thead");
      const tableBody = document.querySelector("#dataTable tbody");
      tableHead.innerHTML = "";
      tableBody.innerHTML = "";
      if (data.length > 0) {
        const headers = Object.keys(data[0]);
        const headerRow = document.createElement("tr");
        headers.forEach(header => {
          const th = document.createElement("th");
          th.textContent = header;
          headerRow.appendChild(th);
        });
        tableHead.appendChild(headerRow);
        data.forEach(row => {
          const tr = document.createElement("tr");
          headers.forEach(header => {
            const td = document.createElement("td");
            td.textContent = row[header];
            tr.appendChild(td);
          });
          tableBody.appendChild(tr);
        });
      } else {
        tableBody.innerHTML = "<tr><td colspan='100%'>No data found</td></tr>";
      }
    })
    .catch(error => console.error("Error fetching data:", error));
}
EOL

# Start the backend server in the background
echo "Starting the Node.js server..."
nohup node server.js > backend.log 2>&1 &

cd ..

echo "Deployment completed!"
echo "To access the application, open your browser and navigate to http://localhost:3000"
