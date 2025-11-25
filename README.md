# Employee Bonus system

### Name: 

### ID: 

## Description
This project demonstrates how to use **PL/SQL Collections**, **Records**, and **GOTO statements** together.  
The program calculates employee bonuses while skipping invalid salary entries using PL/SQL control structures.


## Features
- **Record Type**:  Defines employee structure (ID, name, salary, bonus)
- **Nested Table Collection**:  Stores multiple employee records in memory
- **GOTO Control Flow**: Skips employees with invalid salaries
- **DBMS_OUTPUT**: Prints formatted report to console 
- **Bulk Collect + Update**: Loads and updates employee data efficiently


## Description

| File Name           | Purpose  |
|--------------------|-----------------------|
| `create_table.sql`   | Creates the `employees` table and inserts employee records with salaries.|
| `calculate_bonus.sql`    | Contains the stored procedure that loads employees into a collection, calculates bonus amounts, skips invalid salaries using `GOTO`, and updates the database. |
| `display.sql`     | Contains the stored procedure that prints employees data (ID, name, salary, bonus) using `DBMS_OUTPUT`.|
| `run.sql`       | Runs the program by calling both procedures: calculates bonuses then displays results. |

