CREATE OR REPLACE FUNCTION USCITE(DATA_INIZIALE DATE,DATA_FINE DATE)
 RETURN NUMBER IS USCITE NUMBER; 
 STIPENDI NUMBER; 
 BEGIN 
 USCITE:=0; -- USCITE SUI RIFORNIMENTI
 SELECT ROUND(SUM(C.QTACQUISTATA*(C.PREZZOCU*F.IVA/100)),2) INTO USCITE 
 FROM ARTICOLO A JOIN CONTIENE C ON C.CODART=A.CODART JOIN FAMIGLIA_ASSORTIMENTO F ON F.IDFAMASS=A.IDFAMASS 
 WHERE C.DATA_EMISSIONE BETWEEN DATA_INIZIALE AND DATA_FINE; 
 -- USCITE SUGLI STIPENDI

-- CALCOLO I MESI CHE INTERCORRONO TRA LE DUE DATE IN MODO DA MOLTIPLICARE
 -- LO STIPENDO PER IL NUMERO DI MESI.
 SELECT SUM(ROUND(MONTHS_BETWEEN(DATA_FINE,DATA_INIZIALE),0)*STIPENDIO) INTO STIPENDI 
 FROM DIPENDENTE; 
 USCITE:=USCITE+STIPENDI; 
 RETURN USCITE; 
 END;
 /