-- 7. % Split of votes of parties between 2014 vs 2019 at state level

WITH Vote_2014 AS(
	SELECT  	pc_name,state,
			SUM(total_votes) as total_votes_2014
    FROM constituency_wise_results_2014 c_2014
    GROUP BY pc_name,state
),
Vote_2019 AS(
	SELECT  pc_name,state,
			SUM(total_votes) as total_votes_2019
    FROM constituency_wise_results_2019 c_2019
    GROUP BY pc_name,state
)

SELECT Vote_2019.state,
	   Vote_2019.pc_name,
       (total_votes_2019-total_votes_2014)/total_votes_2014*100 as '%age votes'
FROM Vote_2014
JOIN Vote_2019 ON Vote_2019.pc_name = Vote_2014.pc_name
GROUP BY Vote_2019.pc_name,Vote_2019.state,total_votes_2014, total_votes_2019
ORDER BY (total_votes_2019-total_votes_2014)/total_votes_2014*100 DESC

