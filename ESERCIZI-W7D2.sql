# ESERCIZIO 1
# Consideriamo se ProductKey all'iunterno della tabella dimproduct è una primary key.
# Il primo argomento che mi viene da affrontare è il fatto che una primary key per definizione definisce in maniera univoca un record di una tabella
# Questa condizione è verificata dentro dimproduct, inoltre Productkey è la foreign key all'interno della tabella Factresellersales 
# Quindi sono convinto di rispondere affermativamente alla domanda.
SELECT * FROM dimproduct;

# QUesta è la query per identificare quale è la primary key d una tabella
# Avevamo affrontato la questione in una lezione pratica
SELECT 
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'AdventureWorksDW' 
    AND TABLE_NAME = 'dimproduct'
    AND CONSTRAINT_NAME = 'PRIMARY';
    
# ESERCIZIO 2
# Questa query mi restituisci le primary key della tabella factresellersales
SELECT * FROM factresellersales;

SELECT 
    COLUMN_NAME  
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'AdventureWorksDW'
    AND TABLE_NAME = 'factresellersales'
    AND CONSTRAINT_NAME = 'PRIMARY';
    
# ESERCIZIO 3
SELECT OrderDate, COUNT(SalesOrderLineNumber) AS TotalTrasition
FROM factresellersales
GROUP BY OrderDate
HAVING OrderDate > "2020-01-01";

# ESERECIZIO 4 
# Output richiesto
# NomeProdotto, Fatturato Totale, QuantitaVenduta, PrezzoMedio

SELECT * FROM factresellersales;

SELECT EnglishProductName AS NomeProdotto, OrderDate AS DataOrdine, SUM(SalesAmount) AS FatturatoTotale, SUM(OrderQuantity) AS QuantitaVenduta, AVG(UnitPrice) AS PrezzoMedio
FROM factresellersales F
JOIN dimproduct D ON F.ProductKey = D.ProductKey
GROUP BY F.ProductKey, F.OrderDate
HAVING F.OrderDate > "2020-01-01"
;

# ESERCIZIO 5

# output richiesto 
# NomeCategoria, FatturatoTotale, QuantitaTotaleVenduta

SELECT * FROM factresellersales;

SELECT EnglishProductCategoryName AS CategoryName, SUM(SalesAmount) AS TotalRevenue, SUM(OrderQuantity) AS OrderQuantity
FROM factresellersales F
LEFT JOIN dimproduct D ON F.ProductKey = D.ProductKey
LEFT JOIN dimproductsubcategory SUB ON D.ProductSubcategoryKey = SUB.ProductSubcategoryKey
LEFT JOIN dimproductcategory CAT ON SUB.ProductCategoryKey = CAT.ProductCategoryKey
GROUP BY EnglishProductCategoryName
;

# ESERCIZIO 6

# OutPut richiesto
# NomeCittà, FatturatoTotale > 60k

SELECT GEO.City, SUM(SalesAmount) AS TotalRevenue
FROM factresellersales F
JOIN dimreseller D ON F.ResellerKey = D.ResellerKey
JOIN dimgeography GEO ON D.GeographyKey = GEO.GeographyKey
GROUP BY GEO.City
HAVING TotalRevenue > 60000;

