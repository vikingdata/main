drop procedure if exists sp_error;
DELIMITER //
CREATE PROCEDURE sp_error(IN n int4)
  BEGIN

  declare error1 int default 0;
  declare error2 int default 0;
  declare s1 text; 
  declare s2 text;
  declare n2 int default 0;

  set n2=n;

select "intitial", n, n2;
begin
  declare c1 cursor for select 1;
  DECLARE continue HANDLER FOR SQLEXCEPTION set error1 = 1;
  open c1;
  set n = n + 1;
  close c1;
end;

select "add 1", n, n2;

begin
  declare c2 cursor for select 1;
  DECLARE continue HANDLER FOR SQLEXCEPTION set error2 = 1;
  open c2;
  set n = @n + "a";
  close c2;
end;

select "add 'a'", n, n2;

  CASE
    WHEN error1 = 0 THEN set s1 = 'first exception not activated. Good';
    WHEN error1 = 1 THEN set s1 = 'first execption activated. Bad';
    ELSE begin end;
  end case;

  CASE
    WHEN error2 = 0 THEN set s2 = '2nd exception not activated. Bad';
    WHEN error2 = 1 THEN set s2 = '2nd exception activated. Good';
    ELSE begin end;
   end case;

  select n, n2, error1, error2, s1, s2; 
end ;
//
delimiter ;

call sp_error(1);
