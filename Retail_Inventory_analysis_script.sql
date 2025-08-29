
 
 27.	PIVOT: (This is a more advanced SQL Server feature) Show total quantity sold for each product across different stores.
 SELECT ProductID, [1] as soldcount, [2] as storescount, [3] as soldquantity
FROM (
    SELECT ProductID, StoreID, QuantitySold
    FROM Sales
) AS SourceTable
PIVOT (
    SUM(QuantitySold)
    FOR StoreID IN ([1], [2], [3])
) AS PivotTable;



