IF OBJECT_ID('dbo.TR_Basket_insert_update') IS NOT NULL
	DROP TRIGGER dbo.TR_Basket_insert_update;
GO
CREATE TRIGGER dbo.TR_Basket_insert_update ON dbo.Basket AFTER INSERT
AS
UPDATE dbo.Basket
	SET DiscountValue = Value * 0.05
WHERE ID_SKU IN 
	(SELECT ID_SKU FROM inserted 
	GROUP BY ID_SKU 
	HAVING COUNT(*) > 1);

WITH C AS
(
	SELECT * FROM dbo.Basket B
	WHERE EXISTS 
		(SELECT * FROM INSERTED I
		WHERE ID_SKU NOT IN 
			(SELECT ID_SKU FROM inserted 
			GROUP BY ID_SKU 
			HAVING COUNT(*) > 1)
			AND I.ID = B.ID)
)
UPDATE C
	SET DiscountValue = 0;