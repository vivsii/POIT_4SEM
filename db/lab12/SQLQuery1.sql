-----------------------1-----------------------
SET NOCOUNT ON
	IF EXISTS (SELECT * FROM  SYS.OBJECTS        -- ÒÀÁËÈÖÀ X ÅÑÒÜ?
	            WHERE OBJECT_ID= OBJECT_ID(N'DBO.M') )	    
	DROP TABLE M;
	DECLARE @C INT, @FLAG CHAR ='C' -- COMMIT ÈËÈ ROLLBACK?
	SET IMPLICIT_TRANSACTIONS  ON   -- ÂÊËÞ×. ÐÅÆÈÌ ÍÅßÂÍÎÉ ÒÐÀÍÇÀÊÖÈÈ
	CREATE TABLE M(K INT );          
	-- ÍÀ×ÀËÎ ÒÐÀÍÇÀÊÖÈÈ 
		INSERT M VALUES (1),(2),(3);
		SET @C = (SELECT COUNT(*) FROM M);
		PRINT 'ÊÎËÈ×ÅÑÒÂÎ ÑÒÐÎÊ Â ÒÀÁËÈÖÅ M: ' + CAST( @C AS VARCHAR(2));
		IF @FLAG = 'C'  COMMIT;                   -- ÇÀÂÅÐØÅÍÈÅ ÒÐÀÍÇÀÊÖÈÈ: ÔÈÊÑÀÖÈß 
	          ELSE   ROLLBACK;                                 -- ÇÀÂÅÐØÅÍÈÅ ÒÐÀÍÇÀÊÖÈÈ: ÎÒÊÀÒ  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ÂÛÊËÞ×. ÐÅÆÈÌ ÍÅßÂÍÎÉ ÒÐÀÍÇÀÊÖÈÈ
	
	IF  EXISTS (SELECT * FROM  SYS.OBJECTS       -- ÒÀÁËÈÖÀ X ÅÑÒÜ?
	            WHERE OBJECT_ID= OBJECT_ID(N'DBO.M') )
	PRINT 'ÒÀÁËÈÖÀ M ÅÑÒÜ';  
      ELSE PRINT 'ÒÀÁËÈÖÛ M ÍÅÒ'
-----------------------2-----------------------
BEGIN TRY
	BEGIN TRAN                 -- ÍÀ×ÀËÎ  ßÂÍÎÉ ÒÐÀÍÇÀÊÖÈÈ
		INSERT FACULTY VALUES ('ÈÒ', 'ÔÀÊÓËÜÒÅÒ ÄÐÓÃÈÕ ÍÀÓÊ');
	    INSERT FACULTY VALUES ('ÏÈÌ', 'ÔÀÊÓËÜÒÅÒ PRINT-ÒÅÕÍÎËÎÃÈÉ');
		--DELETE FACULTY WHERE FACULTY = 'ÄÔ';
--DELETE FACULTY WHERE FACULTY = 'ÏÈÌ';
	COMMIT TRAN;               -- ÔÈÊÑÀÖÈß ÒÐÀÍÇÀÊÖÈÈ
END TRY

BEGIN CATCH
	PRINT 'ÎØÈÁÊÀ: '+ CASE
		WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%FACULTY_PK%', ERROR_MESSAGE()) > 0 THEN 'ÄÓÁËÈÐÎÂÀÍÈÅ '	
		ELSE 'ÍÅÈÇÂÅÑÒÍÀß ÎØÈÁÊÀ: '+ CAST(ERROR_NUMBER() AS  VARCHAR(5))+ ERROR_MESSAGE()
	END;
	IF @@TRANCOUNT > 0 ROLLBACK TRAN; -- ÓÐ.ÂËÎÆÅÍÍÎÑÒÈ ÒÐ.>0,  ÒÐÀÍÇ ÍÅ ÇÀÂÅÐØÅÍÀ
END CATCH;

SELECT * FROM FACULTY;
-----------------------3-----------------------
DECLARE @POINT VARCHAR(32);

BEGIN TRY
	BEGIN TRAN
		SET @POINT = 'P1';
		SAVE TRAN @POINT;  -- ÊÎÍÒÐÎËÜÍÀß ÒÎ×ÊÀ P1
		INSERT STUDENT(IDSTUDENT, NAME, BDAY, INFO, FOTO) VALUES
		                      (20,'ÏÈÓ', '1997-08-02', NULL, NULL),
							  (20,'ÏÀÓ', '1997-08-06', NULL, NULL),
							  (20,'ÂÓÏ', '1997-08-01', NULL, NULL),
							  (20,'ÏÓÏ', '1997-08-03', NULL, NULL);
		SET @POINT = 'P2';
		SAVE TRAN @POINT; -- ÊÎÍÒÐÎËÜÍÀß ÒÎ×ÊÀ P2
		INSERT STUDENT(IDSTUDENT, NAME, BDAY, INFO, FOTO) VALUES
							  (21, 'ÎÑÎÁÅÍÍÛÉ ÑÒÓÄÅÍÒ', '1997-08-02', NULL, NULL);
	COMMIT TRAN;
END TRY

