CREATE TABLE Users (
id VARCHAR(36) PRIMARY KEY,
loginname VARCHAR(30) CHARACTER SET utf8 NOT NULL UNIQUE ,
firstname VARCHAR(30) CHARACTER SET utf8 NOT NULL,
lastname VARCHAR(30) CHARACTER SET utf8 NOT NULL,
password CHAR(128) NOT NULL,
deleted BOOLEAN DEFAULT false
);
CREATE TABLE Bugs (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
date DATETIME NOT NULL,
description_brief VARCHAR(120) CHARACTER SET utf8 NOT NULL,
description_full VARCHAR(5000) CHARACTER SET utf8,
user VARCHAR(36) NOT NULL,
status SMALLINT(1) NOT NULL,
priority SMALLINT(1) NOT NULL,
severity SMALLINT(1) NOT NULL,
deleted BOOLEAN DEFAULT false
);
CREATE TABLE BugsHistory (
id VARCHAR(36) PRIMARY KEY,
bug_id INT,
date DATETIME NOT NULL,
action INT(1) NOT NULL,
comment VARCHAR(1000) CHARACTER SET utf8,
user VARCHAR(36) NOT NULL,
deleted BOOLEAN DEFAULT false
);