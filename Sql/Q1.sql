-- Q1 List top 5 / bottom 5 constituencies of 2014 and 2019 in terms of voter turnout ratio?

WITH turn_out_2014 AS
(
   SELECT pc_name,SUM(total_votes)/SUM(total_electors) AS voter_turnout
   FROM constituency_wise_results_2014 c_2014
   GROUP BY pc_name
	),
turn_out_2019 AS
(
   SELECT pc_name,SUM(total_votes)/SUM(total_electors) AS voter_turnout
   FROM constituency_wise_results_2019 c_2019
   GROUP BY pc_name
	)
    
SELECT * FROM (SELECT pc_name,'Top' as position,'2014'AS Year,voter_turnout
FROM turn_out_2014
ORDER BY voter_turnout DESC LIMIT 5) AS top_2014

UNION ALL

SELECT * FROM(SELECT pc_name,'Bottom' as position,'2014'AS Year,voter_turnout
FROM turn_out_2014
ORDER BY voter_turnout ASC LIMIT 5) AS Bottom_2014

UNION ALL

SELECT * FROM (SELECT pc_name,'Top' as position,'2019'AS Year,voter_turnout
FROM turn_out_2019
ORDER BY voter_turnout DESC LIMIT 5) AS top_2019

UNION ALL

SELECT * FROM(SELECT pc_name,'Bottom' as position,'2019'AS Year,voter_turnout
FROM turn_out_2019
ORDER BY voter_turnout ASC LIMIT 5) AS Bottom_2019