-- 10.	Which constituency has voted the most for NOTA?
SELECT
	pc_name,party,SUM(total_votes) as total_votes
FROM
	constituency_wise_results_2019 c_2019
WHERE party="NOTA"
GROUP BY pc_name,party
ORDER BY total_votes DESC