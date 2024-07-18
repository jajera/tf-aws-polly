from __future__ import print_function
import boto3
import os

dynamoDBResource = boto3.resource('dynamodb')

def lambda_handler(event, context):

    print(event)

    PlayerId = event["PlayerId"]
    MatchId = event["MatchId"]

    ddbTable = os.environ['TABLE_NAME']
    deletedMatchId = deleteItem(dynamoDBResource, ddbTable, PlayerId, MatchId)

    return deletedMatchId


def deleteItem(dynamoDBResource, ddbTable, PlayerId, MatchId):
    print('deleteItem function')

    table = dynamoDBResource.Table(ddbTable)

    table.delete_item(
        Key={
            'PlayerId': PlayerId,
            'MatchId': int(MatchId)
        }
    )

    return MatchId
