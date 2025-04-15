
-- CLEANING DATA IN SQL QUERIES

SELECT * FROM Housing_data;

-- Standardize date format

SELECT SaleDateConverted, CONVERT(DATE, SaleDate) 
FROM Housing_data;


ALTER TABLE Housing_data
ADD SaleDateConverted DATE;

UPDATE Housing_data
SET SaleDateConverted = CONVERT(DATE, SaleDate);


-- Populate property address

SELECT * 
FROM Housing_data
WHERE PropertyAddress is null

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
FROM Housing_data a
JOIN Housing_data b
ON a.ParcelID = b.ParcelID
WHERE a.[UniqueID ] <> b.[UniqueID ] 
AND a.PropertyAddress is NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Housing_data a
JOIN Housing_data b
ON a.ParcelID = b.ParcelID
WHERE a.[UniqueID ] <> b.[UniqueID ] 
AND a.PropertyAddress is NULL

-- Breaking Address into Address, city state

SELECT PropertyAddress 
FROM Housing_data

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS CITY
FROM Housing_data

ALTER TABLE Housing_data
ADD PropertyAddressSplit NVARCHAR(255);

UPDATE Housing_data
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE Housing_data
ADD PropertyAddressCity NVARCHAR(255);

UPDATE Housing_data
SET PropertyAddressCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT * FROM Housing_data;


SELECT OwnerAddress FROM dbo.Housing_data;

SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM dbo.Housing_data

ALTER TABLE Housing_data
ADD OwnerAddressSplit NVARCHAR(255);

UPDATE Housing_data
SET OwnerAddressSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE Housing_data
ADD OwnerAddressCity NVARCHAR(255);

UPDATE Housing_data
SET OwnerAddressCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE Housing_data
ADD OwnerAddressState NVARCHAR(255);

UPDATE Housing_data
SET OwnerAddressState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

 
 -- change Y and N in Sold As Vacant

 SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant)
 FROM Housing_data
 GROUP BY SoldAsVacant
 ORDER BY 2

 SELECT SoldAsVacant,
 CASE 
	WHEN SoldAsVacant = 'N' THEN 'No'  
	WHEN SoldAsVacant = 'Y' THEN 'Yes' 
	ELSE SoldAsVacant
	END
 FROM Housing_data

 UPDATE Housing_data
 SET SoldAsVacant =  CASE 
	WHEN SoldAsVacant = 'N' THEN 'No'  
	WHEN SoldAsVacant = 'Y' THEn 'Yes' 
	ELSE SoldAsVacant
	END


-- Remove Duplicates

WITH T1 AS
(
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference ORDER BY UniqueID) AS row_num
	FROM Housing_data
)
DELETE FROM T1
WHERE row_num > 1

--SELECT * FROM T1
--WHERE row_num > 1


-- Remove unused columns

SELECT * FROM Housing_data

ALTER TABLE Housing_data
DROP COLUMN PropertyAddress, SaleDate, OwnerAddress, TaxDistrict