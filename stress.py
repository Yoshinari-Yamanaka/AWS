#-*- encoding:utf-8 -*-
from concurrent.futures import ThreadPoolExecutor
import json
import os
import sys
#Third Party
import requests

SETTING = {}
with open("setting.json","r") as f:
    SETTING = json.load(f)

def get():
    requests.get(
        f"https://{SETTING['RestApiId']}.execute-api.ap-northeast-1.amazonaws.com/test/target_lambda",
        params={"message" : "Start"}
    )

if __name__ == "__main__":
    with ThreadPoolExecutor(max_workers=os.cpu_count()) as executor:
        for _ in range(10):
            executor.submit(get)