// Länder mit Film- und Serienproduktionen zählen
MATCH (c:Country)
OPTIONAL MATCH (c)<-[:PRODUCED_IN]-(m:Movie)
OPTIONAL MATCH (c)<-[:PRODUCED_IN]-(s:TVShow)
WITH c.name AS Country, count(DISTINCT m) AS Moviecount, count(DISTINCT s) AS Showcount


// Gruppieren kleiner Länder unter "Others"
WITH 
  CASE 
    WHEN (Moviecount + Showcount) <= 100 THEN "Others"
    ELSE Country
  END AS GroupedCountry,
  sum(Moviecount) AS Moviecount,
  sum(Showcount) AS Showcount


// Länderwerte zwischenspeichern und später "Weltweit" ergänzen
WITH collect({Country: GroupedCountry, Moviecount: Moviecount, Showcount: Showcount}) AS Daten


// "Weltweit" Werte hinzufügen
WITH Daten + [
  {
    Country: "Weltweit",
    Moviecount: reduce(m = 0, row IN Daten | m + row.Moviecount),
    Showcount: reduce(s = 0, row IN Daten | s + row.Showcount)
  }
] AS FullData


// Prozentuale Verteilung berechnen
UNWIND FullData AS row
WITH 
  row.Country AS Country,
  row.Moviecount AS Moviecount,
  row.Showcount AS Showcount,
  toFloat(row.Moviecount + row.Showcount) AS Total


// Ergebnis ausgeben
WITH 
  Country,
  Moviecount,
  Showcount,
  round((toFloat(Moviecount) / Total) * 100, 2) AS MoviePercent,
  round((toFloat(Showcount) / Total) * 100, 2) AS ShowPercent


RETURN Country, Moviecount, Showcount, MoviePercent, ShowPercent
ORDER BY ShowPercent DESC;
