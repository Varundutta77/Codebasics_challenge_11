-- 11.	Which constituencies have elected candidates whose party has less than 10% vote share at state level in 2019?
WITH State_Vote_Share AS (
    SELECT
        party,
        state,
        SUM(total_votes) AS state_total_votes
    FROM
        constituency_wise_results_2019
    GROUP BY
        state, party
)
SELECT
    c_2019.pc_name,
    c_2019.party,
    c_2019.state,
    c_2019.candidate,
    SUM(c_2019.total_votes) AS total_votes,
    svs.state_total_votes 
FROM
    constituency_wise_results_2019 c_2019
JOIN
    State_Vote_Share svs
    ON c_2019.party = svs.party
    AND c_2019.state = svs.state
GROUP BY
    c_2019.pc_name,
    c_2019.party,
    c_2019.state,
    c_2019.candidate,
    svs.state_total_votes  
HAVING
    SUM(c_2019.total_votes) < 0.1 * svs.state_total_votes  
ORDER BY
    c_2019.state, c_2019.pc_name;
