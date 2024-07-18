from __future__ import print_function
import boto3
import os
from boto3.dynamodb.conditions import Key

dynamoDBResource = boto3.resource('dynamodb')

def lambda_handler(event, context):
    print(event)

    ddbTable = os.environ['TABLE_NAME']
    databaseItems = getDatabaseItems(dynamoDBResource, ddbTable, event)

    return databaseItems


def getDatabaseItems(dynamoDBResource, ddbTable, event):
    print("getDatabaseItems Function")

    table = dynamoDBResource.Table(ddbTable)

    if "PlayerId" in event:
        PlayerId = event['PlayerId']
        records = table.query(KeyConditionExpression=Key("PlayerId").eq(PlayerId))
    else:
        records = table.scan()

    return records["Items"]
