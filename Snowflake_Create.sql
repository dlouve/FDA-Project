/*Create a Warehouse*/
CREATE WAREHOUSE IF NOT EXISTS warehouse_fda
WITH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE;
    
/*Create a Database*/
CREATE DATABASE IF NOT EXISTS database_fda;

/*Create a SCHEMA*/
CREATE SCHEMA IF NOT EXISTS schema_fda;


/*Prework for creating a table in snowflake*/
----------------
# To create a table in Snowflake with the correct data types and lengths, the maximum length per attribute is determined here
max_lengths = {}
for col in data.columns:
    max_length_index = data[col].apply(lambda x: len(str(x))).idxmax()
    max_length = len(str(data.loc[max_length_index, col]))
    max_lengths[col] = {'Row': max_length_index, 'Max Length': max_length}

# Print the result
for col, info in max_lengths.items():
    print(f'Column: {col}, Row: {info["Row"]}, Max Length: {info["Max Length"]}')
-------------------

/*Create a TABLE*/
CREATE TABLE IF NOT EXISTS enforcement (
    country VARCHAR(13),
    city VARCHAR(19),
    address_1 VARCHAR(39),
    reason_for_recall VARCHAR(390),
    address_2 VARCHAR(38),
    product_quantity VARCHAR(114),
    code_info VARCHAR(16361),
    center_classification_date DATE,
    distribution_pattern VARCHAR(713),
    state VARCHAR(2),
    product_description VARCHAR(4000),
    report_date DATE,
    classification VARCHAR(9),
    openfda VARCHAR(1981),
    recalling_firm VARCHAR(60),
    recall_number VARCHAR(11),
    initial_firm_notification VARCHAR(81),
    product_type VARCHAR(5),
    event_id VARCHAR(5),
    termination_date DATE,
    more_code_info VARCHAR(3),
    recall_initiation_date DATE,
    postal_code VARCHAR(10),
    voluntary_mandated VARCHAR(25),
    status VARCHAR(10) 
);
