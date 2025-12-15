-- =====================================================
-- HOTEL MANAGEMENT SYSTEM
-- FULL SQL IMPLEMENTATION SCRIPT
-- Student: Ishimwe Bonny
-- ID: 27878
-- =====================================================

/* =============================

1. TABLE CREATION
   ============================= */

-- ROOM TYPES
CREATE TABLE room_types (
room_type_id NUMBER PRIMARY KEY,
type_name VARCHAR2(50) UNIQUE NOT NULL,
description VARCHAR2(100),
base_price NUMBER(10,2) NOT NULL
);

-- ROOMS
CREATE TABLE rooms (
room_id NUMBER PRIMARY KEY,
room_number VARCHAR2(10) UNIQUE NOT NULL,
room_type_id NUMBER NOT NULL,
status VARCHAR2(20) DEFAULT 'AVAILABLE'
CHECK (status IN ('AVAILABLE','OCCUPIED','MAINTENANCE')),
CONSTRAINT fk_room_type FOREIGN KEY (room_type_id)
REFERENCES room_types(room_type_id)
);

-- CUSTOMERS
CREATE TABLE customers (
customer_id NUMBER PRIMARY KEY,
first_name VARCHAR2(50) NOT NULL,
last_name VARCHAR2(50) NOT NULL,
email VARCHAR2(100) UNIQUE,
phone VARCHAR2(20),
city VARCHAR2(50)
);

-- EMPLOYEES
CREATE TABLE employees (
employee_id NUMBER PRIMARY KEY,
full_name VARCHAR2(100) NOT NULL,
role VARCHAR2(50) NOT NULL,
hire_date DATE DEFAULT SYSDATE
);

-- BOOKINGS
CREATE TABLE bookings (
booking_id NUMBER PRIMARY KEY,
customer_id NUMBER NOT NULL,
room_id NUMBER NOT NULL,
check_in DATE NOT NULL,
check_out DATE NOT NULL,
booking_status VARCHAR2(20)
CHECK (booking_status IN ('CONFIRMED','CANCELLED','COMPLETED')),
CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),
CONSTRAINT fk_booking_room FOREIGN KEY (room_id)
REFERENCES rooms(room_id)
);

-- PAYMENTS
CREATE TABLE payments (
payment_id NUMBER PRIMARY KEY,
booking_id NUMBER NOT NULL,
amount NUMBER(10,2) NOT NULL,
payment_date DATE DEFAULT SYSDATE,
payment_method VARCHAR2(20)
CHECK (payment_method IN ('CASH','CARD','MOBILE')),
CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id)
REFERENCES bookings(booking_id)
);

-- PUBLIC HOLIDAYS
CREATE TABLE public_holidays (
holiday_id NUMBER PRIMARY KEY,
holiday_date DATE UNIQUE NOT NULL,
description VARCHAR2(100)
);

-- AUDIT LOG
CREATE TABLE audit_log (
audit_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
username VARCHAR2(50),
action_type VARCHAR2(20),
table_name VARCHAR2(30),
action_date DATE DEFAULT SYSDATE,
status VARCHAR2(20),
message VARCHAR2(200)
);

/* =============================
2. DATA INSERTION (SAMPLE)
============================= */

INSERT INTO room_types VALUES (1,'Single','Single room',50);
INSERT INTO room_types VALUES (2,'Double','Double room',80);
INSERT INTO room_types VALUES (3,'Suite','Luxury suite',150);

INSERT INTO rooms VALUES (1,'101',1,'AVAILABLE');
INSERT INTO rooms VALUES (2,'102',2,'OCCUPIED');
INSERT INTO rooms VALUES (3,'201',3,'MAINTENANCE');

INSERT INTO customers VALUES (1,'John','Doe','[john@gmail.com](mailto:john@gmail.com)','0788000001','Kigali');
INSERT INTO customers VALUES (2,'Mary','Smith','[mary@gmail.com](mailto:mary@gmail.com)','0788000002','Huye');

INSERT INTO employees VALUES (1,'Eric Manzi','Manager',SYSDATE);
INSERT INTO employees VALUES (2,'Alice Uwase','Receptionist',SYSDATE);

INSERT INTO bookings VALUES (1,1,1,DATE '2025-12-01',DATE '2025-12-05','CONFIRMED');
INSERT INTO bookings VALUES (2,2,2,DATE '2025-12-03',DATE '2025-12-06','COMPLETED');

INSERT INTO payments VALUES (1,1,200,'CARD');
INSERT INTO payments VALUES (2,2,240,'CASH');

INSERT INTO public_holidays VALUES (1, DATE '2025-12-25','Christmas');

COMMIT;

/* =============================
3. PROCEDURES
============================= */

CREATE OR REPLACE PROCEDURE add_customer(
p_id NUMBER, p_fn VARCHAR2, p_ln VARCHAR2,
p_email VARCHAR2, p_phone VARCHAR2, p_city VARCHAR2
) AS
BEGIN
INSERT INTO customers VALUES (p_id,p_fn,p_ln,p_email,p_phone,p_city);
COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE update_room_status(
p_room NUMBER, p_status VARCHAR2
) AS
BEGIN
UPDATE rooms SET status=p_status WHERE room_id=p_room;
COMMIT;
END;
/

/* =============================
4. FUNCTIONS
============================= */

CREATE OR REPLACE FUNCTION total_payment(p_booking NUMBER)
RETURN NUMBER IS v_total NUMBER;
BEGIN
SELECT SUM(amount) INTO v_total FROM payments WHERE booking_id=p_booking;
RETURN NVL(v_total,0);
END;
/

/* =============================
5. AUDIT PROCEDURE
============================= */

CREATE OR REPLACE PROCEDURE log_audit(
p_action VARCHAR2, p_table VARCHAR2,
p_status VARCHAR2, p_message VARCHAR2
) AS
BEGIN
INSERT INTO audit_log(username,action_type,table_name,status,message)
VALUES(USER,p_action,p_table,p_status,p_message);
END;
/

/* =============================
6. TRIGGERS
============================= */

CREATE OR REPLACE TRIGGER trg_employee_restrict
BEFORE INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW
BEGIN
IF TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=ENGLISH') IN ('MON','TUE','WED','THU','FRI') THEN
log_audit('DML','EMPLOYEES','DENIED','Weekday restriction');
RAISE_APPLICATION_ERROR(-20010,'Operation not allowed on weekdays');
END IF;
END;
/

/* =============================
7. TEST QUERIES
============================= */

SELECT * FROM rooms;
SELECT * FROM bookings;
SELECT * FROM audit_log;

-- =============================
-- END OF FULL IMPLEMENTATION
-- =============================
