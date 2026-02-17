// Top 10 Genres by Number of Titles
MATCH (t:Title)-[:BELONGS_TO]->(g:Genre)
RETURN g.name AS Genre, COUNT(t) AS TotalTitles
ORDER BY TotalTitles DESC
LIMIT 10;


// Titles per Country
MATCH (t:Title)-[:PRODUCED_IN]->(c:Country)
RETURN c.name AS Country, COUNT(t) AS TotalTitles
ORDER BY TotalTitles DESC;


// Content Production Over Time
MATCH (t:Title)
RETURN t.release_year AS Year, COUNT(t) AS TotalTitles
ORDER BY Year;


// Most Frequent Actors
MATCH (a:Actor)<-[:ACTED_IN]-(t:Title)
RETURN a.name AS Actor, COUNT(t) AS Appearances
ORDER BY Appearances DESC
LIMIT 10;


// Genre-Country Relationship Analysis
MATCH (t:Title)-[:BELONGS_TO]->(g:Genre),
      (t)-[:PRODUCED_IN]->(c:Country)
RETURN g.name AS Genre, c.name AS Country, COUNT(t) AS TotalTitles
ORDER BY TotalTitles DESC
LIMIT 15;
