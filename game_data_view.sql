USE [nfldb]

GO

 

/****** Object:  View [dbo].[NFL_GAME_SUMMARY_RAW_V]    Script Date: 8/17/2017 8:46:43 PM ******/

SET ANSI_NULLS ON

GO

 

SET QUOTED_IDENTIFIER ON

GO

 

---   DROP VIEW NFL_GAME_SUMMARY_RAW_V

CREATE VIEW [dbo].[NFL_GAME_SUMMARY_RAW_V] AS

 

select

 

g.gsis_id,

g.season_year,

g.season_type,

g.week,

case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end as HALF,

case when g.gsis_id in (select DISTINCT gsis_id d from drive where substring(end_time,2,2) = 'OT') then 'YES' else 'NO' end as OT_GAME_IND,

g.home_team,

g.home_score,

g.away_team,

g.away_score,

g.home_turnovers,

g.away_turnovers,

ht.time_of_poss as home_top,

at.time_of_poss as away_top,

ht.play_count as home_play_count,

at.play_count as away_play_count,

case when g.home_score > g.away_score then g.home_team

when g.home_score < g.away_score then g.away_team

when g.home_score = g.away_score then 'Tie'

else 'Unknown' end as winning_team,

case when g.home_score > g.away_score then g.home_score

when g.home_score < g.away_score then g.away_score

when g.home_score = g.away_score then  g.home_score

else 'Unknown' end as winning_score,

case when g.home_score < g.away_score then g.home_score

when g.home_score > g.away_score then g.away_score

when g.home_score = g.away_score then  g.home_score

else 'Unknown' end as loosing_score,

 

 

case when substring(d.end_time,2,2) = 'OT' then g.home_score_q5

when substring(d.end_time,3,1) between 1 and 2  then coalesce(g.home_score_q1+g.home_score_q2,0)

when substring(d.end_time,3,1) between 3 and 4  then coalesce(g.home_score_q3+g.home_score_q4,0)

else 0 end as home_qtr_score,

case when substring(d.end_time,2,2) = 'OT' then g.away_score_q5

when substring(d.end_time,3,1) between 1 and 2  then coalesce(g.away_score_q1+g.away_score_q2,0)

when substring(d.end_time,3,1) between 3 and 4  then coalesce(g.away_score_q3+g.away_score_q4,0)

else 0 end as away_qtr_score,

 

count(distinct(case when p.pos_team = g.home_team then d.drive_id else null end)) as home_drives,

sum(case when p.pos_team = g.home_team then p.first_down else 0 end) as home_first_down,

sum(case when p.pos_team = g.home_team then p.passing_first_down else 0 end) as home_passing_first_down,

sum(case when p.pos_team = g.home_team then p.rushing_first_down else 0 end) as home_rushing_first_down,

sum(case when p.pos_team = g.home_team then p.third_down_att else 0 end) as home_third_down_att,

sum(case when p.pos_team = g.home_team then p.third_down_conv else 0 end) as home_third_down_conv,

sum(case when p.pos_team = g.home_team then p.third_down_failed else 0 end) as home_third_down_failed,

sum(case when p.pos_team = g.home_team then p.fourth_down_att else 0 end) as home_fourth_down_att,

sum(case when p.pos_team = g.home_team then p.fourth_down_conv else 0 end) as home_fourth_down_conv,

sum(case when p.pos_team = g.home_team then p.fourth_down_failed else 0 end) as home_fourth_down_failed,

sum(case when p.pos_team = g.home_team then p.penalty else 0 end) as home_penalty,

sum(case when p.pos_team = g.home_team then p.penalty_yds else 0 end) as home_penalty_yds,

sum(case when p.pos_team = g.home_team then ap.fumbles_lost else 0 end) as home_fumbles_tot,

sum(case when p.pos_team = g.home_team then ap.passing_att else 0 end) as home_passing_att,

