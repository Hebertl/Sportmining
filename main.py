#Description: A file with built in functions for fetching and analyzing stats from NFL games since 2009. 
#Author: IEEE-NOLA Computer Society Meetup Group  

import urllib.request
import urllib.parse
import json, os, time
import lxml.etree as ET
import json 
#import lxml.etree 
from io import StringIO, BytesIO
import requests 

link1 = 'http://www.nfl.com/liveupdate/game-center/'
link2 = 'http://www.nfl.com/ajax/scorestrip?season='

def DownloadFiles():
    #Note depending on your Ethernet connection this can take >10min to complete
    #For testing, if you like to only pull a single year just update the range below to (year, year+1)
    for year in range(2009, 2017):
        for week in range(1, 17):
            url = link2 + str(year) + '&seasonType=REG&week='+str(week)
            #print(url)
            opener = urllib.request.build_opener()
            tree = ET.parse(opener.open(url))
            xml = urllib.request.urlopen(url) #Need error handling function here 
            print(xml.read()) # prints the raw XML data being returned from the URL, used for debugging the code 
            GameIdsForWeek = [el.attrib.get('eid') for el in tree.findall('.//g')]
            #print([el.attrib.get('eid') for el in tree.findall('.//g')])
            #print(GameIdsForWeek)
            for gid in GameIdsForWeek:
                print("Looking up information for game: %s" % (gid))
                print("|____ Fetching") #Need error handling function here 
                #EXAMPLE URL: http://www.nfl.com/liveupdate/game-center/2017012200/2017012200_gtd.json
                url = link1 + gid + '/' + gid + '_gtd.json'
                response = urllib.request.urlopen(url)
                content = response.read()
                data = json.loads(content.decode('utf8'))
                #print(data) #used when debugging the code
                filename = gid + '.json'
                print("|____ Saving: " + filename) #Need error handling function here 
                with open(filename, 'w') as output:
                    json.dump(data, output)
                

def GetFinalScoreForGamesThatWeek():
    #Working on function. 
    year = input("Year (2009-2010): ") #need error checking code
    week = input("Week (1-16): ") #need error checking code 

def main():
    #Ask user what options they would like to use 
    print("Enter the number for the function you would like to perform.")
    print("1: Download and save data files to local directory for games 2009 - 2016.")
    print("2: Get all final scores for a given year and given week.")
    print("3: ")
    Action = input("Run Function: ")
    if Action == str(1): 
        DownloadFiles()
    if Action == str(2):
        GetFinalScoreForGamesThatWeek()
    else:  
        print("SPOC Says: IDK my bff, no function corresponds with your entry.")

main()