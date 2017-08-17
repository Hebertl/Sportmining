# Find the top 5 running backs by rushing yards in the first week of the 2013 season.
# Aug 16, 2017

import nflgame

games = nflgame.games(2014, week=1)
players = nflgame.combine_game_stats(games)
for p in players.rushing().sort('rushing_yds').limit(5):
	msg ='%s %d carries for %d yards and %d TDs'
	print msg % (p, p.rushing_att, p.rushing_yds, p.rushing_tds)
