-- 3.	Which constituencies have elected the same party for two consecutive elections,rank them by % of votes to that winning party in 2019

WITH Winner_2014 AS(
	SELECT pc_name,party,SUM(total_votes)/SUM(total_electors) AS voter_turnout
    FROM 
		constituency_wise_results_2014 c_2014
    GROUP BY 
		pc_name,party
),
Winner_2019 AS(
	SELECT 
		pc_name,party,SUM(total_votes)/SUM(total_electors) AS voter_turnout
    FROM 
		constituency_wise_results_2019
    GROUP BY 
		pc_name,party
)
SELECT w_19.pc_name,
	   w_19.party,
       w_19.voter_turnout As voter_percentage,
       RANK() OVER(ORDER BY w_19.voter_turnout DESC) AS ranking
FROM 
	Winner_2014 w_14
JOIN 
	Winner_2019 w_19 ON w_14.pc_name = w_19.pc_name
WHERE 
	w_14.party = w_19.party
ORDER BY voter_percentage DESC LIMIT 10