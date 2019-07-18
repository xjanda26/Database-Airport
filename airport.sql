drop materialized view passengers;
drop table app_log;
drop table flight;
drop table gate;
drop table gate_plane_type;
drop table person;
drop table plane;
drop table plane_ticket;
drop table plane_travel_class;
drop table plane_type;
drop table terminal;
drop table travel_class;
drop sequence log_seq_id;
drop index revi_index;

CREATE TABLE terminal 
(
  TERMINAL_ID INT  NOT NULL,
  TERMINAL_NAME VARCHAR(100) NOT NULL,
  TERMINAL_TYPE VARCHAR(100) NOT NULL,
  TERMINAL_LOCATION VARCHAR(100) NOT NULL,
  CONSTRAINT TERMINAL_PK PRIMARY KEY 
  (
    TERMINAL_ID 
  )
  ENABLE,
  UNIQUE (TERMINAL_NAME),
  UNIQUE (TERMINAL_LOCATION)
);

INSERT INTO terminal (terminal_id, terminal_name, terminal_type, terminal_location) VALUES ('1', 'Terminal 1', 'Domestic flights', 'East');
INSERT INTO terminal (terminal_id, terminal_name, terminal_type, terminal_location) VALUES ('2', 'Terminal 2', 'International flights', 'North');
INSERT INTO terminal (terminal_id, terminal_name, terminal_type, terminal_location) VALUES ('3', 'Terminal 3', 'Private flights', 'South');
INSERT INTO terminal (terminal_id, terminal_name, terminal_type, terminal_location) VALUES ('4', 'Terminal 4', 'International flights', 'West');

CREATE TABLE gate 
(
  GATE_ID int NOT NULL,
  GATE_NAME varchar(100) NOT NULL,
  TERMINAL_ID int NOT NULL,
  PRIMARY KEY (GATE_ID),
  CONSTRAINT fk_terminal 
    FOREIGN KEY (TERMINAL_ID) 
    REFERENCES terminal(TERMINAL_ID) ON DELETE CASCADE
  ENABLE
);

INSERT INTO gate (gate_id, gate_name, terminal_id) VALUES ('1', 'Gate 1', '1');
INSERT INTO gate (gate_id, gate_name, terminal_id) VALUES ('2', 'Gate 2', '1');
INSERT INTO gate (gate_id, gate_name, terminal_id) VALUES ('3', 'Gate 3', '2');
INSERT INTO gate (gate_id, gate_name, terminal_id) VALUES ('4', 'Gate 4', '4');
INSERT INTO gate (gate_id, gate_name, terminal_id) VALUES ('5', 'Gate 5', '3');

CREATE TABLE flight 
(
  FLIGHT_ID int NOT NULL,
  GATE_ID int NOT NULL,
  DEPARTURE_TIME timestamp(0) NOT NULL,
  FLIGHT_TIME int NOT NULL,
  PRIMARY KEY (FLIGHT_ID),
  UNIQUE (DEPARTURE_TIME),
  CONSTRAINT fk_gate 
    FOREIGN KEY (GATE_ID) 
    REFERENCES gate(GATE_ID) ON DELETE CASCADE
  ENABLE
);
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('1', '5', TIMESTAMP '2019-02-19 3:45:00', '3');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('2', '1', TIMESTAMP '2019-02-19 8:00:00', '3');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('3', '2', TIMESTAMP '2019-02-22 8:30:00', '1');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('4', '3', TIMESTAMP '2019-02-24 8:00:00', '3');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('5', '4', TIMESTAMP '2019-02-24 8:10:00', '3');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('6', '1', TIMESTAMP '2019-02-24 8:15:00', '4');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('7', '3', TIMESTAMP '2019-02-24 8:30:00', '8');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('8', '4', TIMESTAMP '2019-02-24 8:45:00', '9');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('9', '3', TIMESTAMP '2019-02-24 9:00:00', '2');
INSERT INTO flight (flight_id, gate_id, departure_time, flight_time) VALUES ('10', '5', TIMESTAMP '2019-02-25 19:15:10', '4');

