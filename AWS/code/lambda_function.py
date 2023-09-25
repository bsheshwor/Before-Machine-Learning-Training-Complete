import json
import pandas as pd
import urllib3
import boto3
import os
import psycopg2

s3 = boto3.client('s3')

url = "https://dummyjson.com/quotes"
http = urllib3.PoolManager()

def lambda_handler(event, context):
    response = http.request('GET', url)
    data = response.data.decode('utf-8')
    json_data = json.loads(data)
    df = pd.DataFrame(json_data['quotes'])
    back_to_json = df.to_json(orient='records', indent=2)
    # Adding raw json data to first S3 bucket (Extract)
    s3.put_object(
        Bucket='apprentice-training-ml-dev-bisheshwor-raw-data',
        Key='etl-raw-data/uncleaned_quotes.json',
        Body=back_to_json.encode('utf-8')
    )
    
    
    # Data transformation (Transform)
    data = response.data.decode('utf-8')
    json_data = json.loads(data)
    df_cleaned = pd.DataFrame(json_data['quotes'])
    df_cleaned.drop(['id', 'author'],axis=1, inplace=True)

    # Adding cleaned data to second S3 bucket after converting back to json (Load)
    back_to_json = df_cleaned.to_json(orient='records', indent=2)

    s3.put_object(
        Bucket='apprentice-training-ml-dev-bisheshwor-cleaned-data',
        Key='etl-clean-data/cleaned_quotes.json',
        Body=back_to_json.encode('utf-8')
    )
    
    # Connection parameters
    host = ''
    port = 5432
    dbname = ''
    user = ''
    password = ''
    
    # Establish the connection
    try:
        connection = psycopg2.connect(
            host=host,
            port=port,
            dbname=dbname,
            user=user,
            password=password
        )
        cursor = connection.cursor()
    
        # SQL query to create a new table
        for index, row in df.iterrows():
            create_table_query = """
            INSERT INTO bisheshwor (
                id,
                quote,
                author)
                VALUES
                (%s, %s, %s);
            """
        
            # Execute the query to create the table
            cursor.execute(create_table_query, (
                row['id'],
                row['quote'],
                row['author']))
        connection.commit()
        print("Data Inserted Successfully")
    
    except psycopg2.Error as e:
        print("Error while connecting to or working with the database:", e)
    
    finally:
        if connection:
            cursor.close()
            connection.close()

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }