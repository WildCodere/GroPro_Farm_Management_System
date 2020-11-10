C
CREATE TABLE IF NOT EXISTS Inventory (
	name	TEXT NOT NULL,
	quantity	REAL NOT NULL,
	PRIMARY KEY(name)
);





CREATE TABLE IF NOT EXISTS User (
	ID	INTEGER NOT NULL,
	Username	TEXT NOT NULL,
	Password	TEXT NOT NULL,
	Role	TEXT NOT NULL,
	PRIMARY KEY(Username),
	FOREIGN KEY(ID) REFERENCES People(ID)
);
CREATE TABLE IF NOT EXISTS People (
	ID	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	Firstname	TEXT NOT NULL,
	Lastname	TEXT NOT NULL,
	Gender	TEXT NOT NULL,
	District	TEXT NOT NULL,
	Phone	TEXT,
	Email	TEXT
);
INSERT INTO User VALUES (1,'Emmmwinama','gimmesigns1997','Owner');
INSERT INTO People VALUES (1,'Emmanuel','Mwinama','Male','Blantyre','0888401762','mwinamaemmanuel@gmail.com');
