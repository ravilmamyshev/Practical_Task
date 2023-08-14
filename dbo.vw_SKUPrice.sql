IF OBJECT_ID('dbo.SKUPrice') IS NOT NULL
	DROP VIEW dbo.SKUPrice;
GO
CREATE VIEW dbo.SKUPrice
AS 
SELECT 
	ID,
	Code,
	Name,
	dbo.GetSKUPrice(ID) AS SKUPrice
FROM dbo.SKU