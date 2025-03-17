-- 5.	Top 5 candidates based on ma rgin difference with runners in 2014 and 2019.
WITH Ranked_2014 AS (
    SELECT 
        pc_name,
        state,
        candidate,
        SUM(total_votes) AS total_votes_2014,
        RANK() OVER (PARTITION BY pc_name, state ORDER BY SUM(total_votes) DESC) AS ranking
    FROM 
        constituency_wise_results_2014
    GROUP BY 
        pc_name, state, candidate
),
Ranked_2019 AS (
    SELECT 
        pc_name,
        state,
        candidate,
        SUM(total_votes) AS total_votes_2019,
        RANK() OVER (PARTITION BY pc_name, state ORDER BY SUM(total_votes) DESC) AS ranking
    FROM 
        constituency_wise_results_2019
    GROUP BY 
        pc_name, state, candidate
)
SELECT 
    r14.pc_name,
    r14.state,
    r14.candidate AS candidate_2014,
    r14.total_votes_2014,
    r19.candidate AS candidate_2019,
    r19.total_votes_2019,
    (r14.total_votes_2014 - r19.total_votes_2019) AS margin_difference
FROM 
    Ranked_2014 r14
JOIN 
    Ranked_2019 r19 ON r14.pc_name = r19.pc_name AND r14.state = r19.state
WHERE 
    r14.ranking = 2 AND r19.ranking = 2 
ORDER BY 
    margin_difference DESC
LIMIT 5;
