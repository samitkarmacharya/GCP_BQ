from google.cloud import storage
import os
from dotenv import load_dotenv

load_dotenv()

service_account_json_path = os.environ["GCP_SERVICE_ACCOUNT_PATH"]
storage_client = storage.Client.from_service_account_json(service_account_json_path)


bucket_name = os.environ["GCS_BUCKET_NAME"]
if not bucket_name:
    print("GCS_BUCKET_NAME environment variable not set")
    exit()

def CreateBucket(bucket_name):
    """Creates a new bucket."""
    try:
        bucket = storage_client.CreateBucket(bucket_name)
        print("Bucket {} created".format(bucket.name))
    except Exception as e:
        print(e)
        return
    
CreateBucket(bucket_name)