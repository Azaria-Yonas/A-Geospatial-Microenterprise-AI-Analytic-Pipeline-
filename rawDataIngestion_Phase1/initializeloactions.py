import psycopg
import os
import asyncio
import aiohttp
import requests
import json

from zipcodes import get_zipcodes
from boundingBox import find_bbox


DB_KEY = os.getenv("dbKey")
USER = os.getenv("psqlUser")


zipCodes = get_zipcodes("secondrun",USER, DB_KEY)

async def func():
    coor = {}
    for zip in zipCodes:
        url = "https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/PUMA_TAD_TAZ_UGA_ZCTA/MapServer/11/query?where=ZCTA5='{}'&returnGeometry=true&outSR=4326&f=pjson"
        con = requests.get(url.format(zip))

        print(f"{zip} : {find_bbox(con.json())}")

asyncio.run(func())