CREATE TABLE plane_type 
(
  PLANE_TYPE_ID int NOT NULL,
  PLANE_NAME varchar(100) NOT NULL,
  PRIMARY KEY (PLANE_TYPE_ID),
  UNIQUE (PLANE_NAME)
);

INSERT INTO plane_type (plane_type_id, plane_name) VALUES ('1', 'Airbus A220');
INSERT INTO plane_type (plane_type_id, plane_name) VALUES ('2', 'Boeing 747-8');

CREATE TABLE travel_class
(
  TRAVEL_CLASS_ID int NOT NULL,
  TRAVEL_CLASS_NAME varchar(100) NOT NULL,
  SEATS_COUNT int NOT NULL,
  PRIMARY KEY (TRAVEL_CLASS_ID),
  UNIQUE (TRAVEL_CLASS_NAME)
);

INSERT INTO travel_class (travel_class_id, travel_class_name, seats_count) VALUES ('1', 'Premium', '20');
INSERT INTO travel_class (travel_class_id, travel_class_name, seats_count) VALUES ('2', 'Business', '120');
INSERT INTO travel_class (travel_class_id, travel_class_name, seats_count) VALUES ('3', 'First class', '5');

CREATE TABLE plane
(
  PLANE_ID int NOT NULL,
  PLANE_TYPE_ID int NOT NULL,
  MANUFACTURER varchar(100) NOT NULL,
  DATE_OF_MANUFACTURE date NOT NULL,
  DATE_OF_LAST_REVISION date NOT NULL,
  CREW_MEMBERS_COUNT int NOT NULL,
  PRIMARY KEY (PLANE_ID),
  CONSTRAINT fk_plane_type 
    FOREIGN KEY (PLANE_TYPE_ID) 
    REFERENCES plane_type (PLANE_TYPE_ID) ON DELETE CASCADE
  ENABLE
);

INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (1, 1, 'Airbus', DATE '2017-05-04', DATE '2018-06-07', '10');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (2, 1, 'Airbus', DATE '2018-08-20', DATE '2019-03-20', '15');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (3, 1, 'Airbus', DATE '2017-05-04', DATE '2018-06-07', '10');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (4, 2, 'Boeing', DATE '2018-08-01', DATE '2018-08-20', '8');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (5, 2, 'Boeing', DATE '2017-01-04', DATE '2019-03-20', '10');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (6, 1, 'Airbus', DATE '2018-11-05', DATE '2018-08-20', '13');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (7, 1, 'Airbus', DATE '2016-05-21', DATE '2019-03-20', '11');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (8, 1, 'Airbus', DATE '2018-12-20', DATE '2019-02-20', '17');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (9, 2, 'Boeing', DATE '2017-10-13', DATE '2018-03-31', '12');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (10, 1, 'Airbus', DATE '2018-02-20', DATE '2018-08-29', '11');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (11, 1, 'Airbus', DATE '2018-02-21', DATE '2018-08-30', '9');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (12, 2, 'Boeing', DATE '2018-02-15', DATE '2018-08-29', '11');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (13, 2, 'Boeing', DATE '2018-12-21', DATE '2018-08-30', '9');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (14, 1, 'Airbus', DATE '2018-02-21', DATE '2018-08-30', '13');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (15, 2, 'Boeing', DATE '2018-02-15', DATE '2018-08-29', '11');
INSERT INTO plane (plane_id, plane_type_id, manufacturer, date_of_manufacture, date_of_last_revision, crew_members_count) VALUES (16, 2, 'Boeing', DATE '2018-12-21', DATE '2018-08-31', '9');

