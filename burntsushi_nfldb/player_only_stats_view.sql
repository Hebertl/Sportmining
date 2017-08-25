USE [nfldb]

GO

 

/****** Object:  View [dbo].[FTSY_PLAYER_SUM_V]    Script Date: 8/17/2017 8:50:01 PM ******/

SET ANSI_NULLS ON

GO

 

SET QUOTED_IDENTIFIER ON

GO

 

----------    drop view FTSY_PLAYERS

---   

create view [dbo].[FTSY_PLAYER_SUM_V] as

 

 

 

select

 

 

g.week,

case when p.full_name = 'David Johnson' and p.position = 'te' then 'David  Johnson' else p.full_name end as full_name,

pp.team,

case when p.position = 'FB' then 'RB' else p.position end as position,

case when p.position in ('FB','RB','WR','TE') then 'YES' else 'NO' end as flex_ind,

SUM(receiving_rec) AS receiving_rec,

SUM(receiving_tar) AS receiving_tar,

SUM(receiving_tds) AS receiving_tds,

SUM(receiving_twopta) AS receiving_twopta,

SUM(receiving_twoptm) AS receiving_twoptm,

SUM(receiving_twoptmissed) AS receiving_twoptmissed,

SUM(receiving_yac_yds) AS receiving_yac_yds,

SUM(receiving_yds) AS receiving_yds,

SUM(fumbles_lost) AS fumbles_lost,

SUM(rushing_att) AS rushing_att,

SUM(rushing_loss) AS rushing_loss,

SUM(rushing_loss_yds) AS rushing_loss_yds,

SUM(rushing_tds) AS rushing_tds,

SUM(rushing_twopta) AS rushing_twopta,

SUM(rushing_twoptm) AS rushing_twoptm,

SUM(rushing_twoptmissed) AS rushing_twoptmissed,

SUM(rushing_yds) AS rushing_yds,

SUM(passing_att) AS passing_att,

SUM(passing_cmp) AS passing_cmp,

SUM(passing_cmp_air_yds) AS passing_cmp_air_yds,

SUM(passing_incmp) AS passing_incmp,

SUM(passing_incmp_air_yds) AS passing_incmp_air_yds,

SUM(passing_int) AS passing_int,

SUM(passing_sk) AS passing_sk,

SUM(passing_sk_yds) AS passing_sk_yds,

SUM(passing_tds) AS passing_tds,

SUM(passing_twopta) AS passing_twopta,

SUM(passing_twoptm) AS passing_twoptm,

SUM(passing_twoptmissed) AS passing_twoptmissed,

SUM(passing_yds) AS passing_yds,

SUM(puntret_tds) AS puntret_tds,

SUM(kickret_tds) AS kickret_tds

 

from play_player pp

 

inner join player p

on pp.player_id = p.player_id

and p.position IN ('wr','qb','te','rb','fb')

 

left join game g

on pp.gsis_id = g.gsis_id

and g.season_year = 2016

and g.season_type = 'regular'

 

where g.week is not null

 

group by g.week,

p.full_name,

pp.team,

p.position

 

 

 

GO
