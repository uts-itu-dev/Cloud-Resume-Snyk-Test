import json
import boto3

client = boto3.client("dynamodb")
TableName = "MW-Metrics"

def Execute(event, context):
    data = client.get_item(
        TableName="MW-Metrics", Key={"VisitorMetric": {"S": "Visitor Metric Counter"}}
    )

    prevViewCount = data["Item"]["Metric"]["N"]
    print(prevViewCount)

    return {"statusCode": 200, "body": data}
