import json
import boto3
from boto3.dynamodb.conditions import Key
import logging
from os import getenv

dynamodb = boto3.resource('dynamodb')
table_name = getenv("USER_TABLE_NAME")
table = dynamodb.Table(table_name)


logging.basicConfig(format='%(asctime)s %("")s',
                    datefmt='%I:%M:%S %p')


def lambda_handler(event, context):
    logging.info(event)
    print({'event':event})
    try:
        if event['request']['challengeName'] != "CUSTOM_CHALLENGE":
            return event
        else:
            user_id = event['request']['userAttributes']['sub']
            email = event['request']['userAttributes']['email']
            email_code = get_email_code(email)
           
            print({'email_code': email_code})
            if email_code:
                event['response']['publicChallengeParameters'] = {}
                event['response']['privateChallengeParameters'] = {}
                event['response']['publicChallengeParameters']['question'] = "email code"
                event['response']['privateChallengeParameters']['answer'] = email_code
                print({'email event':event})
    except Exception as e:
        logging.error(e)
    print({'end event':event})
    return event
