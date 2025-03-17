-- 6. % Split of votes of parties between 2014 vs 2019 at national level

WITH Vote_2014 AS(
	SELECT pc_name,SUM(total_votes) as total_votes_2014
    FROM constituency_wise_results_2014 c_2014
    GROUP BY pc_name
),
Vote_2019 AS(
	SELECT pc_name,SUM(total_votes) as total_votes_2019
    FROM constituency_wise_results_2019 c_2019
    GROUP BY pc_name
)

SELECT Vote_2019.pc_name,(total_votes_2019-total_votes_2014)/total_votes_2014*100 as '%age votes'
FROM Vote_2014
JOIN Vote_2019 ON Vote_2019.pc_name = Vote_2014.pc_name
GROUP BY Vote_2019.pc_name
ORDER BY (total_votes_2019-total_votes_2014)/total_votes_2014*100 DESC

