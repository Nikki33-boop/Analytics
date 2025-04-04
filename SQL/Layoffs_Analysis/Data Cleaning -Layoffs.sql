-- Data Cleaning
SELECT * FROM layoffs;

-- Remove Duplicates, Standarize data, Find NULL/Blank values, remove unneccesary columns & rows

-- creating temp table
CREATE TABLE layoffs_temp LIKE layoffs;

SELECT * FROM layoffs_temp;

INSERT layoffs_temp
SELECT * FROM layoffs;

 -- creating a second temporary table to be able to delete the newly inserted columns or subquery results
WITH duplicate_cte AS 
(
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM layoffs_temp
)
SELECT * FROM duplicate_cte WHERE row_num > 1;

CREATE TABLE `layoffs_temp2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL, 
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_temp2
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM layoffs_temp;

-- DELETING DUPLICATES    
DELETE FROM layoffs_temp2
WHERE row_num > 1;


SELECT * FROM layoffs_temp2;

-- Standardizing Data 

UPDATE layoffs_temp2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_temp2
ORDER BY 1;

SELECT DISTINCT industry
FROM layoffs_temp2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_temp2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location
FROM layoffs_temp2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_temp2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_temp2
WHERE country LIKE 'United States%';

UPDATE layoffs_temp2
SET country  = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States.%';

SELECT `date`
FROM layoffs_temp2;

UPDATE layoffs_temp2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_temp2
MODIFY COLUMN `date` DATE;


SELECT * FROM layoffs_temp2
WHERE total_laid_off IS NULL AND
percentage_laid_off IS NULL;

SELECT * FROM layoffs_temp2
WHERE industry IS NULL OR
industry = ''; 

SELECT * FROM layoffs_temp2
WHERE company LIKE 'Bally%';

SELECT * 
FROM layoffs_temp2 t1
LEFT JOIN layoffs_temp2 t2
	ON t1.company = t2.company
WHERE ((t1.industry IS NULL OR t1.industry = '') AND t2.industry IS NOT NULL);

UPDATE layoffs_temp2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_temp2 t1
LEFT JOIN layoffs_temp2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE ((t1.industry IS NULL OR t1.industry = '') AND t2.industry IS NOT NULL);

DELETE FROM layoffs_temp2
WHERE total_laid_off IS NULL AND
percentage_laid_off IS NULL;

ALTER TABLE layoffs_temp2
DROP COLUMN row_num;

SELECT * FROM layoffs_temp2;


