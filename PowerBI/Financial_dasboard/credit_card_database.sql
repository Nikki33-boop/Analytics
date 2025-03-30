--create a database for adding queries

CREATE DATABASE credit_card_db


--creating a table in the credit_card_database for importing the credit card data from the CSV file
CREATE TABLE credit_card_detail(
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
)

--creating a table in the credit_card_database for importing the customer data from the CSV file

CREATE TABLE cust_detail (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
)

--bulk inserting the data into the previously created table from the csv files already holding the data

BULK INSERT credit_card_detail
FROM "C:\Users\nikit\OneDrive\Desktop\New folder\PowerBI\Data\credit_card.csv" 
WITH
(
    FIELDTERMINATOR = ',', -- Delimiter (comma for CSV)
	ROWTERMINATOR = '\n',   -- Row delimiter
    FIRSTROW = 2     
)

--bulk inserting the data into the previously created table from the csv files already holding the data

BULK INSERT cust_detail
FROM "C:\Users\nikit\OneDrive\Desktop\New folder\PowerBI\Data\customer_.csv" 
WITH
(
    FIELDTERMINATOR = ',', -- Delimiter (comma for CSV)
	ROWTERMINATOR = '\n',   -- Row delimiter
    FIRSTROW = 2     
)

--adding additional data into both the tables created in the SQL database to help draw real-time insights

BULK INSERT credit_card_detail
FROM "C:\Users\nikit\OneDrive\Desktop\New folder\PowerBI\Data\cc__add.csv" 
WITH
(
    FIELDTERMINATOR = ',', -- Delimiter (comma for CSV)
	ROWTERMINATOR = '\n',   -- Row delimiter
    FIRSTROW = 2     
)

BULK INSERT cust_detail
FROM "C:\Users\nikit\OneDrive\Desktop\New folder\PowerBI\Data\cust__add.csv" 
WITH
(
    FIELDTERMINATOR = ',', -- Delimiter (comma for CSV)
	ROWTERMINATOR = '\n',   -- Row delimiter
    FIRSTROW = 2     
)
