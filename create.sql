PRAGMA FOREIGN_KEYS = ON;

DROP TABLE IF EXISTS districts;

CREATE TABLE districts(
	code INTEGER CONSTRAINT codeRange CHECK (1 <= code AND code <= 40),
	dname TEXT CONSTRAINT dnameExists NOT NULL,
	region TEXT DEFAULT 'C' CONSTRAINT regionName CHECK (region in ('C','M','A')),
	CONSTRAINT codePK PRIMARY KEY(code)
);

DROP TABLE IF EXISTS Municipalities;

CREATE TABLE Municipalities(
	code INT,
	name VARCHAR(40),
	district INT,
	PRIMARY KEY(code),
	FOREIGN KEY(district) REFERENCES districts(code) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO districts(code,dname) VALUES (13 , 'Porto');

SELECT * FROM districts;

INSERT INTO Municipalities VALUES (1308, 'Matosinhos', 13);

UPDATE districts SET code = 14 WHERE code = 13;

SELECT * FROM Municipalities;

DROP TABLE IF EXISTS participations;

CREATE TABLE participations(
	district INT,
	registered_voters INT CHECK (0 <= registered_voters),
	voters INT CHECK (0 <= voters),
	abstentions INT CHECK (0 <= abstentions),
	blank_votes INT CHECK (0 <= blank_votes),
	null_voters INT CHECK (0 <= null_voters),
	CHECK (registered_voters = voters + abstentions),
	PRIMARY KEY(district),
	FOREIGN KEY(district) REFERENCES districts(code)
);


