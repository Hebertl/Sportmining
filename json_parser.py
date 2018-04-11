import json
import os, sys

abbr_dict = {'ARI': 'Arizona Cardinals',
            'ATL': 'Atlanta Falcons',
            'BAL': 'Baltimore Ravens',
            'BUF': 'Buffalo Bills',
            'CAR': 'Carolina Panthers',
            'CHI': 'Chicago Bears',
            'CIN': 'Cincinnati Bengals',
            'CLE': 'Cleveland Browns', 
            'DAL': 'Dallas Cowboys',
            'DEN': 'Denver Broncos',
            'DET': 'Detroit Lions',
            'GB' : 'Green Bay Packers',
            'HOU': 'Houston Texans',
            'IND': 'Indianapolis Colts',
            'JAX': 'Jacksonville Jaguars',
            'KC': 'Kansas City Chiefs',
            'LAC': 'Los Angeles Chargers',
            'LAR': 'Los Angeles Rams',
            'MIA': 'Miami Dolphins',
            'MIN': 'Minnesota Vikings',
            'NE': 'New England Patriots',
            'NO': 'New Orleans Saints',
            'NYG': 'New York Giants',
            'NYJ': 'New York Jets',
            'OAK': 'Oakland Raiders',
            'PHI': 'Philadelphia Eagles',
            'PIT': 'Pittsburgh Steelers',
            'SEA': 'Seattle Seahawks',
            'SF': 'San Francisco 49ers',
            'TB': 'Tampa Bay Buccaneers',
            'TEN': 'Tennessee Titans',
        }


def humanRead(filepath):
    with open(filepath, 'r+') as f :
        jsObj= json.loads(f.read())
        print(json.dumps(jsObj, sort_keys=True, indent= 4))       # This gives us nice indentation and lets us peruse json files


class gameParser:
    def __init__(self, filepath):
        try:
            with open(filepath, 'r+') as f:
                self.gameDict= json.loads(f.read())            # Put the contents of file into gameParser object's gameDict dictionary variable.
        except IOError as err:
            print("I/O error: {0}".format(err))
        except ValueError:
            print("Value error: filepath needs to be a string")
        except:
            print("Some vague error happened")


    # I'm imagining this function getting robus and pulling in lots of help from helper fns. 
    # Each helping fn can drop some neat statistic or conclusions into self.
    def fullParse(self):
        print('full parse')
#        self.homeTeam= 
#        self.awayTeam= 

    def get_game_dict(self):
        return self.gameDict            # Remember that this returns a json dict.

    def getHomeTeam(self):
        return self.homeTeam

    def getAwayTeam(self):
        return self.awayTeam
