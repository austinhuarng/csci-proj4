DROP DATABASE IF EXISTS hw4;
CREATE DATABASE hw4;

USE hw4;
CREATE TABLE Users (
	email VARCHAR(30),
    username VARCHAR(50) PRIMARY KEY,
    pw VARCHAR(30)
);

CREATE TABLE Favorites (
	restoID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    username VARCHAR(50),
	restoname VARCHAR(50),
    address VARCHAR(80),
    pageurl VARCHAR(80),
    imgurl VARCHAR(80),
	rating DOUBLE,
    phone VARCHAR(20),
    cuisine VARCHAR(20),
    price VARCHAR(20),
    FOREIGN KEY fk1(username) REFERENCES Users(username)
);