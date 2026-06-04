# SQL Data Cleaning Project – Layoffs Dataset

## Project Overview

This project focuses on cleaning and transforming a layoffs dataset using SQL in MySQL.

The goal of this project was to prepare raw data for analysis by identifying and removing duplicates, standardizing inconsistent values, handling missing data, and cleaning formatting issues.

This project was completed as part of practical SQL learning and demonstrates real-world data cleaning techniques commonly used by Data Analysts.

---

## Tools Used

* MySQL
* SQL
* MySQL Workbench
* GitHub

---

## Skills Demonstrated

* Data Cleaning in SQL
* Window Functions (`ROW_NUMBER()`)
* Common Table Expressions (CTEs)
* Removing Duplicate Records
* Data Standardization
* Handling Null and Blank Values
* Self Joins
* Date Formatting (`STR_TO_DATE`)
* Data Transformation

---

## Data Cleaning Process

### 1. Created a Staging Table

Created a duplicate working table to avoid modifying the raw dataset.

### 2. Removed Duplicates

Used `ROW_NUMBER()` and `PARTITION BY` to identify duplicate records and remove unnecessary duplicates.

### 3. Standardized Data

* Removed extra spaces using `TRIM()`
* Standardized industry values (e.g., Crypto variations)
* Cleaned country formatting inconsistencies

### 4. Cleaned Date Format

Converted date values into proper SQL date format using `STR_TO_DATE()`.

### 5. Handled Missing Values

* Identified null and blank values
* Updated missing industry values using self joins
* Removed rows with insufficient layoff information

### 6. Final Cleanup

Removed helper columns and prepared the cleaned dataset for further analysis.

---

## Project Outcome

Successfully transformed raw layoffs data into a clean and analysis-ready dataset using SQL.

This project strengthened practical SQL skills and improved understanding of real-world data cleaning workflows used in analytics.

