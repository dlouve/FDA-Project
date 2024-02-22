# FDA-Project
Project Target
This data engineering project aims to leverage the FDA API to extract data, which will then be stored in Azure Blob Storage. Subsequently, Azure Data Factory will be utilized for data cleaning and transformation processes. The transformed data will be loaded into Snowflake to facilitate the generation of insights. Finally, Tableau will be employed for visualizing the data, enabling comprehensive analysis and interpretation.

# Data Source
The openFDA drug enforcement reports API returns data from the FDA Recall Enterprise System (RES), a database that contains information on recall event information submitted to FDA. Currently, this data covers publicly releasable records from 2004-present. This project works with data from 01.01.2023 to 31.12.2023

# Technologies
This project utilizes a variety of technologies, including Python, Microsoft Azure services like Data Factory and Blob Storage, Snowflake, and Tableau.

# Technical To Do's
pip install snowflake-connector-python
check the snowflake connector is installed: pip list | Select-String snowflake
pip install azure-storage-blob
pip install requests
pip install pandas
install visual studio code
install python
create a azure account 
create a snowflake account
create a tableau account


