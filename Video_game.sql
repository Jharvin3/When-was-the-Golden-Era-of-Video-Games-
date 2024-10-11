--Part 1
-- best_selling_games

SELECT *
FROM game_sales
ORDER BY games_sold desc
LIMIT 10;


--Part 2
-- critics_top_ten_years

SELECT g.year, COUNT(g.name) AS num_games, ROUND(AVG(r.critic_score),2) AS avg_critic_score
FROM game_sales AS g
JOIN reviews AS r
ON g.name = r.name
GROUP BY g.year
HAVING COUNT(g.year) > 4
ORDER BY avg_critic_score DESC
LIMIT 10;

--Part 3
-- golden_years

WITH combined_ratings AS (
    SELECT 
        u.year, 
        u.num_games, 
        u.avg_user_score, 
        c.avg_critic_score,
        (u.avg_user_score - c.avg_critic_score) AS diff
    FROM 
        users_avg_year_rating u
    JOIN 
        critics_avg_year_rating c
    ON 
        u.year = c.year
)
SELECT 
    year, 
    num_games, 
	avg_critic_score,
    avg_user_score, 
    AVG(diff) AS diff
FROM 
    combined_ratings
WHERE
	avg_critic_score > 9 OR avg_user_score > 9
GROUP BY 
    year, 
    num_games,
	avg_critic_score,
    avg_user_score
ORDER BY 
    year ASC;
