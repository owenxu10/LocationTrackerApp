#!/usr/bin/env python

import MySQLdb
from socket import *
import sys
from decimal import Decimal
import urllib2
import os, time

TCP_IP = '10.211.55.6'
TCP_PORT = 9999
BUFFER_SIZE = 40
DB_HOST = 'localhost'
DB_USER = 'gpsDbUser'
DB_PASS = '6204'
DB_NAME = 'gpsDB'

def setTimezone(lat, lon):
	APIURL = "http://www.askgeo.com/api/1603001/sol2hekmat2u1ha2lqr6u7npr5/timezone.json?points=%s%%2c%s" %(lat, lon)
	json = urllib2.urlopen(APIURL).read()
	(true,false,null) = (True,False,None)
	timezone = eval(json)
	tz = timezone["data"][0]["timeZone"]
	os.environ['TZ'] = tz
	time.tzset()

# Connect to MySQL Database:
try:
	db = MySQLdb.connect (host = DB_HOST, user = DB_USER,
	passwd = DB_PASS, db = DB_NAME)
except MySQLdb.Error, e:
	print "Error %d: %s" %(e.args[0], e.args[1])
	sys.exit(1);

cursor = db.cursor()

s = socket(AF_INET, SOCK_STREAM)    # create a TCP socket
s.bind((TCP_IP, TCP_PORT))            # bind it to the server port
print "Listening..."
s.listen(5)                         # allow 5 simultaneous
                                    # pending connections

while 1:
    # wait for next client to connect
    conn, addr = s.accept() # connection is a new socket
    print 'Accpeted Connection from: ', addr
    while 1:
        data = conn.recv(1024) # receive up to 1K bytes
	print 'Data: '
        if data:
		#print data;
		if (data.find(",") > -1):
			dataArr = data.split(",")
			validID = validLat = validLon = 0
			for indx in dataArr:

				if (indx.find("devID:") > -1):
					dID = indx.split("devID:")[1]
					if(len(dID) > 3):
						deviceID = int(dID)
						validID = 1
				elif(indx.find("lat:") > -1):
					lat = indx.split("lat:")[1]
					if(len(lat) > 9):
						latitude = float(lat)
						validLat = 1
				elif(indx.find("lon:") > -1):
					lon = indx.split("lon:")[1]
					if(len(lon) > 9):
						longitude = float(lon)
						validLon = 1

			if (validID != 0) and (validLat != 0) and (validLon != 0):
				setTimezone(latitude, longitude)
				year = time.strftime("%Y")
				month = time.strftime("%m")
				day = time.strftime("%d")
				hr = time.strftime("%H")
				min = time.strftime("%M")
				sec = time.strftime("%S")
				timeStr = "%s-%s-%s %s:%s:%s" %(year, month, day, hr, min, sec)
				cursor.execute("""
                		INSERT INTO gpsdata (devID, lat, lon, ts) VALUES (%s, %s, %s, %s)
                		""", (deviceID, latitude, longitude, timeStr))
                		db.commit()
		#conn.send('OK')
		print("DEV:%d  LAT:%s  LON:%s" %(deviceID, latitude, longitude))
	else:
            break
conn.close()              # close socket