sum(case when p.pos_team = g.home_team then ap.passing_cmp else 0 end) as home_passing_cmp,

sum(case when p.pos_team = g.home_team then ap.passing_cmp_air_yds else 0 end) as home_passing_cmp_air_yds,

sum(case when p.pos_team = g.home_team then ap.passing_incmp else 0 end) as home_passing_incmp,

sum(case when p.pos_team = g.home_team then ap.passing_int else 0 end) as home_passing_int,

sum(case when p.pos_team = g.home_team then ap.passing_sk else 0 end) as home_passing_sk,

sum(case when p.pos_team = g.home_team then ap.passing_yds else 0 end) as home_passing_yds,

sum(case when p.pos_team = g.home_team then ap.receiving_rec else 0 end) as home_receiving_rec,

sum(case when p.pos_team = g.home_team then ap.receiving_tar else 0 end) as home_receiving_tar,

sum(case when p.pos_team = g.home_team then ap.receiving_yac_yds else 0 end) as home_receiving_yac_yds,

sum(case when p.pos_team = g.home_team then ap.receiving_yds else 0 end) as home_receiving_yds,

sum(case when p.pos_team = g.home_team then ap.rushing_att else 0 end) as home_rushing_att,

sum(case when p.pos_team = g.home_team then ap.rushing_yds else 0 end) as home_rushing_yds,

sum(case when p.pos_team = g.home_team then ap.rushing_yds+ap.passing_yds else 0 end) as home_total_yds,

 

count(distinct(case when p.pos_team = g.away_team then d.drive_id else null end)) as away_drives,

sum(case when p.pos_team = g.away_team then p.first_down else 0 end) as away_first_down,

sum(case when p.pos_team = g.away_team then p.passing_first_down else 0 end) as away_passing_first_down,

sum(case when p.pos_team = g.away_team then p.rushing_first_down else 0 end) as away_rushing_first_down,

sum(case when p.pos_team = g.away_team then p.third_down_att else 0 end) as away_third_down_att,

sum(case when p.pos_team = g.away_team then p.third_down_conv else 0 end) as away_third_down_conv,

sum(case when p.pos_team = g.away_team then p.third_down_failed else 0 end) as away_third_down_failed,

sum(case when p.pos_team = g.away_team then p.fourth_down_att else 0 end) as away_fourth_down_att,

sum(case when p.pos_team = g.away_team then p.fourth_down_conv else 0 end) as away_fourth_down_conv,

sum(case when p.pos_team = g.away_team then p.fourth_down_failed else 0 end) as away_fourth_down_failed,

sum(case when p.pos_team = g.away_team then p.penalty else 0 end) as away_penalty,

sum(case when p.pos_team = g.away_team then p.penalty_yds else 0 end) as away_penalty_yds,

sum(case when p.pos_team = g.away_team then ap.fumbles_lost else 0 end) as away_fumbles_tot,

sum(case when p.pos_team = g.away_team then ap.passing_att else 0 end) as away_passing_att,

sum(case when p.pos_team = g.away_team then ap.passing_cmp else 0 end) as away_passing_cmp,

sum(case when p.pos_team = g.away_team then ap.passing_cmp_air_yds else 0 end) as away_passing_cmp_air_yds,

sum(case when p.pos_team = g.away_team then ap.passing_incmp else 0 end) as away_passing_incmp,

sum(case when p.pos_team = g.away_team then ap.passing_int else 0 end) as away_passing_int,

sum(case when p.pos_team = g.away_team then ap.passing_sk else 0 end) as away_passing_sk,

sum(case when p.pos_team = g.away_team then ap.passing_yds else 0 end) as away_passing_yds,

sum(case when p.pos_team = g.away_team then ap.receiving_rec else 0 end) as away_receiving_rec,

sum(case when p.pos_team = g.away_team then ap.receiving_tar else 0 end) as away_receiving_tar,

sum(case when p.pos_team = g.away_team then ap.receiving_yac_yds else 0 end) as away_receiving_yac_yds,

