The project involved data cleaning and EDA for global layoffs dataset using MySQL. The goal was to clean, standardize, and analyze layoff trends across companies, industries, countries, and time periods

Phase 1: Data Cleaning and Preparation
Duplicate Removal: Employed ROW_NUMBER() within CTEs to detect and eliminate duplicate records
Standardization: Trimmed whitespace and corrected inconsistent text formats that included duplicates or inconsistency
Converted date strings into DATE format using STR_TO_DATE() 
Null & Blank Handling: Populated missing industry values using self-joins 
Removed non-informative rows where both total_laid_off and percentage_laid_off were null
Schema Optimization: Removed temporary and intermediate columns post-cleaning 

Phase 2: Exploratory Data Analysis (EDA)
Descriptive Analysis: Identified maximum layoffs by count and percentage
Analyzed companies with full layoffs (percentage_laid_off = 1.0) to assess financial impact
Aggregations: Summed total layoffs by company, industry, country, funding stage, and year
Detected industry sectors and countries with the highest overall layoffs
Temporal Trends: Used SUBSTRING() and YEAR() functions to analyze layoffs monthly and annually
Implemented a rolling sum CTE to observe the cumulative trend of layoffs over time
Company-Level Trends: Tracked yearly layoffs per company
Built a ranked view using DENSE_RANK() to highlight the top 5 companies with the most layoffs per year


