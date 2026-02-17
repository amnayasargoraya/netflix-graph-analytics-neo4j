// --------------------------------------------------
// DATA IMPORT – Titles (Movies & TV Shows)
// --------------------------------------------------

LOAD CSV WITH HEADERS FROM 
"https://git.thm.de/aygr61/dataliteracyteam3/-/raw/master/netflix_titles.csv"
AS line FIELDTERMINATOR ','

WITH line WHERE line.show_id IS NOT NULL

CREATE (t:Title {
  show_id: line.show_id,
  title: line.title,
  release_year: toInteger(line.releaseyear),
  duration: line.duration,
  description: line.description
})

WITH t, line

FOREACH (_ IN CASE WHEN line.type = 'Movie' THEN [1] ELSE [] END |
  SET t:Movie)

FOREACH (_ IN CASE WHEN line.type = 'TV Show' THEN [1] ELSE [] END |
  SET t:TVShow)

RETURN count(*);


// --------------------------------------------------
// DATA CLEANING – Remove Empty Country Nodes
// --------------------------------------------------

MATCH (t)-[r:PRODUCED_IN]->(c:Country)
WHERE trim(c.name) = ""
DELETE r
WITH c
DETACH DELETE c;


// --------------------------------------------------
// DATA ENRICHMENT – Age Rating Relationship
// --------------------------------------------------

LOAD CSV WITH HEADERS FROM 
"https://git.thm.de/aygr61/dataliteracyteam3/-/raw/master/netflix_titles.csv"
AS line FIELDTERMINATOR ','

WITH line
WHERE line.age_restriction IS NOT NULL 
  AND trim(line.age_restriction) <> ''

MATCH (t:Title)
WHERE trim(t.show_id) = trim(line.show_id)

MERGE (r:AgeRating {rating: trim(line.age_restriction)})
MERGE (t)-[:HAS_AGERATING]->(r)

RETURN count(*);


// --------------------------------------------------
// SCHEMA REFACTORING – Remove Derived Nodes
// --------------------------------------------------

MATCH (:Movie)-[r:HAS_AGERATING|HAS_DURATION|RELEASED_IN]->()
DELETE r;

MATCH (:TVShow)-[r:HAS_AGERATING|HAS_DURATION|RELEASED_IN]->()
DELETE r;

MATCH (r:AgeRating) DETACH DELETE r;
MATCH (d:Duration) DETACH DELETE d;
MATCH (y:ReleaseYear) DETACH DELETE y;