CREATE TABLE plane_travel_class 
(
  PLANE_ID int NOT NULL,
  TRAVEL_CLASS_ID int NOT NULL,
  CONSTRAINT fk_plane 
    FOREIGN KEY (PLANE_ID) 
    REFERENCES plane (PLANE_ID) ON DELETE CASCADE
  ENABLE,
  CONSTRAINT fk_travel_class 
    FOREIGN KEY (TRAVEL_CLASS_ID) 
    REFERENCES travel_class (TRAVEL_CLASS_ID) ON DELETE CASCADE
  ENABLE
);

INSERT INTO plane_travel_class (plane_id, travel_class_id) VALUES (1, 1);
INSERT INTO plane_travel_class (plane_id, travel_class_id) VALUES (1, 2);
INSERT INTO plane_travel_class (plane_id, travel_class_id) VALUES (1, 3);
INSERT INTO plane_travel_class (plane_id, travel_class_id) VALUES (2, 1);
INSERT INTO plane_travel_class (plane_id, travel_class_id) VALUES (2, 2);

CREATE TABLE person 
(
  PERSON_ID int NOT NULL,
  FIRST_NAME varchar(100) NOT NULL,
  LAST_NAME varchar(100) NOT NULL,
  ADDRESS varchar(100) NOT NULL,
  PIN int NOT NULL CHECK(length(PIN) > 9 AND length(PIN) < 12),
  PHONE_NUMBER varchar(100) NOT NULL,
  EMAIL varchar(100) NOT NULL,
  PERSON_TYPE varchar(10) CHECK( PERSON_TYPE in ('Employee','Passenger')) NOT NULL,
  PERSON_POSITION varchar(100) DEFAULT NULL,
  SALARY int DEFAULT NULL,
  START_DATE date DEFAULT NULL,
  CONTRACT_TYPE varchar(3) CHECK( CONTRACT_TYPE in ('DPP','DPC','SPP')),
  NATIONALITY varchar(100) DEFAULT NULL,
  PASSPORT_NUMBER int DEFAULT NULL,
  PASSPORT_VALID_UNTIL date DEFAULT NULL,
  PASSPORT_NATION varchar(100) DEFAULT NULL,
  PRIMARY KEY (PERSON_ID),
  UNIQUE (PHONE_NUMBER),
  UNIQUE (EMAIL),
  UNIQUE (PASSPORT_NUMBER)
);

INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, person_position, salary, start_date, contract_type)
    VALUES ('1', 'Petr', 'Nov�k', 'Bo�et�chova 2', '9504055287', '741648411', 'email@email.com', 'Employee', '�editel', '50000', DATE '2018-07-07', 'SPP');    
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('2', 'Ivan', 'Ohrada', 'Bo�et�chova 1', '9408015347', '718097534', 'testemail@email.com', 'Passenger', 'Czech', '571198751', DATE '2020-07-07', 'Czech Republic');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('3', 'Jana', 'Ohradov�', 'Bo�et�chova 1', '9008015747', '718852502', 'jana.ohra@email.com', 'Passenger', 'Czech', '341126741', DATE '2023-01-07', 'Czech Republic');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('4', 'Juraj', 'Kamen', '1. M�ja', '7108055917', '0922090934', 'rock@email.com', 'Passenger', 'Slovak', '5717337751', DATE '2019-07-07', 'Slovak Republic');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('5', 'So�a', 'Nov�kov�', 'J�na Bottu', '9823015347', '0918096934', 'sonanovak@email.com', 'Passenger', 'Slovak', '436192051', DATE '2020-12-07', 'Slovak Republic');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, person_position, salary, start_date, contract_type)
    VALUES ('6', 'Igor', 'Omnik', 'Komensk�ho 1', '9123015887', '745027534', 'omnik@email.com', 'Employee', 'SBS', '24500', DATE '2020-07-07', 'SPP');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('7', 'Ladislav', 'Slan�', 'Pod hradem 1', '9528953303', '718857574', 'sol@email.com', 'Passenger', 'Pole', '9658428751', DATE '2021-09-17', 'Poland');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('8', 'Henri', 'Black', 'Street', '7854960747', '702896502', 'black23@email.com', 'Passenger', 'Briton', '985546741', DATE '2020-07-31', 'United Kingdom');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('9', 'Eli�ka', 'Hrn��kov�', '�doln� 44', '5010805477', '602209074', 'eli.hr@email.com', 'Passenger', 'Czech', '6417337751', DATE '2019-04-21', 'Czech Republic');
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('10', 'Ji��', 'No�i�ka', 'Ivanovick� n�m�st� 64', '9632505347', '721054934', 'leg.j@email.com', 'Passenger', 'Czech', '739158051', DATE '2024-12-07', 'Czech Republic');

