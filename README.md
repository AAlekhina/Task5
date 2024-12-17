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
 - folder that contains a working file
   - conf_db.py - file with configuration settings


config.json - configuration for database in json file
logg - folder that contains setup for logging
logger_setup.py - file with setup
debug.log - log file that saves log messages
logging_conf.yml - configuration for logging
modules - folder that contains classes that operate within database
base_etl_class.py - abstraction class for ETL class
etl.py - conduction of ETL process considering creation the schema with tables in database
postgresdb.py - postgres class that contains ETL functions
queries - folder that contains SQL queries
query_age_diff.sql
query_gender.sql
query_list_of_rooms.sql
query_lowest_avg_age.sql
query_select_rooms.sql
query_select_students.sql
schema.sql - query to create the schema and tables in database
source - folder that contains files with the data
input_data - folder that contains input data
rooms.json - json with the information about rooms
students.json - json with the information about rooms
