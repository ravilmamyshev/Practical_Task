IF OBJECT_ID('dbo.GetSKUPrice') IS NOT NULL
	DROP FUNCTION dbo.GetSKUPrice;
GO
CREATE FUNCTION dbo.GetSKUPrice
(
	@ID_SKU AS INT
)
RETURNS DECIMAL(18, 2)
AS
	BEGIN
		DECLARE @sumValue INT, @sumQuantity INT
		SELECT @sumValue = SUM(Value), @sumQuantity = SUM(Quantity) 
		FROM dbo.Basket
		WHERE ID_SKU = @ID_SKU
		RETURN CAST(@sumValue * 1.00 / @sumQuantity AS DECIMAL(18, 2))
	END;