# Medical History Data Analysis — Technical Report

**Prepared by:** Abdul Khadar J  
**Tool Used:** MySQL (Local Instance)  
**Date:** 2025  

---

## 1. PROJECT OVERVIEW

This project involves analyzing a medical history dataset comprising patient records, hospital admissions, insurance claims, and related clinical data. The objective is to implement a structured relational database in MySQL and address 34 key business/analytical requirements through optimized SQL queries.

**Dataset Sources:**
- patients.csv — Core patient demographic and health information
- admissions.csv — Hospital admission and discharge records
- diagnoses.csv — ICD diagnosis codes per admission
- insurance.csv — Payer and insurance details

**Tools & Technologies:**
- Database: MySQL 8.x (Local Instance)
- Query Language: SQL
- Documentation: Markdown

---

## 2. DATABASE IMPLEMENTATION

### 2.1 Database Setup

The raw CSV files were imported into a local MySQL instance. A dedicated database schema was created to house all tables with appropriate primary and foreign key constraints.

```sql
CREATE DATABASE medical_history_db;
USE medical_history_db;
```

### 2.2 Table Structure

| Table | Primary Key | Description |
|-------|-------------|-------------|
| patients | patient_id | Demographics, vitals, allergies |
| admissions | admission_id | Hospital stay records |
| diagnoses | diagnosis_id | ICD-coded diagnoses |
| insurance | insurance_id | Payer and coverage details |

---

## 3. DATA CLEANING & PRE-PROCESSING

### 3.1 Allergy Data Standardization

The `allergies` column in the patients table contained inconsistent formats (e.g., `No Known Allergies`, `NKA`, `None`, blank values). These were standardized before querying:

```sql
UPDATE patients
SET allergies = 'No Known Allergies'
WHERE allergies IS NULL OR TRIM(allergies) = '' OR allergies IN ('NKA', 'None', 'none');
```

### 3.2 Date Formatting

All date fields (`admission_date`, `discharge_date`, `date_of_birth`) were validated and converted to `DATE` format to ensure consistent filtering and age calculations.

### 3.3 Handling NULL Values

NULL values in numeric fields (weight, height) and categorical fields (city, province) were identified and handled with either default substitution or exclusion in relevant queries.

---

## 4. KEY ANALYTICAL QUERIES

All 34 business requirements were addressed. Below are highlights from each category:

### A. Patient Demographics

**Active vs. Inactive Patients**
```sql
SELECT is_hypertensive, COUNT(*) AS total
FROM patients
GROUP BY is_hypertensive;
```

**Patients with No Known Allergies**
```sql
SELECT patient_id, first_name, last_name
FROM patients
WHERE allergies = 'No Known Allergies';
```

### B. Hospital Admissions Analysis

**Average Length of Stay by Diagnosis**
```sql
SELECT primary_diagnosis,
       ROUND(AVG(DATEDIFF(discharge_date, admission_date)), 2) AS avg_stay_days
FROM admissions
GROUP BY primary_diagnosis
ORDER BY avg_stay_days DESC;
```

**Admissions by Month**
```sql
SELECT MONTH(admission_date) AS month,
       COUNT(*) AS total_admissions
FROM admissions
GROUP BY month
ORDER BY month;
```

### C. Demographic Weight Distribution

**Patients Grouped by Weight Intervals**
```sql
SELECT (FLOOR(weight / 10) * 10) AS weight_group,
       COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;
```

---

## 5. CONCLUSION

The analysis successfully addresses all 34 business requirements. By migrating the data to a local MySQL instance, data cleaning (specifically for allergies and formatting) was handled without compromising server integrity. The resulting database is optimized for clinical decision support and administrative reporting.

**Key Outcomes:**
- 34 SQL queries developed and validated
- Data cleaned and standardized for consistency
- Modular folder structure for easy navigation and reproducibility

---

## 6. ATTACHMENTS

```
Medical-History-Data-Analysis/
├── 01_Datasets/                  # Raw CSV files (patients, admissions, etc.)
├── 02_SQL_Scripts/
│   └── medical_history_queries.sql  # All 34 SQL queries
└── 03_Documentation/
    └── Technical_Report.md       # This technical report
```
