CREATE TABLE hr_data (
    enrollee_id INT,
    city VARCHAR(100),
    city_development_index FLOAT,
    gender VARCHAR(50),
    relevent_experience VARCHAR(50),
    enrolled_university VARCHAR(100),
    education_level VARCHAR(100),
    major_discipline VARCHAR(100),
    experience VARCHAR(20),
    company_size VARCHAR(20),
    company_type VARCHAR(100),
    last_new_job VARCHAR(20),
    training_hours INT,
    target TINYINT
);

SELECT * FROM hr_data;

-- Populating Blank values in company_size, gender, enrolled_university, major_discipline, company_type with 'unknown'

SELECT DISTINCT company_size FROM hr_data;

UPDATE hr_data
SET company_size = REPLACE(company_size, '/', '-');
UPDATE hr_data
SET company_size = 'Unknown' WHERE company_size = '';

UPDATE hr_data
SET gender = 'Unknown' WHERE gender = '';
UPDATE hr_data
SET enrolled_university = 'Unknown' WHERE enrolled_university = '';
UPDATE hr_data
SET major_discipline = 'Unknown' WHERE major_discipline = '';
UPDATE hr_data
SET company_type = 'Unknown' WHERE company_type = '';

-- Cleaning experience column to make it uniform and populating the blank values with Median

SELECT DISTINCT experience
FROM hr_data
GROUP BY experience;

UPDATE hr_data
SET experience = '0.5' WHERE experience = '<1';
UPDATE hr_data
SET experience = '21' WHERE experience = '>20';
UPDATE hr_data
SET experience = NULL WHERE experience = '';

ALTER TABLE hr_data MODIFY experience FLOAT;

SELECT COUNT(*)/2 FROM hr_data WHERE experience IS NOT NULL; #9546

SELECT experience
FROM hr_data
WHERE experience IS NOT NULL
ORDER BY experience
LIMIT 1 OFFSET 9546; #9

UPDATE hr_data
SET experience = 9 WHERE experience IS NULL;

-- Cleaning last_new_job column to make it uniform and populating the blank values with Median

SELECT DISTINCT last_new_job
FROM hr_data;

UPDATE hr_data
SET last_new_job = '0' WHERE last_new_job = 'never';
UPDATE hr_data
SET last_new_job = '5' WHERE last_new_job = '>4';
UPDATE hr_data
SET last_new_job = NULL WHERE last_new_job = '';

ALTER TABLE hr_data MODIFY last_new_job FLOAT;

SELECT COUNT(*)/2 FROM hr_data WHERE last_new_job IS NOT NULL; #9367

SELECT last_new_job
FROM hr_data
WHERE last_new_job IS NOT NULL
ORDER BY last_new_job
LIMIT 1 OFFSET 9367; #1

UPDATE hr_data
SET last_new_job = 1 WHERE last_new_job IS NULL;

