
# Import necessary libraries
from azure.eventhub import EventHubProducerClient, EventData
import json

# Replace these placeholders with your actual values
EVENT_HUB_CONNECTION_STRING = "Endpoint=sb://testvjeventhubns.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=fsadfsdfsdafsdafdsfasdfsdaf+AEhMfKNPA="
EVENT_HUB_NAME = "vjeventhub1"

# Create a producer client to send messages to the event hub.
producer = EventHubProducerClient.from_connection_string(conn_str=EVENT_HUB_CONNECTION_STRING, eventhub_name=EVENT_HUB_NAME)

def eventhub_send_message(data):
    try:
        # Create a batch.
        event_data_batch = producer.create_batch()

        # Add events to the batch.
        event_data_batch.add(EventData(data))

        # Send the batch of events to the event hub.
        producer.send_batch(event_data_batch)
        print(f"Sent: {data}")

    except Exception as e:
        print(f"Error: {str(e)}")
    # finally:
    #     # Close the producer after sending messages.
    #     producer.close()




def json_eventhub_send_message(payload):
    try:
        data = json.dumps(payload).encode("utf-8")

        event = EventData(data)
        event.content_type = "application/json"        # optional but helpful
        event.properties = {"eventType": "inventory", "schemaVersion": "1.0"}  # optional

        with producer:
            batch = producer.create_batch()  
            batch.add(event)
            producer.send_batch(batch)        
            print(f"Sent: {data}")
    except Exception as e:
        print(f"Error: {str(e)}")


# # Example data
example_data = "{Message: Hello, how are you}"
json_data = {
    "event": "test_event 69",
    "timestamp": "2023-10-20T10:00:00Z",
    "details": {
        "description": "This is a test JSON event."
    }
}


# # Send the text data to Event Hub
# eventhub_send_message("Event came from vj laptop 6")


# # Send the JSON data to Event Hub
json_eventhub_send_message(json_data)



producer.close()
