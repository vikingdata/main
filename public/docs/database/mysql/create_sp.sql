  create database if not exists test_sp;
  use test_sp;
  drop procedure if exists n;
  drop procedure if exists sp_i;
  drop procedure if exists sp_day;
  drop procedure if exists sp_iio;
  drop procedure if exists sp_ioi;
  drop procedure if exists sp_io;
  drop procedure if exists sp_errorcheck;

-- we need to define variable for OUT variable.
set @o = 0;
set @io = 0;

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
  select no1 + 10;
  END //
DELIMITER ;


--  Simple function, adds one day to time.
DELIMITER //
  CREATE PROCEDURE sp_day(out date1 datetime)
    BEGIN
    set @date1 = now();
    select 'done', @date1;
    END //
DELIMITER ;

--  Simple procdure, adds two numbers together.

drop procedure if exists sp_iio_BUG;
DELIMITER //
  CREATE PROCEDURE sp_iio(in no1 int, In no2 int, OUT out1 int)
    BEGIN
    DECLARE s int DEFAULT 0;
    set @s = @no1 + @no2;
    select 5 into @out1;
    select 'done', @s, @no3, @no1, @no2, @o;
    END //
DELIMITER ;
      

-- another way
DELIMITER //
CREATE PROCEDURE sp_ioi(inout no1 int, In no2 int)
  BEGIN
  set @no1 = @no1 + @no2;
  select 'done', @no1, @no2;
END //
DELIMITER ;

-- simple one inout variables

DELIMITER //
  CREATE procedure sp_io(inout no1 int)
    BEGIN
    declare temp int default 100;
--     set @temp = 200;
    select @no1 + @temp into @no1;
    select 'done', @no1, @temp; 
END //
DELIMITER ;


-- simple one inout variables, with error

DELIMITER //
  CREATE PROCEDURE sp_errorcheck(inout no1 int)
BEGIN
    IF no1 is NULL then set no1 = -1; END IF; 
    set @no1 = 1000; 
    select 'done', @no1;
    END //
DELIMITER ;

  call n();
  call sp_i(1);
  call sp_day();
  set @o = 2000;
  call sp_iio_BUG(1,1, @o);
  select 'iio', @o;

  set @io = 3000;
  call sp_ioi(@io,1);
  select 'ioi', @io; 

  call sp_io(@io);
  select 'io', @io;

  call sp_errorcheck(@io);
  select 'ec', @io;

  call sp_errorcheck(@io);
  select 'ec', @io;
