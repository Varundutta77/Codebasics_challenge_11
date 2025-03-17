-- 4.	Which constituencies have voted for different parties in two elections (list top 10 based on difference (2019-2014) in winner vote percentage in two elections)

WITH Winner_2014 AS(
	SELECT pc_name,party,SUM(total_votes)/SUM(total_electors) AS voter_turnout_2014
    FROM 
		constituency_wise_results_2014 c_2014
    GROUP BY 
		pc_name,party
),
Winner_2019 AS(
	SELECT 
		pc_name,party,SUM(total_votes)/SUM(total_electors) AS voter_turnout_2019
    FROM 
		constituency_wise_results_2019
    GROUP BY 
		pc_name,party
)
SELECT w_14.pc_name,
	   w_14.party AS party_2014,
       w_19.party AS party_2019,
       (w_19.voter_turnout_2019 - w_14.voter_turnout_2014) AS difference
FROM 
	Winner_2014 w_14
JOIN 
	Winner_2019 w_19 ON w_14.pc_name = w_19.pc_name
WHERE 
	w_14.party <> w_19.party
ORDER BY difference DESC LIMIT 10