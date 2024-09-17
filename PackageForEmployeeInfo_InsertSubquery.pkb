CREATE OR REPLACE PACKAGE BODY EmployeeNamesAndRowCounter AS
	FUNCTION row_counter(table_name VARCHAR2) RETURN NUMBER IS
    	row_count NUMBER;
    	sql_statement VARCHAR2(200) := 'SELECT COUNT(*) FROM '|| table_name;
    BEGIN
    	EXECUTE IMMEDIATE sql_statement INTO row_count;
    	RETURN row_count;
	END row_counter; 
	
	PROCEDURE LongestNameRecords IS
	BEGIN
		INSERT INTO LongestEmployeeNames (first_name, last_name, country)
			SELECT first_name, last_name, country_name
			FROM (
				WITH employee AS (
					    	SELECT first_name, last_name, department_id FROM HR.employees
					), department AS (
					    	SELECT department_id, location_id FROM HR.departments
					), location AS (
							SELECT location_id, country_id FROM HR.locations   
					), country AS (
					    	SELECT country_id, country_name FROM HR.countries
					), employee_sorted AS (
					    	SELECT employee.first_name, employee.last_name, country.country_name, DENSE_RANK() OVER (ORDER BY LENGTH(first_name||last_name) DESC) ranking_by_length 
						FROM employee
					    	JOIN department ON employee.department_id = department.department_id
					    	JOIN location ON department.location_id = location.location_id
					    	JOIN country ON location.country_id = country.country_id
					)
					SELECT first_name, last_name, country_name
					FROM employee_sorted
					WHERE ranking_by_length = 1
				);
	END LongestNameRecords;
END EmployeeNamesAndRowCounter;
