select * from hospital;

-- 1. Total Number of Patients 
select  hospital_name, sum(patients_count) as total_patients 
from hospital group by hospital_name;

-- 2. Average Number of Doctors per Hospital
select  hospital_name, avg(doctors_count) as avg_doctor_count
from hospital group by hospital_name;

-- Top 3 Departments with the Highest Number of Patients
select  department, sum(patients_count) as total_patients
from hospital 
group by department
order by total_patients desc
limit 3 ;

-- 4. Hospital with the Maximum Medical Expenses 
select * from hospital 
order by medical_expenses desc 
limit 1;

-- 5. Daily Average Medical Expenses 
select *, round(medical_expenses/(discharge_date-admission_date),2)
as daily_expense from hospital ;

-- 6. Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
select hospital_name, location, department, (discharge_date-admission_date) 
as longest_stayed_day from hospital 
order by longest_stayed_day desc limit 1;

-- 7. Count the total number of patients treated in each city. 
select location , sum(patients_count) as total_patients_treated 
from hospital 
group by location;

-- 8. Calculate the average number of days patients spend in each department. 
select department, round(avg(discharge_date-admission_date),2) as avg_spend_day 
from hospital 
group by department;

-- 9. Identify the Department with the Lowest Number of Patients
select department , sum(patients_count) as lowest_patient 
from hospital 
group by department 
order by lowest_patient asc 
limit 1;

SELECT 
  TO_CHAR(admission_date, 'YYYY-MM') AS month,
  ROUND(SUM(medical_expenses), 2) AS total_monthly_expense
FROM hospital
GROUP BY month
ORDER BY month;

