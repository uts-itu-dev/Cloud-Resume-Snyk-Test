import json
import boto3

Client = boto3.client("dynamodb")
TableName = "MW-Metrics"

def Execute(event, context):
    Data = Client.get_item(
        TableName="MW-Metrics", Key={"VisitorMetric": {"S": "Visitor Metric Counter"}}
    )

    Metric = Data["Item"]["Metric"]["N"]

    return { "statusCode": 200, "body": Metric }
