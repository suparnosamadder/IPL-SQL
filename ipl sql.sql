create database ipl;
use ipl;
select * from ipl_matches
limit 20;
select * from ipl_ball
limit 20;
-- Fetch data of all the matches played on 2nd May 2013.
select * from ipl_matches
WHERE str_to_date(date,"%d/%m/%Y") = '2013-05-02';
-- Fetch data of all the matches where the margin of victory is more than 100 runs
select * from ipl_matches
where result_margin> 100;
-- Fetch data of all the matches where the final scores of both teams tied and order it in descending order of the date. 
select* from ipl_matches
where result= "tie"
order by str_to_date(date,"%d-%m-%Y") desc;
-- Get the count of cities that have hosted an IPL match. 
select count(distinct city)
from ipl_matches;
--  Create table deliveries_v02 with all the columns of deliveries and
-- an additional column ball_result containing value boundary, dot or 
-- other depending on the total_run (boundary for >= 4, dot for 0 and other for any other number) 

-- Write a query to fetch the total number of boundaries and dot balls 
select count(total_runs)
from ipl_ball
where total_runs in (0,4);
-- Write a query to fetch the total number of boundaries scored by each team 
select count(total_runs) as boundaries, batting_team
from ipl_ball
where total_runs = 4
group by batting_team;
-- Write a query to fetch the total number of dot balls bowled by each team 
select count(total_runs) as dotballs, bowling_team
from ipl_ball
where total_runs = 0
group by bowling_team;
-- . Write a query to fetch the total number of dismissals by dismissal kinds 
select count(*),dismissal_kind
from ipl_ball
where dismissal_kind NOT LIKE "NA"
group by dismissal_kind;
--  Write a query to get the top 5 bowlers who conceded maximum extra runs
select count(extra_runs), bowler
from ipl_ball
group by bowler
order by 1 desc 
limit 5;
--  Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table and
 -- two additional column (named venue and match_date) of venue and 
 -- date from table matches 

-- Write a query to fetch the total runs scored for each venue and 
-- order it in the descending order of total runs scored. 
select count(total_runs), venue
from ipl_ball
group by venue 
order by 1 desc;
-- Write a query to fetch the year-wise total runs scored at Eden Gardens and
-- order it in the descending order of total runs scored. 
select count(total_runs), str_to_year(match_date,"%Y")
from ipl_ball
where venue = "eden gardens"
group by str_to_year(match_date"%Y");
-- Get unique team1 names from the matches table, you will notice that
 -- there are two entries for Rising Pune Supergiant one with Rising Pune Supergiant and 
 -- another one with Rising Pune Supergiants.
 -- Your task is to create a matches_corrected table with two additional columns team1_corr and team2_corr containing team names with replacing Rising Pune Supergiants with Rising Pune Supergiant. Now analyse these newly created columns. 
select distinct team1_corr
from ipl_matches;
alter table ipl_matches
add column team1_corr text ;
set sql_safe_updates=0;
update ipl_matches
set team1_corr= replace(team1,"Rising Pune Supergiants","Rising Pune Supergiant");
alter table ipl_matches
add column team2_corr text ;
set sql_safe_updates=0;
update ipl_matches
set team2_corr= replace(team2,"Rising Pune Supergiants","Rising Pune Supergiant");
select distinct team2_corr
from ipl_matches;






