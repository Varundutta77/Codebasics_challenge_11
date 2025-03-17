-- 9.	List top 5 constituencies for two major national parties where they have lost vote share in 2019 as compa red to 2014.
WITH Major_party_2014 AS (
    SELECT pc_name,party, SUM(total_votes) AS total_votes_2014
    FROM constituency_wise_results_2014
    GROUP BY pc_name,party
),
Major_party_2019 AS (
    SELECT pc_name,party, SUM(total_votes) AS total_votes_2019
    FROM constituency_wise_results_2019
    GROUP BY pc_name,party
),
Major_party AS (
	SELECT 
    Major_party_2014.pc_name,
    Major_party_2014.party,
    Major_party_2014.total_votes_2014,
    Major_party_2019.total_votes_2019,
    (total_votes_2014+total_votes_2019) as total_joint_votes
FROM Major_party_2019
JOIN Major_party_2014 ON Major_party_2019.pc_name = Major_party_2014.pc_name
WHERE Major_party_2019.total_votes_2019 < Major_party_2014.total_votes_2014
ORDER BY total_joint_votes 
)
SELECT 
	Major_party.pc_name,
	Major_party.party,
	((Major_party.total_votes_2019 - Major_party.total_votes_2014) / Major_party.total_votes_2014) * 100 AS "% share"
FROM Major_party
ORDER BY '% share' DESC LIMIT 5
		