BEGIN CATCH
	PRINT 'ÎØÈÁÊÀ: '+ CASE
		WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%STUDENT_PK%', ERROR_MESSAGE()) > 0 THEN 'ÄÓÁËÈÐÎÂÀÍÈÅ ÑÒÓÄÅÍÒÀ'
		ELSE 'ÍÅÈÇÂÅÑÒÍÀß ÎØÈÁÊÀ: '+ CAST(ERROR_NUMBER() AS  VARCHAR(5)) + ERROR_MESSAGE()
	END;
    IF @@TRANCOUNT > 0 -- ÅÑËÈ ÒÐÀÍÇÀÊÖÈß ÍÅ ÇÀÂÅÐØÅÍÀ
	BEGIN
	   PRINT 'ÊÎÍÒÐÎËÜÍÀß ÒÎ×ÊÀ: '+ @POINT;
	   ROLLBACK TRAN @POINT; -- ÎÒÊÀÒ Ê ÏÎÑËÅÄÍÅÉ ÊÎÍÒÐ.ÒÎ×ÊÅ
	   COMMIT TRAN; -- ÔÈÊÑÀÖÈß ÈÇÌÅÍÅÍÈÉ, ÂÛÏÎËÍ ÄÎ ÊÎÍÒÐ.ÒÎ×ÊÈ
	END;
END CATCH;

SELECT * FROM STUDENT WHERE IDGROUP=20;
DELETE STUDENT WHERE IDGROUP=20 AND IDGROUP = 21
-----------------------4-----------------------
-- Íà÷àëî òðàíçàêöèè ñ óðîâíåì èçîëÿöèè READ UNCOMMITTED
--Ýòî ñàìûé íèçêèé óðîâåíü èçîëÿöèè.
--Òðàíçàêöèÿ èìååò äîñòóï ê íåïîäòâåðæäåííûì èçìåíåíèÿì, âíåñåííûì äðóãèìè òðàíçàêöèÿìè.
-----A------

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT @@SPID
BEGIN TRANSACTION
------------------ T1 ------------------
SELECT * FROM SUBJECT WHERE SUBJECT = 'TEST';
ROLLBACK TRAN;

COMMIT TRAN;
-------t2---------
-----------------------5----------------------
-- A ---
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT * FROM SUBJECT WHERE SUBJECT = 'ÁÄ';
-------------------------- T1 ------------------
-------------------------- T2 -----------------
SELECT * FROM SUBJECT WHERE SUBJECT = 'ÁÄ';
COMMIT TRAN;


ROLLBACK
-----------------------6-----------------------
--íåäîïóñê íåïîäòâåðæä¸ííîãî ÷òåíèÿ, íî äîïóñê ôàíòîìíîãî
-- Îòêðûâàåì òðàíçàêöèþ ñ óðîâíåì èçîëÿöèè REPEATABLE READ
--Òðàíçàêöèÿ âèäèò òîëüêî èçìåíåíèÿ, ïîäòâåðæäåííûå íà ìîìåíò åå íà÷àëà.
--Ïðîáëåìû ìîãóò âîçíèêíóòü èç-çà "ôàíòîìíûõ ñòðîê", 
--êîãäà íîâûå ñòðîêè âñòàâëÿþòñÿ äðóãèìè òðàíçàêöèÿìè, â ðåçóëüòàòå ÷åãî âûáîðêà âîçâðàùàåò äîïîëíèòåëüíûå ñòðîêè.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT COUNT(*) FROM SUBJECT WHERE SUBJECT = 'ÈÑÈÒ';
-------------------------- T1 ------------------
-------------------------- T2 -----------------
SELECT COUNT(*) FROM SUBJECT WHERE SUBJECT = 'ÈÑÈÒ';
COMMIT TRAN;
rollback
-----------------------7-----------------------
--Ãàðàíòèðóåòñÿ, ÷òî íè îäíà äðóãàÿ òðàíçàêöèÿ íå ñìîæåò âíîñèòü èçìåíåíèÿ â äàííûå, ê êîòîðûì îáðàùàåòñÿ òåêóùàÿ òðàíçàêöèÿ.
-- Îòêðûâàåì òðàíçàêöèþ ñ óðîâíåì èçîëÿöèè SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
SELECT * FROM SUBJECT;
-------------------------- T1 -----------------
-------------------------- T2 ------------------
SELECT * FROM SUBJECT;
COMMIT TRAN;

rollback

rollback
-----------------------8-----------------------
BEGIN TRAN
  INSERT AUDITORIUM_TYPE VALUES ('TEST', 'TEST TEST');
  BEGIN TRAN
    UPDATE AUDITORIUM SET AUDITORIUM = '206-1' WHERE AUDITORIUM_TYPE = 'TEST'
    COMMIT
    IF @@TRANCOUNT > 0 ROLLBACK
  SELECT
    (SELECT COUNT(*) FROM AUDITORIUM WHERE AUDITORIUM_TYPE='TEST') 'AUDIT',
    (SELECT COUNT(*) FROM AUDITORIUM_TYPE  WHERE AUDITORIUM_TYPE='TEST') 'TYPE'
DELETE  AUDITORIUM_TYPE WHERE  AUDITORIUM_TYPE = 'TEST';

