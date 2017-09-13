# Starting off creating an sqlite database to hold some important football data.
# Updated Sept 5, 2017 Luke H
# Updated ___ _, ____  _____


import urllib.request
import sqlite3



games = nflgame.games(2014, week=1)
players = nflgame.combine_game_stats(games)
for p in players.rushing().sort('rushing_yds').limit(5):
	msg ='%s %d carries for %d yards and %d TDs'
	print msg % (p, p.rushing_att, p.rushing_yds, p.rushing_tds)
