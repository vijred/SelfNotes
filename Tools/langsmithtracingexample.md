Sample file with Langsmith tracing 
```
from dotenv import load_dotenv
load_dotenv()

import os
from langsmith.wrappers import wrap_openai
from langsmith import traceable
from openai import AzureOpenAI

# Azure configuration — IMPORTANT
client = wrap_openai(
    AzureOpenAI(
        api_key=os.getenv("api_key"),
        api_version=os.getenv("api_version"),
        azure_endpoint=os.getenv("api_base")  # Must end with /openai
    )
)

DEPLOYMENT_NAME = os.getenv("deployment_name")  # NOT gpt-4o !!!

@traceable
def pipeline(user_input: str):
    response = client.chat.completions.create(
        model=os.getenv("api_model") ,
        messages=[{"role": "user", "content": user_input}],
    )
    return response.choices[0].message.content

print(pipeline("convert Hello, world! to french"))


```

Sample .env 
```
LANGCHAIN_TRACING_V2=true
LANGCHAIN_ENDPOINT="https://mylangsmithinstance.mydomain.com/api/v1"
LANGCHAIN_API_KEY="lsv2_pt_sadfdfdsfqedfdsfdsfdsafads_Sdfdfd21789"
LANGCHAIN_PROJECT="default-myprojectname"

LANGSMITH_RUN_COMPRESSION_THREADS=0
DISABLE_RUN_COMPRESSION=true


api_base = "https://myendpoint.openai.azure.com/"
api_type = "azure"
api_version = "2024-12-01-preview" # Ensure to use the correct version based on Azure deployment
api_key = "afsadfdfdfsaafasd"
api_model="gpt-5-chat"
deployment_name="gpt-5-chat"

```


Usage of Langgraph from postgresql server using SQL query 
```
        SELECT date, count(distinct thread_id) as distinct_thread_ids, count(thread_id) as Queries, count(distinct user_id) as distinct_users
        FROM (
            SELECT thread_id, 
                  (checkpoint->>'ts')::date as date, metadata->'user_id' as user_id
            FROM public.checkpoints 
            where metadata->>'source' = 'input'
        ) AS subquery
        group by date
        ORDER BY date DESC
        LIMIT 1000
```
