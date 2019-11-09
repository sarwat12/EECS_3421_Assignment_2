SET search_path TO A2;
-- Add below your SQL statements.
-- For each of the queries below, your final statement should populate the respective answer table (queryX) with the correct tuples. It should look something like:
-- INSERT INTO queryX (SELECT … <complete your SQL query here> …)
-- where X is the correct index [1, …,10].
-- You can create intermediate views (as needed). Remember to drop these views after you have populated the result tables query1, query2, ...
-- You can use the "\i a2.sql" command in psql to execute the SQL commands in this file.
-- Good Luck!

--Query 1 statements
--INSERT INTO query1
	(SELECT player.pname, country.cname, tournament.tname
	FROM player, champion, tournament, country
	WHERE player.pid = champion.pid AND
	player.cid = country.cid AND tournament.cid = player.cid
	ORDER BY player.pname ASC
	);

--Query 2 statements
--INSERT INTO query2
	/*(SELECT tournament.tname, SUM(court.capacity) AS "totalCapacity"
	FROM tournament, court
	WHERE court.tid = tournament.tid
	GROUP BY tournament.tname
	);*/
	
	(SELECT tournament.tname, court.capacity AS "totalCapacity"
	FROM tournament, court 	
	WHERE court.capacity >= ALL (SELECT SUM(court.capacity) AS "totalCapacity"
									FROM tournament, court
									WHERE court.tid = tournament.tid
									GROUP BY tournament.tid)
	AND court.tid = tournament.tid
	);
	
--Query 3 statements
--INSERT INTO query3
	(SELECT event.winid AS "p1id", player.pname AS "p1name", event.lossid AS "p2id", player.pname AS "p2name" 
	FROM event, player
	WHERE event.winid = player.pid 
	AND event.lossid = player.pid
	AND player.globalrank = (SELECT max(player.globalrank)
							FROM event, player
							WHERE event.winid = player.pid 
							AND event.lossid = player.pid
						)
	ORDER BY player.pname 
 );
  
--Query 4 statements
--INSERT INTO query4
	(SELECT champion.pid AS "pid", player.pname AS "pname"
	 FROM champion, player, tournament
	 WHERE player.pid = champion.pid
	 AND tournament.tid = champion.tid
	 ORDER BY player.pname ASC
	);
	

--Query 5 statements
--INSERT INTO query5

--Query 6 statements
--INSERT INTO query6

--Query 7 statements
--INSERT INTO query7

--Query 8 statements
--INSERT INTO query8

--Query 9 statements
--INSERT INTO query9

--Query 10 statements
--INSERT INTO query10
