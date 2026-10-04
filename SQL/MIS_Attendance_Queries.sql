-- MIS Executive Employee Attendance Project
CREATE DATABASE IF NOT EXISTS mis_attendance;
USE mis_attendance;
CREATE TABLE employees (
 employee_id VARCHAR(10) PRIMARY KEY,
 employee_name VARCHAR(100),
 department VARCHAR(50),
 designation VARCHAR(50)
);
CREATE TABLE attendance (
 attendance_date DATE,
 employee_id VARCHAR(10),
 employee_name VARCHAR(100),
 department VARCHAR(50),
 designation VARCHAR(50),
 status VARCHAR(20),
 check_in TIME NULL,
 check_out TIME NULL,
 work_hours DECIMAL(5,2),
 FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
SELECT COUNT(*) AS total_employees FROM employees;
SELECT status, COUNT(*) AS records FROM attendance GROUP BY status ORDER BY records DESC;
SELECT department, COUNT(*) AS records,
 SUM(status IN ('Present','Late','WFH')) AS attended,
 ROUND(100*SUM(status IN ('Present','Late','WFH'))/COUNT(*),2) AS attendance_rate
FROM attendance GROUP BY department ORDER BY attendance_rate DESC;
SELECT DATE_FORMAT(attendance_date,'%Y-%m') AS month,
 ROUND(100*SUM(status IN ('Present','Late','WFH'))/COUNT(*),2) AS attendance_rate
FROM attendance GROUP BY DATE_FORMAT(attendance_date,'%Y-%m') ORDER BY month;
SELECT employee_id, employee_name, department, COUNT(*) AS records,
 SUM(status IN ('Present','Late','WFH')) AS attended,
 ROUND(100*SUM(status IN ('Present','Late','WFH'))/COUNT(*),2) AS attendance_rate
FROM attendance GROUP BY employee_id, employee_name, department ORDER BY attendance_rate DESC;
SELECT employee_id, employee_name, department, SUM(status='Late') AS late_days
FROM attendance GROUP BY employee_id, employee_name, department ORDER BY late_days DESC;
SELECT department, ROUND(AVG(NULLIF(work_hours,0)),2) AS avg_work_hours
FROM attendance GROUP BY department ORDER BY avg_work_hours DESC;
SELECT employee_id, employee_name, department,
 ROUND(100*SUM(status IN ('Present','Late','WFH'))/COUNT(*),2) AS attendance_rate
FROM attendance GROUP BY employee_id, employee_name, department
HAVING attendance_rate < 90 ORDER BY attendance_rate;
SELECT department, SUM(status='WFH') AS wfh_days,
 ROUND(100*SUM(status='WFH')/COUNT(*),2) AS wfh_percentage
FROM attendance GROUP BY department ORDER BY wfh_days DESC;
SELECT attendance_date,
 SUM(status IN ('Present','Late','WFH')) AS attended,
 SUM(status='Absent') AS absent, SUM(status='Late') AS late
FROM attendance GROUP BY attendance_date ORDER BY attendance_date;