CREATE TABLE plane_ticket
(
  PLANE_TICKET_ID int NOT NULL,
  PERSON_ID int DEFAULT NULL,
  FLIGHT_ID int NOT NULL,
  TRAVEL_CLASS_ID int NOT NULL,
  SEAT int NOT NULL,
  PRIMARY KEY (PLANE_TICKET_ID),
  CONSTRAINT flight_fk FOREIGN KEY (FLIGHT_ID) REFERENCES flight (FLIGHT_ID) ON DELETE CASCADE,
  CONSTRAINT travel_class_fk FOREIGN KEY (TRAVEL_CLASS_ID) REFERENCES travel_class (TRAVEL_CLASS_ID) ON DELETE CASCADE,
  CONSTRAINT person_fk FOREIGN KEY (PERSON_ID) REFERENCES person (PERSON_ID) ON DELETE SET NULL
);

INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (1, 2, 1, 1, 1);
    
INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (2, 3, 1, 1, 2);
    
INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (3, 4, 2, 1, 3);
    
INSERT INTO plane_ticket (plane_ticket_id, flight_id, travel_class_id, seat)
    VALUES (4, 2, 3, 1);
    
INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (5, 7, 8, 1, 50);
    
INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (6, 8, 4, 2, 20);
    
INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (7, 9, 3, 1, 11);
    
INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (8, 5, 4, 2, 2);
    
INSERT INTO plane_ticket (plane_ticket_id, person_id, flight_id, travel_class_id, seat)
    VALUES (9, 10, 3, 3, 18);

INSERT INTO plane_ticket (plane_ticket_id, flight_id, travel_class_id, seat)
    VALUES (10, 3, 3, 18);

INSERT INTO plane_ticket (plane_ticket_id, flight_id, travel_class_id, seat)
    VALUES (11, 4, 3, 1);
    
CREATE TABLE gate_plane_type
(
  GATE_ID int NOT NULL,
  PLANE_TYPE_ID int NOT NULL,
  CONSTRAINT gate_fk FOREIGN KEY (GATE_ID) REFERENCES gate (GATE_ID) ON DELETE CASCADE,
  CONSTRAINT plane_type_fk FOREIGN KEY (PLANE_TYPE_ID) REFERENCES plane_type (PLANE_TYPE_ID) ON DELETE CASCADE
);

INSERT INTO gate_plane_type (GATE_ID, PLANE_TYPE_ID) VALUES (1,	1);
INSERT INTO gate_plane_type (GATE_ID, PLANE_TYPE_ID) VALUES (1,	2);
INSERT INTO gate_plane_type (GATE_ID, PLANE_TYPE_ID) VALUES (2,	1);
INSERT INTO gate_plane_type (GATE_ID, PLANE_TYPE_ID) VALUES (2,	2);
INSERT INTO gate_plane_type (GATE_ID, PLANE_TYPE_ID) VALUES (3,	1);
INSERT INTO gate_plane_type (GATE_ID, PLANE_TYPE_ID) VALUES (4,	2);
INSERT INTO gate_plane_type (GATE_ID, PLANE_TYPE_ID) VALUES (5,	1);
---==========================
--4. scrip
CREATE TABLE app_log
(
 log_id int NOT NULL,
 log_date TIMESTAMP,
 log_text varchar2(128)
);
---==========================
CREATE SEQUENCE log_seq_id minvalue 1 increment by 1;
---==========================
create or replace trigger app_trg_log_id before insert on app_log for each row
begin
    if inserting then
        if :new.log_id is NULL then
            select log_seq_id.nextval into :new.log_id from dual;
        end if;
        
        if :new.log_date is NULL then
            select systimestamp into :new.log_date from dual;
        end if;
    end if;    
