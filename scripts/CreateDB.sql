/* MySQL DDL script for creating the Database Schema for the Student Elections
 * application.
 *
 * @author Brendon Strowe
 */

DROP DATABASE IF EXISTS StudentElections;
CREATE DATABASE StudentElections;
USE StudentElections;

CREATE TABLE Candidate (
	id INT UNSIGNED AUTO_INCREMENT,
	firstName VARCHAR(64) NOT NULL,
	lastName VARCHAR(64) NOT NULL,
	CONSTRAINT pk_candidate PRIMARY KEY (id)
);

CREATE TABLE Office (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(64) UNIQUE NOT NULL,
	CONSTRAINT pk_office PRIMARY KEY (id)
);

CREATE TABLE Election (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(64) UNIQUE NOT NULL,
	pollsOpen DATETIME NOT NULL,
	pollsClose DATETIME NOT NULL,
	CONSTRAINT pk_election PRIMARY KEY (id)
);

CREATE TABLE ElectionOffice (
	id INT UNSIGNED UNIQUE AUTO_INCREMENT,
	electionId INT UNSIGNED,
	officeId INT UNSIGNED,
	sequence TINYINT UNSIGNED,
	CONSTRAINT pk_electionOffice PRIMARY KEY (electionId, officeId),
	CONSTRAINT fk_electionOffice_electionId FOREIGN KEY (electionId) REFERENCES Election (id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_electionOffice_officeId FOREIGN KEY (officeId) REFERENCES Office (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ElectionCandidate (
	candidateId INT UNSIGNED,
	electionOfficeId INT UNSIGNED,
	CONSTRAINT pk_electionCandidate PRIMARY KEY (candidateId, electionOfficeId),
	CONSTRAINT fk_electionCandidate_candidateId FOREIGN KEY (candidateId) REFERENCES Candidate (id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_electionCandidate_electionOfficeId FOREIGN KEY (electionOfficeId) REFERENCES ElectionOffice (id) ON UPDATE CASCADE ON DELETE CASCADE
);
