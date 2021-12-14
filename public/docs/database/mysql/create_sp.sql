  create database if not exists test_sp;
  use test_sp;
  drop procedure if exists n;
  drop procedure if exists sp_i;
  drop procedure if exists sp_iio;
  drop procedure if exists sp_ioi;
  drop procedure if exists sp_io;
  drop procedure if exists sp_errorcheck;

DELIMITER //
CREATE PROCEDURE n()
    BEGIN
  SELECT now();
    END //

DELIMITER ;

-- Simple procedure. It takes a number and adds 10. 

DELIMITER //
CREATE PROCEDURE sp_i(IN no1 int4)
  BEGIN
    select 'start', no1;
    select no1 + 10 into no1;
    select 'end', no1;
	 
  END //
DELIMITER ;


--  Simple function, adds one day to time.
drop procedure if exists sp_o;
DELIMITER //
  CREATE PROCEDURE sp_o(out VAR1 int, inout VAR2 int)
    BEGIN
    select 'start', VAR1, VAR2, @GLOBAL1;
    set VAR1 = @GLOBAL1;
    select 4 into VAR2;
    select 'end', VAR1, VAR2, @GLOBAL1;
    END //
DELIMITER ;

--  Simple procdure, adds two numbers together.

drop procedure if exists sp_iio;
DELIMITER //
  CREATE PROCEDURE sp_iio(in no1 int, In no2 int, OUT no3 int, OUT no4 int)
    BEGIN
    DECLARE s int DEFAULT 0;
    set s = no1 + no2;
    select no3 + 1  into no3;
    set no4 = 5;
    select 'done', s, no1, no2, no3, no4;
    END //
DELIMITER ;
      

-- another way
DELIMITER //
CREATE PROCEDURE sp_ioi(inout no1 int, In no2 int)
  BEGIN
  set no1 = no1 + no2;
  select 'done', no1, no2;
END //
DELIMITER ;

-- simple one inout variables

DELIMITER //
  CREATE procedure sp_io(inout no1 int)
    BEGIN
    declare temp int default 100;
    select no1 + temp into no1;
    select 'done', no1, temp; 
END //
DELIMITER ;


-- simple one inout variables, with error

DELIMITER //
  CREATE PROCEDURE sp_errorcheck(inout no1 int)
BEGIN
    IF no1 is NULL then set no1 = -1; END IF; 
    set no1 = 1000; 
    select 'done', no1;
    END //
DELIMITER ;

  call n();
  call sp_i(1);

  set @temp1 = 2000;
  set @temp2 = 2000;
  call sp_iio(1,1, @temp2, @temp2);
  select 'iio GOOD', @temp1, @temp2;

  set @no3 = 2000;
  set @no4 = 2000;
  call sp_iio(1,1, @no3, @no4);
  select 'iio BAD ', @no3, @no3;

  set @io = 3000;
  call sp_ioi(@io,1);
  select 'ioi', @io; 

  call sp_io(@io);
  select 'io', @io;

  call sp_errorcheck(@io);
  select 'ec', @io;

  call sp_errorcheck(@io);
  select 'ec', @io;

  set @GLOBAL1 = 3; 
  set @i1 = 1;
  set @i2 = 2;
  select "env", @i1, @i2;
  call sp_o(@i1, @i2);
  select "env", @i1, @i2;

  set @i1 = 1;
  select "env", @i1;
  call sp_i(@i1);
  select "env", @i1;
	  
