CREATE OR REPLACE FUNCTION MATURATOPEGNI(DATAP DATE,VAL IN OUT NUMBER) 
RETURN NUMBER IS MESI NUMBER; 
BEGIN 
MESI:=0; 
MESI:=ROUND(MONTHS_BETWEEN(SYSDATE,DATAP),0); 
CASE 
		WHEN MESI=1 THEN VAL:=VAL+(VAL*10/100); 
		WHEN MESI=2 THEN VAL:=VAL+(VAL*13/100); 
		WHEN MESI=3 THEN VAL:=VAL+(VAL*17/100); 
		WHEN MESI=4 THEN VAL:=VAL+(VAL*20/100); 
		WHEN MESI=5 THEN VAL:=VAL+(VAL*32/100); 
	ELSE VAL:=VAL+(VAL*60/100); 
	END CASE; 
	RETURN VAL; 
EXCEPTION 
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20100,'ATTENZIONE: ERORRE NEL CALCOLO DEL MATURATO PEGNO');
END;
/