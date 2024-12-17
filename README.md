# Task 3.  Financial dashboard
This project is for educational purposes only
***
### Description of the task

**Client:** Construction company

**Type of activity:** Construction services for different clients. 

**Description:**
We have a lot of country departments. Every department is responsible for some construction projects. Every project has a special type of financial metrics (budget - planned, actual - fact, forecast - predicted, see details in excels).

**Request:** The client wants to have all the data in excel inside the database and have the code that upload the data in database, create the codel and as a result of work - an analytical dashboard for financial metrics on projects, in which they can have not only the same report as in excel (Import sheet), but top 30 projects on net sales order intake metrics (actual, budget and forecast). As well the client would like to have a data mart in the database which should be used for report.The design can be improved and agreed with the client. Additional visualization ideas are also welcome.

# Description of the repository
 This project contains the following working files:
 - config 
   - mail.py - file for configuring access to PostgreSQL
 - data_ingestion
   - Load_from_excel - loading data from Excel into Python
 - data_processing
   - data_processing.jpynb - cleaning and processing data in Python
 - data_upload_postgres
   - data_upload_postgres.jpynb - loading processed data into PostgreSQL
 - source -  folder that contains files with the data
 - sql - folder that contains SQL queries
   - Company.sql
   - copy_into_csv.sql
   - create_schema_import.sql
   - create_datamart.sql
   - import_sql
 - visualisation - Tableau dashboard
   - FiD.twbx
 - docker-compose.yml 

