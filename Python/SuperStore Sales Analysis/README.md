The steps performed for Exploratory Data Analysis involve the following:

Library Imports
Essential libraries for data manipulation and visualization: pandas, numpy, matplotlib.pyplot, and seaborn.

Data Loading & Inspection
Data read from Superstore_USA.xlsx

Shape: 9,426 rows × 24 columns
Initial inspection done with .head() and .isnull().sum()

Data Cleaning
Found missing values only in Product Base Margin (72 nulls)
Imputed with the mean value of the column

Data Type Check
Verified that Order Date and Ship Date are datetime types.


Key Outputs and Insights

1. Order Priority Distribution
Most orders fall under:
High: 1,970 orders
Low: 1,926 orders
Not Specified: 1,881 orders
Medium: 1,844 orders
Critical: 1,805 orders
A visualization showed that all priority levels are fairly balanced, but “High” and “Low” are slightly more common.


2. Shipping Mode Analysis
Orders by shipping mode:
Regular Air: 7,036 (≈ 74.6%)
Delivery Truck: 1,283 (≈ 13.6%)
Express Air: 1,107 (≈ 11.7%)
Pie chart and bar chart visuals confirm that Regular Air is by far the most used.


3. Shipping Mode vs. Product Category
Countplot shows how different shipping methods are used across Office Supplies, Technology, and Furniture.
Office Supplies appear to dominate most shipping methods.

4. Customer Segment Distribution
Bar chart shows orders are split across:
Corporate
Consumer
Home Office
Segment-wise differences can inform targeted marketing strategies.


5. Product Category and Sub-Category Insights
Each main category (Office Supplies, Technology, Furniture) was broken down into sub-categories.
Office Supplies had a more diverse set of sub-categories compared to Furniture and Technology.
These visualizations can help in analyzing which sub-products drive category performance.

6. The time series graph shows that the order count has consistently increaed from 2010 to 2013
