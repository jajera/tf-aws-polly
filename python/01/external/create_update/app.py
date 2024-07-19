from __future__ import print_function
import boto3
import os

dynamoDBResource = boto3.resource('dynamodb')

def lambda_handler(event, context):   
    print(event)
    
    PlayerId = event["PlayerId"]
    MatchId = event['MatchId']
    Goals = event['Goals']
    Assists = event['Assists']
    MinutesPlayed = event['MinutesPlayed']
    Performance = event['Performance']
    ddbTable = os.environ['TABLE_NAME']
    
    newMatchId = upsertItem(dynamoDBResource, ddbTable, PlayerId, MatchId, Goals, Assists, MinutesPlayed, Performance)

    return newMatchId


def upsertItem(dynamoDBResource, ddbTable, PlayerId, MatchId, Goals, Assists, MinutesPlayed, Performance):
    print('upsertItem Function')

    table = dynamoDBResource.Table(ddbTable)
    table.put_item(
        Item={
            'PlayerId': PlayerId,
            'MatchId': int(MatchId),
            'Goals': int(Goals),
            'Assists': int(Assists),
            'MinutesPlayed': int(MinutesPlayed),
            'Performance': Performance
        }
    )
    return MatchId
