from __future__ import print_function
import boto3
import os
from contextlib import closing

dynamoDBResource = boto3.resource('dynamodb')
pollyClient = boto3.client('polly')
s3Client = boto3.client('s3', endpoint_url='https://s3.' +
                        os.environ['AWS_REGION'] + '.amazonaws.com')


def lambda_handler(event, context):

    print(event)

    PlayerId = event["PlayerId"]
    MatchId = event["MatchId"]
    VoiceId = event['VoiceId']
    mp3Bucket = os.environ['BUCKET_NAME']
    ddbTable = os.environ['TABLE_NAME']

    text = getPerformance(dynamoDBResource, ddbTable, PlayerId, MatchId)
    filePath = createMP3File(pollyClient, text, VoiceId, MatchId)
    signedURL = hostFileOnS3(s3Client, filePath, mp3Bucket, PlayerId, MatchId)

    return signedURL


def getPerformance(dynamoDBResource, ddbTable, PlayerId, MatchId):
    print("getPerformance Function")

    table = dynamoDBResource.Table(ddbTable)
    records = table.get_item(
        Key={
            'PlayerId': PlayerId,
            'MatchId': int(MatchId)
        }
    )

    return records['Item']['Performance']


def createMP3File(pollyClient, text, VoiceId, MatchId):
    print("createMP3File Function")

    pollyResponse = pollyClient.synthesize_speech(
        OutputFormat='mp3',
        Text = text,
        VoiceId = VoiceId
    )

    if "AudioStream" in pollyResponse:
        postId = str(MatchId)
        with closing(pollyResponse["AudioStream"]) as stream:
            filePath = os.path.join("/tmp/", postId)
            with open(filePath, "wb") as file:
                file.write(stream.read())

    return filePath


def hostFileOnS3(s3Client, filePath, mp3Bucket, PlayerId, MatchId):
    print("hostFileOnS3 Function")

    s3Client.upload_file(filePath, 
    mp3Bucket, 
    PlayerId+'/'+MatchId+'.mp3')

    os.remove(filePath)

    url = s3Client.generate_presigned_url(
        ClientMethod='get_object',
        Params={
            'Bucket': mp3Bucket,
            'Key': PlayerId+'/'+MatchId+'.mp3'
        }
    )

    return url
