CREATE OR REPLACE 
FUNCTION ROUNDABNT
 (AVALOR DOUBLE PRECISION,
  ADECIMAIS SMALLINT)
 RETURN DOUBLE PRECISION
 IS
-- PL/SQL Specification
POW DOUBLE PRECISION; 
FRACVALUE DOUBLE PRECISION; 
POWVALUE DOUBLE PRECISION;
RESTPART DOUBLE PRECISION;
VDELTA DOUBLE PRECISION;
INTCALC NUMBER(19); 
FRACCALC NUMBER(19); 
LASTNUMBER NUMBER(19); 
INTVALUE NUMBER(19); 
FRACINTCALC DOUBLE PRECISION; 
FRACPOWVALUE DOUBLE PRECISION;
-- PL/SQL Block
BEGIN
    POW       := POWER(10, ABS(ADECIMAIS) );
    POWVALUE  := ABS(AVALOR) / 10 ;
    INTVALUE  := TRUNC(POWVALUE);
    FRACVALUE := POWVALUE -INTVALUE;
    VDELTA := (1*(POWER(10,-5)));

   POWVALUE := ROUND( FRACVALUE * 10 * POW, 9);
   INTCALC  := TRUNC( POWVALUE );
   FRACCALC := TRUNC( (POWVALUE-INTCALC) * 100 );        

   IF (FRACCALC > 50) THEN
     INTCALC := INTCALC + 1;   
   ELSE 
       IF (FRACCALC = 50) THEN
       BEGIN
         FRACINTCALC := (INTCALC/10)-TRUNC((INTCALC/10));
         LASTNUMBER := ROUND(FRACINTCALC * 10);
    
            IF (MOD(LASTNUMBER,2) <> 0) THEN
                INTCALC := INTCALC + 1; 
            ELSE
                BEGIN
                FRACPOWVALUE := (POWVALUE*10)-TRUNC((POWVALUE*10));
                RESTPART := FRACPOWVALUE ;
    
                IF RESTPART > VDELTA THEN
                    INTCALC := INTCALC + 1; 
                END IF;
                END;
            END IF;
       END;
       END IF;
   END IF;

   IF (AVALOR < 0) THEN
     RETURN (-1*((INTVALUE*10) + (INTCALC / POW)));
   ELSE
    RETURN ((INTVALUE*10) + (INTCALC / POW));
   END IF;
END;

