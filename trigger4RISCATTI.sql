CREATE OR REPLACE TRIGGER RISCATTI
BEFORE INSERT ON RISCATTO
FOR EACH ROW
DECLARE
DP DATE;
EX1 EXCEPTION;
BEGIN
SELECT DATA_PEGNO INTO DP FROM PEGNO WHERE COD_PEGNO=:NEW.COD_PEGNO;
IF ROUND(MONTHS_BETWEEN(SYSDATE,DP),0)>12 THEN
RAISE EX1;
END IF;
EXCEPTION WHEN EX1 THEN
RAISE_APPLICATION_ERROR(-20616,'ATTENZIONE: IMPOSSIBILE PROROGARE IL PEGNO, OGGETTO NON PIU RISCATTABILE');
END;
/