-- Procedure to calculate bonuses for employees
CREATE OR REPLACE PROCEDURE calculate_bonuses(p_bonus_rate NUMBER DEFAULT 0.10) AS
    
    TYPE EmployeeRec IS RECORD(
        id employee.id%TYPE,
        name employee.name%TYPE,
        salary employee.salary%TYPE,
        bonus employee.bonus%TYPE
    );

    TYPE EmployeeTable IS TABLE OF EmployeeRec;

    emp_list EmployeeTable;  -- renamed collection

BEGIN
    -- Fetch all employees into collection
    SELECT id, name, salary, bonus
    BULK COLLECT INTO emp_list
    FROM employee;

    FOR i IN 1 .. emp_list.COUNT LOOP

        -- Skip invalid salary
        IF emp_list(i).salary <= 0 THEN
            GOTO skip_employee;
        END IF;

        -- Compute bonus       
        emp_list(i).bonus := emp_list(i).salary * p_bonus_rate;

        -- Update table with calculated bonus
        UPDATE employee
        SET bonus = emp_list(i).bonus
        WHERE id = emp_list(i).id;

        CONTINUE;

        <<skip_employee>>
        DBMS_OUTPUT.PUT_LINE(
            'Skipping Employee ID ' || emp_list(i).id || 
            ' due to invalid salary!'
        );

    END LOOP;

    COMMIT;
END calculate_bonuses;
/