sum(case when p.pos_team = g.away_team then ap.receiving_yds else 0 end) as away_receiving_yds,

sum(case when p.pos_team = g.away_team then ap.rushing_att else 0 end) as away_rushing_att,

sum(case when p.pos_team = g.away_team then ap.rushing_yds else 0 end) as away_rushing_yds,

sum(case when p.pos_team = g.away_team then ap.rushing_yds+ap.passing_yds else 0 end) as away_total_yds

 

 

 

 

 

 

from game g

 

inner join drive d

on d.gsis_id = g.gsis_id

 

inner join play p

on g.gsis_id = p.gsis_id

and d.drive_id = p.drive_id

 

inner join agg_play ap

on ap.gsis_id = g.gsis_id

and ap.drive_id = p.drive_id

and ap.play_id = p.play_id

 

left join

(SELECT DISTINCT

 

d.gsis_id,

d.pos_team,

case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end as HALF,

sum(play_count) as play_count,

sum(cast(left((right(d.pos_time,len(d.pos_time)-1)),len(d.pos_time)-2) as int)) as time_of_poss

 

from drive d

 

inner join game g

on d.gsis_id = g.gsis_id

 

group by d.gsis_id, d.pos_team,case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end

 

) ht

on g.gsis_id = ht.gsis_id

and g.home_team = ht.pos_team

and ht.half = case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end

 

left join

(SELECT DISTINCT

 

d.gsis_id,

d.pos_team,

case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end as HALF,

sum(play_count) as play_count,

sum(cast(left((right(d.pos_time,len(d.pos_time)-1)),len(d.pos_time)-2) as int)) as time_of_poss

 

from drive d

 

inner join game g

on d.gsis_id = g.gsis_id

 

group by d.gsis_id, d.pos_team,case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end

 

) at

on g.gsis_id = at.gsis_id

and g.away_team = at.pos_team

and at.half = case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end

 

 

 

 

where g.season_type <> 'preseason'

 

 

 

group by

g.gsis_id,

case when substring(d.end_time,2,2) = 'OT' then 'OT'

when substring(d.end_time,3,1) between 1 and 2  then 'H_1'

when substring(d.end_time,3,1) between 3 and 4  then 'H_2' end,

--case when g.gsis_id in (select DISTINCT gsis_id d from drive where substring(end_time,2,2) = 'OT') then 'YES' else 'NO' end,

g.season_year,

g.week,

g.home_team,

g.away_team,

g.home_score,

g.away_score,

g.home_turnovers,

g.away_turnovers,

ht.time_of_poss,

at.time_of_poss,

ht.play_count,

at.play_count,

case when g.home_score > g.away_score then g.home_score

when g.home_score < g.away_score then g.away_score

when g.home_score = g.away_score then  g.home_score

else 'Unknown' end,

case when g.home_score < g.away_score then g.home_score

when g.home_score > g.away_score then g.away_score

when g.home_score = g.away_score then  g.home_score

else 'Unknown' end,

 

case when substring(d.end_time,2,2) = 'OT' then g.home_score_q5

when substring(d.end_time,3,1) between 1 and 2  then coalesce(g.home_score_q1+g.home_score_q2,0)

when substring(d.end_time,3,1) between 3 and 4  then coalesce(g.home_score_q3+g.home_score_q4,0)

else 0 end,

case when substring(d.end_time,2,2) = 'OT' then g.away_score_q5

when substring(d.end_time,3,1) between 1 and 2  then coalesce(g.away_score_q1+g.away_score_q2,0)

when substring(d.end_time,3,1) between 3 and 4  then coalesce(g.away_score_q3+g.away_score_q4,0)

else 0 end,

 

 

 

case when g.home_score > g.away_score then g.home_team

when g.home_score < g.away_score then g.away_team

when g.home_score = g.away_score then 'Tie'

else 'Unknown' end,

g.season_type

 

 

GO
