DROP SCHEMA IF EXISTS A2 CASCADE;
CREATE SCHEMA A2;
SET search_path TO A2;

DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS record CASCADE;
DROP TABLE IF EXISTS court CASCADE;
DROP TABLE IF EXISTS tournament CASCADE;
DROP TABLE IF EXISTS event CASCADE;
DROP TABLE IF EXISTS query1 CASCADE;
DROP TABLE IF EXISTS query2 CASCADE;
DROP TABLE IF EXISTS query3 CASCADE;
DROP TABLE IF EXISTS query4 CASCADE;
DROP TABLE IF EXISTS query5 CASCADE;
DROP TABLE IF EXISTS query6 CASCADE;
DROP TABLE IF EXISTS query7 CASCADE;
DROP TABLE IF EXISTS query8 CASCADE;
DROP TABLE IF EXISTS query9 CASCADE;
DROP TABLE IF EXISTS query10 CASCADE;


-- The country table contains some countries in the world.
-- 'cid' is the id of the country.
-- 'cname' is the name of the country.
CREATE TABLE country(
    cid         INTEGER     PRIMARY KEY,
    cname       VARCHAR     NOT NULL
    );
    
-- The player table contains information about some tennis players.
-- 'pid' is the id of the player.
-- 'pname' is the name of the player.
-- 'globalrank' is the global rank of the player.
-- 'cid' is the id of the country that the player belongs to.
CREATE TABLE player(
    pid         INTEGER     PRIMARY KEY,
    pname       VARCHAR     NOT NULL,
    globalrank  INTEGER     NOT NULL,
    cid         INTEGER     REFERENCES country(cid) ON DELETE RESTRICT
    );

-- The record table contains information about players performance in each year.
-- 'pid' is the id of the player.
-- 'year' is the year.
-- 'wins' is the number of wins of the player in that year.
-- 'losses' is the the number of losses of the player in that year.
CREATE TABLE record(
    pid         INTEGER     REFERENCES player(pid) ON DELETE RESTRICT,
    year        INTEGER     NOT NULL,
    wins        INTEGER     NOT NULL,
    losses      INTEGER     NOT NULL,
    PRIMARY KEY(pid, year));

-- The tournament table contains information about a tournament.
-- 'tid' is the id of the tournament.
-- 'tname' is the name of the tournament.
-- 'cid' is the country where the tournament hold.
CREATE TABLE tournament(
    tid         INTEGER     PRIMARY KEY,
    tname       VARCHAR     NOT NULL,
    cid         INTEGER     REFERENCES country(cid) ON DELETE RESTRICT 
    );

-- The court table contains the information about tennis court
-- 'courtid' is the id of the court.
-- 'courtname' is the name of the court.
-- 'capacity' is the maximum number of audience the court can hold.
-- 'tid' is the tournament that this court is used for
--  Notice: only one tournament can happen on a given court.
CREATE TABLE court(
    courtid     INTEGER     PRIMARY KEY,
    courtname   VARCHAR     NOT NULL,
    capacity    INTEGER     NOT NULL,
    tid         INTEGER     REFERENCES tournament(tid) ON DELETE RESTRICT
    );

-- The champion table provides information about the champion of each tournament.
-- 'pid' refers to the id of the champion(player).
-- 'year' is the year when the tournament hold.
-- 'tid' is the tournament id.
CREATE TABLE champion(
    pid     INTEGER     REFERENCES player(pid) ON DELETE RESTRICT,
    year    INTEGER     NOT NULL, 
    tid     INTEGER     NOT NULL, /*REFERENCES tournament(tid) ON DELETE RESTRICT,*/
    PRIMARY KEY(tid, year));

-- The event table provides information about certain tennis games.
-- 'eid' refers to the id of the event.
-- 'year' is the year when the event hold.
-- 'courtid' is the id of the court where the event hold.
-- 'pwinid' is the id of the player who win the game.
-- 'plossid' is the id of the player who loss the game.
-- 'duration' is duration of the event, in minutes.
CREATE TABLE event(
    eid        INTEGER     PRIMARY KEY,
    year       INTEGER     NOT NULL,
    courtid    INTEGER     REFERENCES court(courtid) ON DELETE RESTRICT,
    winid      INTEGER     REFERENCES player(pid) ON DELETE RESTRICT,
    lossid     INTEGER     REFERENCES player(pid) ON DELETE RESTRICT,
    duration   INTEGER     NOT NULL
    );


