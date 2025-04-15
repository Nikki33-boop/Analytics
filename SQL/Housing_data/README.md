The project includes data cleaning and transformation using Microsoft SQL Server.

Date Standardization: Converted inconsistent SaleDate formats into a standardized DATE type
Populating the address incase of Null values: Used self-joins to populate missing PropertyAddress fields based on matching ParcelID, ensuring data completeness
Address Parsing: Decomposed concatenated address fields (PropertyAddress and OwnerAddress) into structured components such as street address, city, and state using SUBSTRING, CHARINDEX, and PARSENAME functions
Categorical Cleaning: Standardized binary values in the SoldAsVacant column by replacing 'Y'/'N' with 'Yes'/'No' to enhance readability 
Duplicate Removal: Identified and removed duplicate records using a ROW_NUMBER() CTE approach
Schema Optimization: Dropped redundant columns (PropertyAddress, SaleDate, OwnerAddress, TaxDistrict) after extracting relevant components, resulting in a cleaner data
