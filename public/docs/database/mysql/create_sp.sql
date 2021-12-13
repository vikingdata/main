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
drop procedure if exists sp_o;
DELIMITER //
  CREATE PROCEDURE sp_o(in no1 int, out VAR1 int, inout VAR2 int)
    BEGIN
    set VAR1 = @GLOBAL1;
    select -100 into VAR2;
    select 'done', @VAR1, @VAR2, @temp1, @temp2, @GLOBAL1;
    END //
DELIMITER ;

--  Simple procdure, adds two numbers together.

drop procedure if exists sp_iio;
DELIMITER //
  CREATE PROCEDURE sp_iio(in no1 int, In no2 int, OUT no3 int, OUT no4 int)
    BEGIN
    DECLARE s int DEFAULT 0;
    set @s = @no1 + @no2;
    select @no3 + 1  into @no3;
    set @no4 = 5;
    select 'done', @s, @no3, @no1, @no2, @no3, @no4;
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

  set @GLOBAL1 = 99; 

  set @i1 = 10;
  set @i2 = 10;
  set @temp1 = 20;
  set @temp2 = 20;
  select "INITIAL", @i1, @i2, @temp1, @temp2;
  call sp_o(0, @temp1, @temp2);
  select "r", @i1, @i2, @temp1, @temp2;

  set @i1 = 10;
  set @i2 = 10;
  set @temp1 = 20;
  set @temp2 = 20;
  select "INITIAL", @i1, @i2, @temp1, @temp2;
  call sp_o(0 , @i1, @i2);
  select "r", @i1, @i2, @temp1, @temp2;

      
