IF OBJECT_ID('dbo.MakeFamilyPurchase', 'P') IS NOT NULL
	DROP PROC dbo.MakeFamilyPurchase;
GO
CREATE PROC dbo.MakeFamilyPurchase
	@FamilySurName AS VARCHAR(255)
AS
DECLARE @familyId INT
SET @familyId = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName)
IF @familyId IS NULL
	PRINT 'Такой семьи нет'	
ELSE
	IF @familyId IN (SELECT ID_Family FROM dbo.Basket)
		UPDATE dbo.Family
			SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @familyId)
		WHERE ID = @familyId;