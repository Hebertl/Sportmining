use nfldb;

 

delete from nfldb.dbo.player;

insert into nfldb.dbo.player

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.player');

 

delete from nfldb.dbo.play_player;

insert into nfldb.dbo.play_player

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.play_player');

 

delete from nfldb.dbo.play;

insert into nfldb.dbo.play

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.play');

 

delete from nfldb.dbo.agg_play;

insert into nfldb.dbo.agg_play

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.agg_play');

 

delete from nfldb.dbo.game;

insert into nfldb.dbo.game

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.game');

 

delete from nfldb.dbo.drive;

insert into nfldb.dbo.drive

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.drive');

 

delete from nfldb.dbo.team;

insert into nfldb.dbo.team

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.team');

 

delete from nfldb.dbo.public_meta;

insert into nfldb.dbo.public_meta

SELECT * FROM OPENQUERY(POSTGRES_NFLDB, 'SELECT * FROM nfldb.public.meta');

 
