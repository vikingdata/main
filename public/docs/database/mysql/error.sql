DELIMITER //
CREATE PROCEDURE sp_flow(IN n int4)
  BEGIN

  error1 = 1;
  DECLARE continue HANDLER FOR SQLEXCEPTION
    begin
    select n + "test" into n;
    error1 = 0
    end

  error2 = 1;
  DECLARE continue HANDLER FOR SQLEXCEPTION
    begin
    select n + 1 into n;
    error2 = 0
    end

  CASE
    WHEN error1 = 0 THEN set error1 = 'first exception worked. Good';
    WHEN error1 = 1 THEN set error1 = 'first execption did not work. Bad';
    ELSE begin end;
  end case;

  CASE
    WHEN error2 = 1 THEN set s = '2nd exception not activated. Good';
    WHEN error2 = 0 THEN set s = '2nd exception activated. Bad';
    ELSE begin end;
   end case;

  select error1, error2; 

end ;
//
delimiter ;