end;
/
---==========================
create or replace procedure log_write (
 l_log_text IN varchar2
)
as
l_log_string varchar2(128);

begin
    insert into app_log(log_text) values (l_log_text);
    
    exception
     when others then 
        begin
            l_log_string := substr(sqlerrm, 1, 128);
            insert into app_log(log_text) values (l_log_string);
            commit;
        end;
end;
/
---==========================
create or replace trigger person_changed after insert or update or delete on person
begin
    if inserting then
        log_write('Into table person was something inserted');
    elsif updating then
        log_write('Table person is updated');
    elsif deleting then
        log_write('From table person was something deleted');
    end if;
end;
/
INSERT INTO person (person_id, first_name, last_name, address, pin, phone_number, email, person_type, nationality, passport_number, passport_valid_until, passport_nation)
    VALUES ('11', 'John', 'Triangle', 'Na hrade 12', '9632505347', '725554934', 'lags.j@email.com', 'Passenger', 'Czech', '75848051', DATE '2020-12-07', 'Czech Republic');
delete from person where address = 'Na hrade 12';
---==========================
CREATE OR REPLACE PROCEDURE get_customer_cursor(
	   c_customer OUT SYS_REFCURSOR)
IS
BEGIN

  OPEN c_customer FOR
  SELECT * FROM person WHERE person_type = 'Passenger';
END;
/

DECLARE 
  c_customer SYS_REFCURSOR;
  temp_customer person%ROWTYPE;
BEGIN
 
  get_customer_cursor(c_customer);
 
  LOOP
 
	FETCH c_customer INTO temp_customer;

        EXIT WHEN c_customer%NOTFOUND;

        dbms_output.put_line(temp_customer.first_name || ' ' || temp_customer.last_name);
 
  END LOOP;
 
  CLOSE c_customer;
 
END;
/
---==========================
create or replace procedure add_flight(
f_id in int,
g_id in int,
d_time in TIMESTAMP,
f_time in int)
as
f_log_str app_log.log_text%type;

begin
    insert into flight(flight_id, gate_id, departure_time, flight_time) values (f_id, g_id, d_time, f_time);
    
    exception
        when others then
            begin
                f_log_str := substr(sqlerrm, 1, 128);
                insert into app_log(log_text) values (f_log_str);
                commit;
            end;
end;
/
---==========================
EXPLAIN PLAN FOR 
    SELECT plane_type.plane_name, count(plane_type.plane_name) AS Number_of_aircrafts
    FROM plane_type NATURAL JOIN plane
    WHERE plane.date_of_last_revision = DATE '2019-03-20'
    GROUP BY plane_type.plane_name;
    
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY());

create index revi_index on plane(plane_type_id);
---==========================
grant select on person to xjezek15;
grant select on plane_ticket to xjezek15;
grant select on flight to xjezek15;
grant select on gate to xjezek15;
---==========================
CREATE MATERIALIZED VIEW passengers
BUILD IMMEDIATE
REFRESH COMPLETE
AS ( SELECT person.first_name, person.last_name, person.passport_number, flight.departure_time, gate.gate_name
FROM person NATURAL JOIN plane_ticket NATURAL JOIN flight NATURAL JOIN gate);

grant all on passengers to xjezek15;
---==========================
commit;