CREATE OR REPLACE PROCEDURE AGGIORNA_PROROGA(CODPGN PEGNO.COD_PEGNO%TYPE)
IS 
PR PEGNO.PROROGA%TYPE;
BEGIN
SELECT PROROGA INTO PR 
FROM PEGNO 
WHERE COD_PEGNO=CODPGN;
 IF PR IS NULL THEN UPDATE PEGNO 
					SET PROROGA=1,DATA_PEGNO=ADD_MONTHS(DATA_PEGNO,2) WHERE COD_PEGNO=CODPGN;
 ELSE IF PR=1 
		THEN UPDATE PEGNO SET PROROGA=2,DATA_PEGNO=ADD_MONTHS(DATA_PEGNO,2) WHERE COD_PEGNO=CODPGN;
 ELSE IF PR=2 
		THEN UPDATE PEGNO SET PROROGA=3,DATA_PEGNO=ADD_MONTHS(DATA_PEGNO,2) WHERE COD_PEGNO=CODPGN; 
END IF;
END IF;
END IF;
COMMIT;
EXCEPTION
 WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20462,'ATTENZIONE: PEGNO INESISTENTE');
 END;
 /