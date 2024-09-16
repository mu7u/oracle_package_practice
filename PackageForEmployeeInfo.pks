/*
CREATE TABLE LongestEmployeeNames(
	FIRST_NAME VARCHAR2(20),
	LAST_NAME VARCHAR2(25),
	COUNTRY VARCHAR2(40)
)
*/
CREATE OR REPLACE PACKAGE EmployeeNamesAndRowCounter AS 
	FUNCTION row_counter(table_name VARCHAR2) RETURN NUMBER;
	PROCEDURE LongestNameRecords;
END EmployeeNamesAndRowCounter;
