
-- =====================================================
-- SQL DATA CLEANING PROJECT - LAYOFFS DATASET
-- SQL Data Cleaning Project
-- =====================================================
-- Remove duplicates 
-- Standardize the data 
-- Null values or blank values 
-- Remove any columns 
-- =====================================================
-- 1. CREATE STAGING TABLE
-- =====================================================

CREATE TABLE layoffs_staging
LIKE layoffs;

-- =====================================================
-- 2. COPY RAW DATA INTO STAGING TABLE
-- =====================================================

INSERT INTO layoffs_staging
SELECT *
FROM layoffs;

-- =====================================================
-- 3. REMOVE DUPLICATES
-- =====================================================

WITH layoffs_staging_cte AS
(
SELECT *,
ROW_NUMBER() OVER
(
PARTITION BY company,
location,
industry,
total_laid_off,
percentage_laid_off,
`date`,
stage,
country,
funds_raised_millions
) AS row_num
FROM layoffs_staging
)

SELECT *
FROM layoffs_staging_cte
WHERE row_num > 1;

-- =====================================================
-- 4. CREATE SECOND STAGING TABLE
-- =====================================================

CREATE TABLE layoffs_staging2
SELECT *,
ROW_NUMBER() OVER
(
PARTITION BY company,
location,
industry,
total_laid_off,
percentage_laid_off,
`date`,
stage,
country,
funds_raised_millions
) AS row_num
FROM layoffs_staging;

-- =====================================================
-- 5. REMOVE DUPLICATES
-- =====================================================
SET sql_safe_updates = 0;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- =====================================================
-- 6. STANDARDIZE DATA
-- =====================================================

-- Remove Spaces in Company Names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Standardize Crypto Industry
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Clean Country Formatting
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- =====================================================
-- 7. FIX DATE FORMAT
-- =====================================================

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- =====================================================
-- 8. HANDLE NULL / BLANK VALUES
-- =====================================================

-- Replace Blank Industry with NULL
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Fill Missing Industry Values
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
AND t1.location = t2.location

SET t1.industry = t2.industry

WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- =====================================================
-- 9. REMOVE UNNECESSARY ROWS
-- =====================================================

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- =====================================================
-- 10. DROP HELPER COLUMN
-- =====================================================

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- =====================================================
-- FINAL CLEANED DATA
-- =====================================================

SELECT *
FROM layoffs_staging2;
