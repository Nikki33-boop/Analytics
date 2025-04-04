-- Exploratory Data Analysis

SELECT * FROM layoffs_temp2;

SELECT MAX(total_laid_off) max_lay_offs, MAX(percentage_laid_off) max_percent_lay_offs
FROM layoffs_temp2;

-- viewed data on the basis of finacial status and total company layoff
SELECT * 
FROM layoffs_temp2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- data on the basis of total lay offs by each company
SELECT company, SUM(total_laid_off) 
FROM layoffs_temp2
GROUP BY 1
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`) 
FROM layoffs_temp2;

-- data on the basis of total lay offs in different industries
SELECT industry, SUM(total_laid_off)
FROM layoffs_temp2
GROUP BY 1
ORDER BY 2 DESC;

-- data on the basis of total lay offs as per the countries
SELECT country, SUM(total_laid_off)
FROM layoffs_temp2
GROUP BY 1
ORDER BY 2 DESC;

-- exploring layoffs on the basis of per year layoffs
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_temp2
GROUP BY 1;

-- exploring layoffs as per the size and type of the funding of the companies 
SELECT stage, SUM(total_laid_off)
FROM layoffs_temp2
GROUP BY 1
ORDER BY 2 DESC;

 -- layoffs differentiated as per each month of each year
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off)
FROM layoffs_temp2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- observing the rolling_sum (total increase over0 of the layoffs over the monthly basis
WITH rolling_sum AS
(
	SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS sum_total
	FROM layoffs_temp2
	WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
	GROUP BY 1
	ORDER BY 1
)
SELECT `month`, sum_total, SUM(sum_total) OVER (ORDER BY `month`) AS rolling_total
FROM rolling_sum;

-- exploring layoffs by each company per year
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_temp2
GROUP BY 1, 2
ORDER BY 3 DESC;


-- presented the data of the companies that have the most layoffs each year (top 5 for each year)
WITH company_year(company, years, total_lay_offs) AS
(
	SELECT company, YEAR(`date`), SUM(total_laid_off)
	FROM layoffs_temp2
	GROUP BY 1, 2
),
company_year_rank AS
(
	SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_lay_offs DESC) AS ranks
	FROM company_year
	WHERE years IS NOT NULL
)
SELECT * FROM company_year_rank
WHERE ranks <= 5;




