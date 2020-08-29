#-*- encoding:utf-8 -*-
import json
import os
import sys
import time
#Third Party
import boto3

def lambda_handler(event,context):
    time.sleep(6)
    return {
        "statusCode" : 200,
        "body" : json.dumps({"message" : "OK"})
    }