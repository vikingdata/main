
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

  set @temp1 = 2000;
  set @temp2 = 2000;
  call sp_iio(1,1, @temp1, @temp2);
  select 'iio GOOD', @temp1, @temp2;

  set @no3 = 2000;
  set @no4 = 2000;
  call sp_iio(1,1, @no3, @no4);
  select 'iio BAD ', @no3, @no3;

