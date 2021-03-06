CREATE MATERIALIZED VIEW ANALISI_VENDITE_ANNUALI
BUILD IMMEDIATE -- CREA E CARICA IMMEDIATAMENTE I RISULTATI DELL'INTERROGAZIONE ALL'INTERNO
REFRESH FORCE -- SE E' POSSIBILE EFFETTUA REFRESH SUBITO
ON DEMAND -- CON ON DEMAND EFFETTUO IL REFRESH SOLO SU RICHIESTA ESPLICITA, QUINDI QUANDO ESEGUO IL JOB
AS
SELECT A.CODART,
SUM(C.QTACQUISTATA) AS QTACQUISTATA,
ROUND(SUM(C.QTACQUISTATA*(C.PREZZOCU+(C.PREZZOCU*F.IVA/100))),2) AS TOT_PAG_RIFO,
SUM(R.QTVENDUTA) AS QTVENDUTA,
ROUND(SUM(R.QTVENDUTA*((C.PREZZOCU+(C.PREZZOCU*F.IVA/100))+((C.PREZZOCU+(C.PREZZOCU*F.IVA/100))*F.IVA/100))),2) AS GUADAGNO
FROM ARTICOLO A JOIN FAMIGLIA_ASSORTIMENTO F ON F.IDFAMASS=A.IDFAMASS
JOIN CONTIENE C ON C.CODART=A.CODART
JOIN RIGUARDA R ON R.CODART=A.CODART
JOIN MOVIMENTO M ON M.COD_MOVIMENTO=R.COD_MOVIMENTO
WHERE EXTRACT(YEAR FROM M.DATA_STAMPA)=EXTRACT(YEAR FROM SYSDATE) AND
C.DATA_EMISSIONE=(
					SELECT MAX(DATA_EMISSIONE) 
					FROM CONTIENE 
					WHERE CODART=A.CODART AND DATA_EMISSIONE<M.DATA_STAMPA
				)
-- SI PRELEVA IL PREZZOCU RELATIVO ALL'ULTIMO RIFORNIMENTO
-- PER QUELL'ARTICOLO EFFETTUATO IN UNA DATA PRECEDENTE
GROUP BY A.CODART
ORDER BY A.CODART;
/
