from __future__ import print_function
import boto3
import os
from boto3.dynamodb.conditions import Key, Attr

dynamoDBResource = boto3.resource('dynamodb')

def lambda_handler(event, context):
    print(event)

    PlayerId = event["PlayerId"]
    filterText = event["text"]
    ddbTable = os.environ['TABLE_NAME']

    databaseItems = getDatabaseItems(dynamoDBResource, ddbTable, PlayerId, filterText)

    return databaseItems


def getDatabaseItems(dynamoDBResource, ddbTable, PlayerId, filterText):
    print("getDatabaseItems Function")
  
    table = dynamoDBResource.Table(ddbTable)

    records = table.query(
        KeyConditionExpression=Key("PlayerId").eq(PlayerId),
        FilterExpression=Attr("Performance").contains(filterText)
    )
    
    return records["Items"]