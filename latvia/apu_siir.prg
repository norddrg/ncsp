Procedure apu_siir
SET DATE YMD
SELECT ncsp_koo
SET FILTER TO 
DELETE ALL 
SELECT ncsp_ala
SET FILTER TO 
DELETE ALL
PACK 
SELECT ncsp_ryh
DELETE ALL
SET FILTER TO 
PACK 
SELECT ncsp_luv
DELETE ALL
SET FILTER TO 
PACK 
SELECT 0
USE apu
DELETE ALL
pack
SELECT 0
USE lat_2013 ALIAS ncsp_lat
GOTO top
DO WHILE NOT EOF()
  DO case
  CASE LEN(TRIM(code))=1 AND code>='A'
     SELECT ncsp_luv
     SEEK TRIM(ncsp_lat.code)
     IF FOUND()
        RECALL 
     ELSE 
        APPEND BLANK
        replace code WITH ncsp_lat.code
     ENDIF 
     replace released WITH .f., text WITH ncsp_lat.text
     replace chadate WITH DATE(), usedate WITH CTOD('2012/01/01') 
  CASE LEN(TRIM(code))=2
     SELECT ncsp_ryh
     SEEK TRIM(ncsp_lat.code)
     IF FOUND()
        RECALL 
     ELSE 
        APPEND BLANK
        replace code WITH ncsp_lat.code
     ENDIF 
     replace released WITH .f., text WITH ncsp_lat.text
     replace chadate WITH DATE(), usedate WITH CTOD('2012/01/01') 
  CASE LEN(TRIM(code))=3
     SELECT ncsp_ala
     SEEK TRIM(ncsp_lat.code)
     IF FOUND()
        RECALL 
     ELSE 
        APPEND BLANK
        replace code WITH ncsp_lat.code
     ENDIF 
     replace released WITH .f., text WITH ncsp_lat.text
     replace chadate WITH DATE(), usedate WITH CTOD('2012/01/01') 
  CASE LEN(TRIM(code))=5 AND SUBSTR(code,2,2)<>'ny' AND SUBSTR(code,5,1)<>'y' AND SUBSTR(code,5,1)<>'x'
     SELECT ncsp_koo
     SEEK TRIM(ncsp_lat.code)
     IF FOUND()
        RECALL 
     ELSE 
        APPEND BLANK
        replace code WITH ncsp_lat.code
     ENDIF 
     replace released WITH .f., text WITH ncsp_lat.text
     replace chadate WITH DATE(), usedate WITH CTOD('2012/01/01') 
  CASE LEN(TRIM(code))=1 AND code<'A'
     SELECT apu
     IF (LEN(TRIM(lc_code))=3 AND ncsp_ala.code=TRIM(lc_code)) OR (LEN(TRIM(lc_code))=2 AND ncsp_ryh.code=TRIM(lc_code))
        DELETE ALL
        pack
     ENDIF 
     APPEND BLANK
     replace code WITH ncsp_lat.code, text WITH ncsp_lat.text
  CASE LEN(TRIM(code))=5 AND (SUBSTR(code,5,1)='x' OR SUBSTR(code,5,1)='y')
      SELECT apu
      GOTO TOP 
      DO WHILE NOT EOF()
        SELECT ncsp_koo
        SEEK (SUBSTR(ncsp_lat.code,1,4)+TRIM(apu.code))
        IF FOUND()
           RECALL
        ELSE 
           APPEND BLANK
           replace code WITH SUBSTR(ncsp_lat.code,1,4)+apu.code
        ENDIF 
        replace released WITH .f.
        replace text WITH TRIM(ncsp_lat.text)+'; '+LOWER(apu.text)
        replace chadate WITH DATE(), usedate WITH CTOD('2012/01/01')         
        SELECT apu
        SKIP 
      ENDDO 
  CASE LEN(TRIM(code))=5 AND SUBSTR(code,2,2)='ny'
      SELECT ncsp_ala
      SEEK 'TNA'
      DO WHILE code='TN'
        SELECT ncsp_koo
        SEEK (SUBSTR(ncsp_ala.code,1,3)+SUBSTR(ncsp_lat.code,4,2))
        IF FOUND()
           RECALL
        ELSE 
           APPEND BLANK 
           replace code WITH SUBSTR(ncsp_ala.code,1,3)+SUBSTR(ncsp_lat.code,4,2)
        ENDIF 
        replace released WITH .f.
        replace text WITH TRIM(ncsp_ala.text)+'; '+LOWER(ncsp_lat.text)
        replace chadate WITH DATE(), usedate WITH CTOD('2012/01/01')         
        SELECT ncsp_ala
        SKIP 
      ENDDO 
  ENDCASE
  SELECT ncsp_lat
  lc_code=code
  skip
enddo
return