-- The following tables will be used to store the results of your queries. 
-- Each of them should be populated by your last SQL statement that looks like:
-- "INSERT INTO QueryX (SELECT ...<complete your SQL query here> ... )"

CREATE TABLE query1(
    pname    VARCHAR,
    cname    VARCHAR,
    tname    VARCHAR    
);

CREATE TABLE query2(
    tname   VARCHAR,
    totalCapacity INTEGER    
);

CREATE TABLE query3(
    p1id    INTEGER,
    p1name  VARCHAR,
    p2id    INTEGER,
    p2name  VARCHAR    
);

CREATE TABLE query4(
    pid     INTEGER,
    pname   VARCHAR    
);

CREATE TABLE query5(
    pid      INTEGER,
    pname    VARCHAR,
    avgwins  REAL
);

CREATE TABLE query6(
    pid     INTEGER,
    pname   VARCHAR    
);

CREATE TABLE query7(
    pname    VARCHAR,
    year     INTEGER
);

CREATE TABLE query8(
    p1name  VARCHAR,
    p2name  VARCHAR,
    cname   VARCHAR    
);

CREATE TABLE query9(
    cname       VARCHAR,
    champions   INTEGER
);

CREATE TABLE query10(
    pname       VARCHAR
);

INSERT INTO country
VALUES ('1', 'Bangladesh'),
	('2', 'Canada'),
	('3', 'India'),
	('4', 'Pakistan'),
	('5', 'USA'),
	('6', 'Italy'),
	('7', 'France');

INSERT INTO player
VALUES ('1', 'Sarwat', '1', '1'),
	('2', 'Saiba', '2', '1'),
	('3', 'Shahrukh', '5', '3'),
	('4', 'Shruti', '67', '4'),
	('5', 'Salman', '87', '7'),
	('6', 'Sarwat', '23', '6'),
	('7', 'Nick', '11', '5');

INSERT INTO champion
VALUES ('1', '2015', '1'),
	('1', '2014', '2'),
	('1', '2004', '3'),
	('1', '2024', '4'),
	('1', '2064', '5'),
	('1', '2084', '6'),
	('1', '2044', '7'),
	('4', '2011', '2'),
	('5', '2012', '3'),
	('6', '2009', '4'),
	('2', '2010', '5'),
	('3', '2013', '6'),
	('7', '2008', '7');

INSERT INTO tournament
VALUES ('1', 'Bethune', '1'),
	('2', 'Stong', '2'),
	('3', 'Bergeron', '4'),
	('4', 'Stacie', '3'),
	('5', 'Lanes', '7'),
	('6', 'William Small', '6'),
	('7', 'Founders', '3');

INSERT INTO court
VALUES ('1', 'CourtA', '50', '1'),
	('2', 'CourtB', '53', '3'),
	('3', 'CourtC', '60', '5'),
	('4', 'CourtD', '71', '7'),
	('5', 'CourtE', '75', '4'),
	('6', 'CourtF', '80', '2'),
	('7', 'CourtG', '25', '4');

INSERT INTO event
VALUES ('1', '2019', '1', '1', '4', '50'),
	('2', '2018', '3', '1', '3', '44'),
	('3', '2017', '4', '2', '4', '21'),
	('4', '2019', '7', '5', '7', '23'),
	('5', '2015', '1', '2', '5', '19'),
	('6', '2011', '5', '7', '1', '32'),
	('7', '2012', '6', '6', '3', '45');


INSERT INTO record
VALUES ('1', '2019', '10', '2'),
	('1', '2011','3', '1'),
	('1', '2012','35', '1'),
	('1', '2013','45', '1'),
	('1', '2014', '50', '1'),
	('2', '2018', '5', '3'),
	('2', '2013', '3', '3'),
	('2', '2014', '6', '3'),
	('2', '2012', '2', '3'),
	('2', '2011', '1', '3'),
	('3', '2017', '2', '10'),
	('1', '2015', '11', '3'),
	('5', '2018', '5', '12'),
	('6', '2012', '20', '10'),
	('7', '2008', '17', '21');
