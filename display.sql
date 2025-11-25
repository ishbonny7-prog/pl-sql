-- SQL script to display employee details along with their bonuses
CREATE OR REPLACE PROCEDURE display_employees AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- EMPLOYEE BONUS REPORT ---');
    DBMS_OUTPUT.PUT_LINE('ID | NAME | SALARY | BONUS');

    FOR r IN (SELECT * FROM employees) LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.id || ' | ' ||
            r.name || ' | ' ||
            r.salary || ' | ' ||
            r.bonus
        );
    END LOOP;
END display_employees;
/
