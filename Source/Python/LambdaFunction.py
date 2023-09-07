import json
import boto3

client = boto3.client("dynamodb")
TableName = "MW-Metrics"

def Execute(event, context):
    data = client.get_item(
        TableName="MW-Metrics", Key={"Visitor Metric Counter": {"N": "Metric"}}
    )

    prevViewCount = data["Item"]["Quantity"]["N"]
    print(prevViewCount)

    return {"statusCode": 200, "body": data}
