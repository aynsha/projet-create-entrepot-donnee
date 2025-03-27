
--Insertion des données de la table dim_custumers de la table source customers
INSERT INTO dim_customer (customerNumber, customerName, country, creditLimit, salesRepEmployeeNumber )
SELECT customerNumber, customerName, country, creditLimit, salesRepEmployeeNumber
FROM SourceMacroBus.dbo.customers$;
SELECT * from dim_customer;

--Insertion des données de la table dim_employees de la table source employees
INSERT INTO dim_employee (employeeNumber, lastName, firstName, jobTitle, officeCode)
SELECT employeeNumber, lastName, firstName, jobTitle, officeCode
FROM SourceMacroBus.dbo.employees$;
select * from dim_employee;

--Insertion des données de la table dim_offices de la table source offices 
INSERT INTO dim_office (officeCode, city, country, territory)
SELECT officeCode, city, country, territory
FROM SourceMacroBus.dbo.offices$;

--Insertion des données de la table dim_products de la table source products
INSERT INTO dim_product (productCode, productName, productScale, productVendor, buyPrice, productLine)
SELECT productCode, productName, productScale, productVendor, buyPrice, productLine
FROM SourceMacroBus.dbo.products$;
SELECT * FROM dim_product;

--Insertion des données de la table dim_productlines de la table source productlines
INSERT INTO dim_productline (productLine, textDescription)
SELECT productLine, textDescription
FROM SourceMacroBus.dbo.productlines$;
SELECT * FROM dim_productline;

--Insertion des données de la table dim_date de la table source orders
INSERT INTO dim_date (fullDate, year, quarter, month, day)
SELECT 
    orderDate AS fullDate,
    YEAR(orderDate),
    DATEPART(QUARTER, orderDate),
    MONTH(orderDate),
    DAY(orderDate)
FROM SourceMacrobus.dbo.orders$;
SELECT * FROM dim_date;

--Insertion des données de la table faits_orders de la table source orders
INSERT INTO faits_orders (
    idDim_customer, idDim_employee, idDim_product, idDim_office, idDim_productline, 
    idDim_date, orderDate, quantityOrdered, totalAmount, priceEach
)
SELECT 
    c.id, 
    e.id, 
    p.id, 
    ofc.id,  -- Utilisation de l'alias "ofc" pour dim_office
    pl.id, 
    d.id, 
    o.orderDate, 
    od.quantityOrdered, 
    (od.quantityOrdered * od.priceEach) AS totalAmount, 
    od.priceEach
FROM SourceMacrobus.dbo.orders$ o
JOIN dim_customer c ON o.customerNumber = c.customerNumber
JOIN SourceMacrobus.dbo.orderdetails$ od ON o.orderNumber = od.orderNumber
JOIN dim_product p ON od.productCode = p.productCode
JOIN dim_productline pl ON p.productLine = pl.productLine
JOIN dim_employee e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN dim_office ofc ON e.officeCode = ofc.officeCode  
JOIN dim_date d ON o.orderDate = d.fullDate;
SELECT * FROM faits_orders;