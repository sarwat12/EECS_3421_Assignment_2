SET search_path TO A2;
-- Add below your SQL statements.
-- For each of the queries below, your final statement should populate the respective answer table (queryX) with the correct tuples. It should look something like:
-- INSERT INTO queryX (SELECT … <complete your SQL query here> …)
-- where X is the correct index [1, …,10].
-- You can create intermediate views (as needed). Remember to drop these views after you have populated the result tables query1, query2, ...
-- You can use the "\i a2.sql" command in psql to execute the SQL commands in this file.
-- Good Luck!

CREATE VIEW sum_capacity(tid, tname, sum) AS
	SELECT tournament.tid, tournament.tname, SUM(court.capacity)
	FROM tournament JOIN court ON tournament.tid = court.tid
	GROUP BY tournament.tid, tournament.tname;



CREATE VIEW win_2011(pid11,pname11,win11) AS
	SELECT player.pid, player.pname, record.wins
	FROM record, player
	WHERE record.year = '2011'
	AND record.pid = player.pid;

CREATE VIEW win_2012(pid12,pname12,win12) AS
	SELECT player.pid, player.pname, record.wins
	FROM record, player
	WHERE record.year = '2012'
	AND record.pid = player.pid;

CREATE VIEW win_2013(pid13,pname13,win13) AS
	SELECT player.pid, player.pname, record.wins
	FROM record, player
	WHERE record.year = '2013'
	AND record.pid = player.pid;

CREATE VIEW win_2014(pid14,pname14,win14) AS
	SELECT player.pid, player.pname, record.wins
	FROM record, player
	WHERE record.year = '2014'
	AND record.pid = player.pid;

--Query 1 statements
INSERT INTO query1
	(SELECT player.pname, country.cname, tournament.tname
		FROM country 
		JOIN tournament ON country.cid = tournament.cid 
		JOIN champion ON tournament.tid = champion.tid
		JOIN player ON player.pid = champion.pid
		WHERE player.cid = country.cid
		ORDER BY player.pname ASC
	);

--Query 2 statements
INSERT INTO query2
	(SELECT tname, sum AS "totalCapacity"
		FROM sum_capacity
		WHERE sum = (SELECT max(sum) FROM sum_capacity)
		ORDER BY tname ASC
	);	
DROP VIEW sum_capacity;


--Query 3 statements
--INSERT INTO query3
	-- (SELECT event.winid AS "p1id", player.pname AS "p1name", event.lossid AS "p2id", player.pname AS "p2name" 
	-- FROM event, player
	-- WHERE event.winid = player.pid 
	-- AND event.lossid = player.pid
	-- AND player.globalrank = (SELECT max(player.globalrank)
							-- FROM event, player
							-- WHERE event.winid = player.pid 
							-- AND event.lossid = player.pid
						-- )
	-- ORDER BY player.pname 
 --);
  
-- --Query 4 statements
-- --INSERT INTO query4
	-- (SELECT champion.pid, player.pname
	 -- FROM champion, player
	 -- WHERE player.pid = champion.pid
	 -- AND champion.tid = ALL (SELECT tournament.tid FROM tournament)
	 -- ORDER BY player.pname ASC
	-- );
	-- (SELECT champion.pid, player.pname
		-- FROM champion
		-- JOIN player ON champion.pid = player.pid
		-- WHERE champion.tid = ALL (SELECT tournament.tid FROM tournament)
		-- ORDER BY player.pname ASC
	-- );


	 -- FROM champion JOIN player ON champion.pid = player.pid
	 -- JOIN tournament ON tournament.tid = champion.tid
	 -- WHERE tournament.tid = ALL (SELECT champion.tid FROM champion)
	 -- ORDER BY player.pname ASC
	-- );
	
--Query 5 statements
INSERT INTO query5
	(SELECT player.pid, player.pname, AVG(record.wins)/4 AS "avgwins"
		FROM record JOIN player ON record.pid = player.pid
		WHERE record.year >= 2011 AND record.year <= 2014
		GROUP BY player.pid, player.pname
		ORDER BY AVG(record.wins) DESC
		LIMIT 10
	);

--Query 6 statements
INSERT INTO query6
	(SELECT win_2011.pid11 AS "pid", win_2011.pname11 AS "pname"
		FROM win_2011, win_2012, win_2013, win_2014
		WHERE win_2012.win12 > win_2011.win11
		AND win_2013.win13 > win_2012.win12
		AND win_2014.win14 > win_2013.win13
		AND (win_2011.pid11 = win_2012.pid12 AND win_2012.pid12 = win_2013.pid13 AND win_2013.pid13 = win_2014.pid14 ) 
		ORDER BY pname ASC
	);
DROP VIEW win_2011;
DROP VIEW win_2012;
DROP VIEW win_2013;
DROP VIEW win_2014;

--Query 7 statements
--INSERT INTO query7

--Query 8 statements
--INSERT INTO query8

--Query 9 statements
--INSERT INTO query9

--Query 10 statements
--INSERT INTO query10
