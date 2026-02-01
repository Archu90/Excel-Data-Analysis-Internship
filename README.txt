# Task 9: SQL Data Modeling – Star Schema

In this task, I designed a star schema data model using Oracle SQL.
The objective was to understand data warehouse modeling concepts
and how fact and dimension tables are used for analysis.

## Tables Created
- RAW_SALES (source table)
- DIM_CUSTOMER
- DIM_PRODUCT
- DIM_DATE
- DIM_REGION
- FACT_SALES

## Star Schema Design
FACT_SALES is the central table which contains sales transactions.
All dimension tables are connected to the fact table using
primary key and foreign key relationships.

## Analysis Performed
- Monthly sales analysis
- Sales by region
- Data validation using record counts

## Tools Used
- Oracle Live SQL
- draw.io (for star schema diagram)

## Conclusion
This task helped me understand how star schema improves
query performance and makes reporting easier.