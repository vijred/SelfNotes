## This example is to listen to the eventhub events and print - 

from azure.eventhub import EventHubConsumerClient

EVENT_HUB_CONNECTION_STRING = "Endpoint=sb://testvjeventhubns.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=asdfsdafsdafafasdfsad+AEhMfKNPA="
EVENT_HUB_NAME = "vjeventhub1"
CONSUMER_GROUP = "$Default"


def process_events(partition_context, event):
    # Print the event data
    print(f"Event received from partition {partition_context.partition_id}: {event.body_as_str()}")
    partition_context.update_checkpoint(event)  # Update the checkpoint to the current event

client = EventHubConsumerClient.from_connection_string(
    conn_str=EVENT_HUB_CONNECTION_STRING,
    consumer_group=CONSUMER_GROUP,
    eventhub_name=EVENT_HUB_NAME
)

try:
    with client:
        client.receive(
            on_event=process_events,
            starting_position="@latest"  # Start from the latest position
        )
except KeyboardInterrupt:
    print("Stopped.")
