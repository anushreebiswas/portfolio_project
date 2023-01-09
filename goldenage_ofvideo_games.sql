--The ten best-selling video games
--Select all columns for the top ten best-selling video games (based on games_sold) in game_sales.
--Order the results from the best-selling game down to the tenth best-selling game.

SELECT * FROM game_sales
ORDER BY games_sold DESC
LIMIT 10


--Missing review scores
--Join the game_sales and reviews tables together so that all games from the game_sales table are listed in the results, whether or not they have associated reviews.
--Select the count of games where both the associated critic_score and the associated user_score are null.

SELECT COUNT(g.game)
FROM game_sales AS g
LEFT JOIN reviews AS r
ON g.game = r.game
WHERE critic_score IS NULL AND user_score IS NULL;


--Years that video game critics loved
--Select release year and average critic score for each year; average critic score for each year will be rounded to two decimal places and aliased as avg_critic_score.
--Join the game_sales and reviews tables so that only games which appear on both tables are represented.
--Group the data by release year.
--Order the data from highest to lowest avg_critic_score and limit the results to the top ten years.

SELECT g.year, ROUND(AVG(CAST(r.critic_score AS NUMERIC)),2) AS avg_critic_score
FROM game_sales AS g
INNER JOIN reviews AS r
ON g.game = r.game
GROUP BY year
ORDER BY avg_critic_score DESC
LIMIT 10


--Was 1982 really that great?
--Starting with your query from the previous task, update it so that the selected data additionally includes a count of games released in a given year, and alias this count as num_games.
--Filter your query so that only years with more than four games released are returned.

SELECT year,ROUND(AVG(CAST(r.critic_score AS NUMERIC)),2) AS avg_critic_score,COUNT(*) AS num_games
FROM game_sales AS g
INNER JOIN reviews AS r
ON g.game = r.game
GROUP BY year
HAVING COUNT(*)>4
ORDER BY avg_critic_score DESC
LIMIT 10


--Years that dropped off the critics' favorites list
--Select the year and avg_critic_score for those years that were on our first critics' favorite list but not the second due to having four or fewer reviewed games.
--Order the results from highest to lowest avg_critic_score

WITH top_critic_years(year) AS
                            (SELECT year,ROUND(AVG(CAST(r.critic_score AS NUMERIC)),2) AS avg_critic_score FROM game_sales AS g
                             INNER JOIN reviews AS r
                             ON g.game=r.game
                             GROUP BY year
							 ORDER BY avg_critic_score DESC
							 LIMIT 10),
	top_critic_years_more_than_four_games(year) AS
                            (SELECT year,ROUND(AVG(CAST(r.critic_score AS NUMERIC)),2) AS avg_critic_score,COUNT(*) AS num_games
                             FROM game_sales AS g
                             INNER JOIN reviews AS r
                             ON g.game = r.game
                             GROUP BY year
                             HAVING COUNT(*)>4
							 ORDER BY avg_critic_score DESC
							 LIMIT 10)
							 
SELECT t1.year,t1.avg_critic_score FROM top_critic_years AS t1
LEFT JOIN top_critic_years_more_than_four_games AS t2
ON t1.year=t2.year
WHERE t2.avg_critic_score IS NULL


--Years video game players loved
--You'll still select year and an average of user_score for each year, rounded to two decimal places and aliased as avg_user_score; also include a count of games released in a given year, aliased as num_games.
--Include only years with more than four reviewed games; group the data by year.
--Order data from highest to lowest avg_user_score, and limit the results to the top ten years.

SELECT t1.year,ROUND(AVG(CAST(t2.user_score AS INTEGER)),2) AS avg_user_score,
COUNT(t2.game) AS num_games FROM game_sales AS t1
INNER JOIN reviews AS t2
ON t1.game=t2.game
GROUP BY t1.year
HAVING COUNT(t2.game)>4
ORDER BY avg_user_score DESC
LIMIT 10


--Years that both players and critics loved

WITH top_user_years_more_than_four_games(year) AS
                 (SELECT t1.year,AVG(t2.user_score) AS avg_user_score,
                  COUNT(t2.game) AS num_games FROM game_sales AS t1
                  INNER JOIN reviews AS t2
                  ON t1.game=t2.game
                  GROUP BY t1.year
                  HAVING COUNT(t2.game)>4
                  ORDER BY avg_user_score DESC
                  LIMIT 10),
     top_critic_years_more_than_four_games(year) AS
                  (SELECT year,ROUND(AVG(CAST(r.critic_score AS NUMERIC)),2) AS avg_critic_score,COUNT(*) AS num_games
                   FROM game_sales AS g
                   INNER JOIN reviews AS r
                   ON g.game = r.game
                   GROUP BY year
                   HAVING COUNT(*)>4
				   ORDER BY avg_critic_score DESC
				   LIMIT 10)
							 
SELECT t1.year FROM top_critic_years_more_than_four_games AS t1
INNER JOIN top_user_years_more_than_four_games AS t2
ON t1.year=t2.year

--Sales in the best video game years
--Select year and the sum of games_sold, aliased as total_games_sold; order your results by total_games_sold descending.
--Filter the game_sales table based on whether the year is in the list of years you returned in the previous task, using your code from the previous task as a subquery.
--Group the results by year.

WITH top_user_years_more_than_four_games(year) AS(
                  SELECT t1.year,AVG(t2.user_score) AS avg_user_score,
                  COUNT(t2.game) AS num_games FROM game_sales AS t1
                  INNER JOIN reviews AS t2
                  ON t1.game=t2.game
                  GROUP BY t1.year
                  HAVING COUNT(t2.game)>4
                  ORDER BY avg_user_score DESC
                  LIMIT 10),
     top_critic_years_more_than_four_games(year) AS (
                  SELECT year,ROUND(AVG(CAST(r.critic_score AS NUMERIC)),2) AS avg_critic_score,COUNT(*) AS num_games
                   FROM game_sales AS g
                   INNER JOIN reviews AS r
                   ON g.game = r.game
                   GROUP BY year
                   HAVING COUNT(*)>4
				   ORDER BY avg_critic_score DESC
				   LIMIT 10)
							 
SELECT year,SUM(games_sold) AS total_games_sold FROM
(SELECT t1.year,t3.games_sold FROM top_critic_years_more_than_four_games AS t1
INNER JOIN top_user_years_more_than_four_games AS t2
ON t1.year=t2.year
INNER JOIN game_sales AS t3
ON t1.year=t3.year) AS foo
GROUP BY year
ORDER BY total_games_sold DESC

							 
