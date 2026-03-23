# Medical History Data Analysis

![SQL](https://img.shields.io/badge/SQL-MySQL-blue) ![Domain](https://img.shields.io/badge/Domain-Healthcare%20Analytics-green) ![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

## Overview

This project involves the management and analysis of a comprehensive healthcare database. The dataset includes information regarding patient demographics, hospital admission cycles, and physician specialties. The primary objective was to perform data cleaning and execute **34 analytical SQL queries** to provide actionable insights for hospital administration.

> **Intern:** Abdul Khadar J | **Domain:** Data Analytics – Healthcare | **Date:** March 2026

---

## Table of Contents

- [Project Overview](#overview)
- [Database Setup](#database-setup)
- [Data Cleaning](#data-cleaning)
- [Dataset Descriptions](#dataset-descriptions)
- [Key Analytical Queries](#key-analytical-queries)
- [Folder Structure](#folder-structure)
- [How to Run](#how-to-run)
- [Tools Used](#tools-used)
- [Conclusion](#conclusion)

---

## Database Setup

Due to administrative restrictions on the remote project server, a local MySQL environment was established to facilitate data transformation and query execution.

- **Database Schema Name:** `medical`
- **Tools Used:** MySQL Workbench 8.0, CSV Data Import Wizard
- **Security Setting:** `SET SQL_SAFE_UPDATES = 0` (to allow necessary data cleaning)

### Data Architecture

| Table | Description |
|---|---|
| `patients` | Unique identifiers, physical attributes (height, weight), demographics |
| `admissions` | Timeline of patient stays, diagnoses, and assigned doctors |
| `doctors` | Master table of healthcare providers and their clinical specialties |
| `province_names` | Reference table mapping provincial codes to full geographic names |

---

## Data Cleaning

Before performing analysis, a critical update was performed to ensure data integrity:

- **Problem:** The `allergies` column contained multiple NULL entries, which could lead to medical errors or reporting gaps.
- **Solution:** All NULL values were standardized to `NKA` (No Known Allergies).

```sql
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;
```

---

## Dataset Descriptions

| File | Description |
|---|---|
| `patients.csv` | Demographic data, height, weight, allergies |
| `admissions.csv` | Records of hospital stays, dates, and diagnoses |
| `doctors.csv` | Master list of physicians and their specialties |
| `province_names.csv` | Mapping of province codes to full province names |

---

## Key Analytical Queries

Below is a selection of high-value queries demonstrating the analytical capabilities of the project. The full set of **34 queries** is available in the attached `.sql` script.

### A. Basic Patient Filtering
```sql
-- Show patients whose gender is Male
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

-- Show patients with no allergies
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;
```

### B. Clinical Risk Assessment – BMI Analysis
```sql
-- Identify obese patients (BMI > 30)
SELECT patient_id, weight, height,
  CASE
    WHEN weight / POWER(height / 100, 2) > 30 THEN 1
    ELSE 0
  END AS isObese
FROM patients;
```

### C. Operational Reporting – Cross-Table Join
```sql
-- Patients with Epilepsy seen by doctor named Lisa
SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';
```

### D. Demographic Weight Distribution
```sql
-- Group patients into 10kg weight intervals
SELECT FLOOR(weight / 10) * 10 AS weight_group,
       COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;
```

### E. Province-wise & City-wise Analysis
```sql
-- Show full province name for each patient
SELECT p.first_name, p.last_name, pn.province_name
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id;

-- Cities in province NS
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';
```

---

## Folder Structure

```
Medical-History-Data-Analysis/
├── 01_Datasets/
│   ├── patients.csv
│   ├── admissions.csv
│   ├── doctors.csv
│   └── province_names.csv
├── 02_SQL_Scripts/
│   └── medical_history_queries.sql
├── 03_Documentation/
│   └── Medical_Analytics_Technical_Report.pdf
└── README.md
```

---

## How to Run

1. Open **MySQL Workbench** and create a new schema named `medical`.
2. Run the following to allow data cleaning:
   ```sql
   SET SQL_SAFE_UPDATES = 0;
   ```
3. Use the **Table Data Import Wizard** to import the 4 CSV files into their respective tables.
4. Open and execute `medical_history_queries.sql` to run all 34 analytical queries.

---

## Tools Used

| Tool | Purpose |
|---|---|
| MySQL Workbench 8.0 | Query writing, execution, and database management |
| CSV Data Import Wizard | Importing raw data into MySQL tables |
| SQL | Data cleaning, joins, aggregations, and analysis |

---

## Conclusion

This analysis successfully addresses all 34 business requirements. By migrating the data to a local MySQL instance, data cleaning (specifically for allergies and formatting) was handled without compromising server integrity. The resulting database is optimized for clinical decision support and administrative reporting.

**Key highlights:**
- Data Standardization: Updated NULL allergies to `NKA`
- Health Metrics: BMI calculation to identify obesity (BMI > 30)
- Operational Joins: Linking patients to doctors and diagnoses
- Demographic Analysis: Weight groups, birth years, city-wise patient counts

---

## Connect

- **LinkedIn:** [linkedin.com/in/iabdulkhadarj](https://linkedin.com/in/iabdulkhadarj)
- **GitHub:** [github.com/abdulkhadar-j](https://github.com/abdulkhadar-j)
