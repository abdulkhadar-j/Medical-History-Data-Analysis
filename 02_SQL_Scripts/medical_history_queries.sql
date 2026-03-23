-- ============================================================
-- PROJECT: Medical History Data Analysis
-- Author:  Abdul Khadar J
-- Domain:  Data Analytics | Healthcare
-- Date:    March 2026
-- Tool:    MySQL Workbench 8.0
-- ============================================================

-- Setup
USE medical;
SET SQL_SAFE_UPDATES = 0;

-- Preview all tables
SELECT * FROM patients;
SELECT COUNT(*) FROM admissions;
SELECT * FROM doctors;
SELECT * FROM province_names;

-- ============================================================
-- DATA CLEANING
-- ============================================================

-- Q5: Update NULL allergies to 'NKA' (No Known Allergies)
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

-- ============================================================
-- ANALYTICAL QUERIES
-- ============================================================

-- Q1: Show first name, last name, and gender of Male patients
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

-- Q2: Show first name and last name of patients with no allergies
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;

-- Q3: Show first name of patients starting with letter 'C'
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';

-- Q4: Show first and last name of patients with weight between 100 and 120
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

-- Q6: Show full name as a single concatenated column
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Q7: Show first name, last name, and full province name for each patient
SELECT p.first_name, p.last_name, pn.province_name
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id;

-- Q8: Show how many patients have birth year 2010
SELECT COUNT(*) AS total
FROM patients
WHERE YEAR(birth_date) = 2010;

-- Q9: Show first name, last name, and height of the tallest patient
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

-- Q10: Show all columns for specific patient IDs
SELECT *
FROM patients
WHERE patient_id IN (1, 10, 800, 45);

-- Q11: Show total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- Q12: Show admissions where patient was admitted and discharged on same day
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- Q13: Show total admissions for patient_id 579
SELECT COUNT(*) AS patient_admissions
FROM admissions
WHERE patient_id = 579;

-- Q14: Show unique cities in province 'NS'
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';

-- Q15: Patients with height > 160 and weight > 70
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70;

-- Q16: Show unique birth years ordered ascending
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;

-- Q17: Show unique first names that appear only once
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

-- Q18: Patients whose first name starts and ends with 's' and is at least 6 chars long
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
  AND LENGTH(first_name) >= 6;

-- Q19: Show patients whose diagnosis is 'Dementia'
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

-- Q20: Display every patient's first name ordered by name length, then alphabetically
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;

-- Q21: Total count of male and female patients
SELECT gender, COUNT(*) AS total_count
FROM patients
GROUP BY gender;

-- Q22: Patients where first name equals last name
SELECT first_name, last_name
FROM patients
WHERE first_name = last_name;

-- Q23: Patients admitted multiple times for the same diagnosis
SELECT patient_id, diagnosis, COUNT(*) AS total_admissions
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- Q24: City-wise patient count ordered most to least, then city name ASC
SELECT city, COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC, city ASC;

-- Q25: Show first name, last name, and role (Patient or Doctor) for all persons
SELECT first_name, last_name, 'Patient' AS role FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role FROM doctors;

-- Q26: All allergies ordered by popularity (excluding NULL)
SELECT allergies, COUNT(*) AS popularity
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY popularity DESC;

-- Q27: Patients born in the 1970s, ordered by earliest birthdate
SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date BETWEEN '1970-01-01' AND '1979-12-31'
ORDER BY birth_date ASC;

-- Q28: Full name: LASTNAME,firstname (uppercase last, lowercase first) ordered by first_name DESC
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

-- Q29: Province IDs where total patient height >= 7000 cm
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING total_height >= 7000;

-- Q30: Difference between largest and smallest weight for patients with last name 'Maroni'
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- Q31: Count of admissions per day of the month (1-31), ordered by most admissions
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS total_admissions
FROM admissions
GROUP BY day_of_month
ORDER BY total_admissions DESC;

-- Q32: Weight groups (10kg intervals) with patient count, ordered by group DESC
SELECT FLOOR(weight / 10) * 10 AS weight_group, COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- Q33: isObese flag (BMI > 30 = 1, else 0)
SELECT patient_id, weight, height,
  CASE
    WHEN weight / POWER(height / 100, 2) > 30 THEN 1
    ELSE 0
  END AS isObese
FROM patients;

-- Q34: Patients with Epilepsy diagnosis seen by doctor named Lisa
SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';

-- ============================================================
-- END OF SCRIPT
-- ============================================================
