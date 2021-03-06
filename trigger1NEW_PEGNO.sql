CREATE OR REPLACE TRIGGER NEW_PEGNO
BEFORE INSERT ON PEGNO
FOR EACH ROW 
DECLARE 
CONTP NUMBER;
CONTR NUMBER;
EX1 EXCEPTION;
EX2 EXCEPTION;
BEGIN
SELECT COUNT(COD_PEGNO) INTO CONTP FROM PEGNO WHERE CF_CLI=:NEW.CF_CLI;
SELECT COUNT(R.COD_RISCATTO) INTO CONTR 
FROM RISCATTO R JOIN PEGNO P ON P.COD_PEGNO=R.COD_PEGNO 
WHERE P.CF_CLI=:NEW.CF_CLI;
IF CONTP>=3 AND CONTR<3 THEN RAISE EX1;
END IF;
EXCEPTION
WHEN EX1 THEN
RAISE_APPLICATION_ERROR(-20104,'ATTENZIONE: IMPOSSIBILE REGISTRARE PEGNO, CLIENTE CON TROPPI PEGNI NON RISCATTATI');
END;
/
