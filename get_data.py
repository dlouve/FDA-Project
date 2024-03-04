import requests
import pandas as pd
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

# Initialize variables
limit = 1000  # Number of rows to retrieve per request
skip = 0      # Initial value for skipping results
all_results = []  # List to store all results

# API endpoint drugs/enforcement
url = 'https://api.fda.gov/drug/enforcement.json?api_key=XXXXXXXXXXX=report_date:[20230101+TO+20231231]&limit={}&skip={}'  

while True:
    # Make API request
    response = requests.get(url.format(limit, skip))
    
    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the JSON response
        data = response.json()
        
        # Extract relevant information from JSON
        results = data['results']
        
        # Append results to the list
        all_results.extend(results)
        
        # Increment skip for the next request
        skip += limit
        
        # Break the loop if no more results are available
        if len(results) < limit:
            break
    else:
        print('Failed to fetch data from the API:', response.status_code)
        break

# To create a table in Snowflake with the correct data types and lengths, the maximum length per attribute is determined here
max_lengths = {}
for col in data.columns:
    max_length_index = data[col].apply(lambda x: len(str(x))).idxmax()
    max_length = len(str(data.loc[max_length_index, col]))
    max_lengths[col] = {'Row': max_length_index, 'Max Length': max_length}

# Print the result
for col, info in max_lengths.items():
    print(f'Column: {col}, Row: {info["Row"]}, Max Length: {info["Max Length"]}')

# Convert all results to a DataFrame to have a first look at data
data = pd.DataFrame(all_results)
#print(data)

#data.to_csv('enforcement.csv', index=False)
# Convert DataFrame to JSON string to load it into blob storage
json_data = data.to_json(orient='records', lines=True)
print(json_data)

# Azure Blob Storage credentials
connection_string = "XXXXXXXXXXXXX"
container_name = "fda-data/raw-data"
blob_name = "fda_raw.json"

# Upload file to Azure Blob Storage
blob_service_client = BlobServiceClient.from_connection_string(connection_string)
container_client = blob_service_client.get_container_client(container_name)
blob_client = container_client.get_blob_client(blob_name)
blob_client.upload_blob(json_data.encode('utf-8'), overwrite=True)
print("JSON data uploaded to Azure Blob Storage successfully.")
