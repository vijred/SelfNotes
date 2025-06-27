
import snowflake.snowpark as snowpark
import bs4
from snowflake.snowpark import functions as F
from snowflake.snowpark import Session, DataFrame
from snowflake.snowpark.types import StructType, StructField, StringType, IntegerType
from snowflake.snowpark.functions import udf, col, substr
from datetime import datetime, timedelta
import re

# define variables 
delaydays = 2
sourceemailtablefullpath = 'SDFDSFD.V1.SOURCE_EMAIL'
destemailtablefullpath = 'DSFDSFSD.ADSFDSAF.DESTEMAIL'

connection_parameters = {
    "role": "ASFDSAFSD",  # Role with appropriate access rights
    "warehouse": "SDFDSFD",  # Warehouse to use
    "database": "SAFDSF",  # Database name
    "schema": "DSFDSFD"  # Schema name
}

# Create a session with the defined connection parameters
session = Session.builder.configs(connection_parameters).create()

# Execute the main function
def main(session):

    #beautiful Soup function to remove tags     
    def extract_text_from_html(html_content):  
        try:
            soup = bs4.BeautifulSoup(html_content, 'html.parser')
            return soup.get_text()
        except bs4.FeatureNotFound as e:
            # Handle specific BeautifulSoup feature not found error
            return ""
        except Exception as e:
            # Handle other exceptions
            return ""

    #register udf 
    extract_text_udf = session.udf.register(extract_text_from_html, return_type=StringType(), input_types=[StringType()])
 
    #regex function to remove attachment 
    def remove_attachments2(email_content: str) -> str:
        # Extract the main boundary from the headers
        main_boundary_match = re.search(r'boundary="([^"]+)"', email_content)
        if not main_boundary_match:
            return email_content  # If no boundary is found, return the original content
        
        # # main_boundary = main_boundary_match.group(0) # Group(0) results full value like boundary="blah----blah"
        boundary = main_boundary_match.group(1) #Group(1) returns only the boundary value, "blah----blah"

        attachment_pattern = (
            rf'--{re.escape(boundary)}\r?\n'
            r'Content-Type: [^;]+; name="[^"]+"\r?\n'
            r'Content-Transfer-Encoding: base64\r?\n'
            r'Content-[^\r\n]+?\r?\n\r?\n'
            r'(?:[A-Za-z0-9+/=\r?\n]+?)'
            r'(?=--' + re.escape(boundary) + r'(--)?(?:\s|$))'
        )

        # Remove matched sections
        cleaned_content = re.sub(attachment_pattern, '', email_content, flags=re.DOTALL)
    
        return cleaned_content

    # registed udf
    remove_attachments2_udf = session.udf.register(remove_attachments2, return_type=StringType(), input_types=[StringType()])

    nodataschema = StructType([StructField("No data", StringType())])
    emailDateFilter = datetime.now().date();
    dateAdjustment = timedelta(days=delaydays)
    emailDateFilter = emailDateFilter - dateAdjustment

    # How to pass in a parameter during SQL Query 
    sql_query = f"SELECT * FROM {sourceemailtablefullpath} where cast(COL1 as DATE) < ?"
    datalakeList = session.sql(sql_query, params=[emailDateFilter]).collect()    
    # Check if the list is empty
    if not datalakeList:
        return session.createDataFrame([], nodataschema)

    datalakeFile = session.createDataFrame(datalakeList)
    number_of_records = datalakeFile.count()
    print("Number of records read:", number_of_records)

    datalakeFile = datalakeFile.with_column("COL2", datalakeFile["FDSAFDS"].cast(StringType(134217728)))
    datalakeFile = datalakeFile.withColumn("COL343", F.regexp_extract(F.col("ADSFDSF"), r"Message_ID: <(.*?)>", 1))
    datalakeFile = datalakeFile.withColumn("CCCCC", F.split(F.col("DSAFDSFDSFD"), F.lit(r'[,;]')))
    
    # Filter inbound and outbound based on some dondition
    datalakeFileOutbound = datalakeFile.filter(F.col("sadfdsaf") != 0)
    datalakeFileInbound = datalakeFile.filter(F.col("sadfdsaf") == 0)

    # Either add a new column to snowpark data fram or update values of existing column
    datalakeFileInbound = datalakeFileInbound.withColumn("SAFDSA", F.regexp_extract(F.col("mimemailTEXT"), r"References: <(.*?)>", 1))

    # join dataframe to a different data frame 
    datalakeFileOutbound_w_ref = datalakeFileOutbound.join(datalakeFileInbound.select("ASFDSFSD", "DSFDSFDSFA"), on="SDFDSFD", how="left").select(datalakeFileInbound.columns)

    # Reading table as a session 
    blah_table = session.table(destemailtablefullpath)

    datalakeFileOutbound_w_ref = datalakeFileOutbound_w_ref.alias("outbound").join(
    blah_table.select("SADFDSAF", "asfddsaf").alias("asdfdsafds"),
    on="adsfdsaf",
    how="left"
    )

    # If conditions, and data maniupulations 
    datalakeFileOutbound_w_ref = datalakeFileOutbound_w_ref.withColumn(
        "asdfdsafds",
        F.when(
            (F.col("asfsdaaf").isNull()) | (F.col("dsafdsafds") == ""),
            F.col("dsafdsafds")
        ).otherwise(F.col("adfdf"))
    ).drop("afdsf", "fsadsafdsa")

    # Use UDF functions to either add new column or modify values of existing column 
    datalakeFileIn = datalakeFileInbound.withColumn('asdf', extract_text_udf(datalakeFileInbound['mimemailTEXT']))
    datalakeFileOut = datalakeFileOutbound_w_ref.withColumn('adsf', extract_text_udf(datalakeFileOutbound['mimemailTEXT']))

    columns = ['IMFMediaID', 'IMSEPCID', 'MediaRelationType', 'MediaSender', 'MediaRecipients', 'MediaDate', 'ContactReason',
           'ContactReasonDetail', 'ContactType', 'Skill', 'AgentName', 'CustomerID', 'SystemStartDateTime', 'SourceAddress', 'DestinationAddress', 'Subject', 'mimemailTEXT', 'LoadDate', 'new_truncated_text', 'Message_ID', 'to_email_list', 'Reference']

    # Select the specified columns
    datalakeFileIn = datalakeFileIn.select(columns).with_column("mimemailTEXT", datalakeFileIn["mimemailTEXT"].cast(StringType(134217728)))
    datalakeFileOut = datalakeFileOut.select(columns).with_column("mimemailTEXT", datalakeFileIn["mimemailTEXT"].cast(StringType(134217728)))


    datalakeFileIn = datalakeFileIn.withColumn('new_truncated_text_REMOVEATTACHMENTS', remove_attachments2_udf(datalakeFileIn['new_truncated_text']))
    datalakeFileOut = datalakeFileOut.withColumn('new_truncated_text_REMOVEATTACHMENTS', remove_attachments2_udf(datalakeFileOut['new_truncated_text']))

    datalakeFileIn = datalakeFileIn.withColumn('new_truncated_text_TRUNCATE',  substr(col('new_truncated_text'), 1, 16777216))
    datalakeFileOut = datalakeFileOut.withColumn('new_truncated_text_TRUNCATE', substr(col('new_truncated_text'), 1, 16777216))

    # Save selected columns form snowpark data frame into Snowflake SQL Table 
    datalakeFileOut.select("IMFMEDIAID", "IMSEPCID", "MEDIARELATIONTYPE", "MEDIASENDER", "MEDIARECIPIENTS", "MEDIADATE", "CONTACTREASON", "CONTACTREASONDETAIL", "CONTACTTYPE", "SKILL", "AGENTNAME", "CUSTOMERID", "SYSTEMSTARTDATETIME", "SOURCEADDRESS", "DESTINATIONADDRESS", "SUBJECT", "mimemailTEXT", "LOADDATE","new_truncated_text", "MESSAGE_ID", "TO_EMAIL_LIST", "REFERENCE", "new_truncated_text_REMOVEATTACHMENTS", "new_truncated_text_TRUNCATE").write.mode("append").save_as_table(destemailtablefullpath)
    datalakeFileIn.select("IMFMEDIAID", "IMSEPCID", "MEDIARELATIONTYPE", "MEDIASENDER", "MEDIARECIPIENTS", "MEDIADATE", "CONTACTREASON", "CONTACTREASONDETAIL", "CONTACTTYPE", "SKILL", "AGENTNAME", "CUSTOMERID", "SYSTEMSTARTDATETIME", "SOURCEADDRESS", "DESTINATIONADDRESS", "SUBJECT", "mimemailTEXT", "LOADDATE", "new_truncated_text", "MESSAGE_ID", "TO_EMAIL_LIST", "REFERENCE", "new_truncated_text_REMOVEATTACHMENTS", "new_truncated_text_TRUNCATE").write.mode("append").save_as_table(destemailtablefullpath)
    
    #dummy data frame for return value
    data = [("VK", "Doe"), ("Alice", "Smith")]
    df = session.create_dataframe(data, schema=["first_name", "last_name"])

    return datalakeFileOut.limit(1)
    # return datalakeFileIn.limit(1)
