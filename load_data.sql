--Insertion des données de la table dim_custumers de la table source customers
INSERT INTO dim_customers (customerNumber, customerNname, country, creditLimit)
SELECT customerNumber, customerName, country, creditLimit
FROM SourceMacroBus.dbo.customers$;

--Insertion des données de la table dim_employees de la table source employees
INSERT INTO dim_employees (employeeNumber, lastName, firstName, jobTitle)
SELECT employeeNumber, lastName, firstName, jobTitle
FROM SourceMacroBus.dbo.employees$;

--Insertion des données de la table dim_offices de la table source offices
INSERT INTO dim_offices (officeCode, city, country, territory)
SELECT officeCode, city, country, territory
FROM SourceMacroBus.dbo.offices$;

--Insertion des données de la table dim_products de la table source products
INSERT INTO dim_product (productCode, productName, productScale, productVendor, buyPrice)
SELECT productCode, productName, productScale, productVendor, buyPrice
FROM SourceMacroBus.dbo.products$;

--Insertion des données de la table dim_productlines de la table source productlines
INSERT INTO dim_productline (productLine, textDescription)
SELECT productLine, textDescription
FROM SourceMacroBus.dbo.productlines$;

--Insertion des données de la table dim_date de la table source orders
INSERT INTO dim_date (fullDate, year, quarter, month, day)
SELECT 
    orderDate AS fullDate,
    YEAR(orderDate),
    DATEPART(QUARTER, orderDate),
    MONTH(orderDate),
    DAY(orderDate)
FROM SourceMacrobus.dbo.orders$;

--Insertion des données de la table faits_orders de la table source orders
INSERT INTO faits_orders (idDim_customer, idDim_employee, idDim_product, idDim_office, idDim_productline, idDim_date, orderDate, quantityOrdered, totalAmount, priceEach)
SELECT 
    c.id,
    e.id,
    p.id,
    o.id,
    pl.id,
    d.id,
    orders.orderDate,
    od.quantityOrdered,
    (od.quantityOrdered * od.priceEach) AS totalAmount,
    od.priceEach
FROM SourceMacrobus.dbo.orders$ orders
JOIN dim_customer c ON orders.customerNumber = c.customerNumber
JOIN SourceMacrobus.dbo.orderdetails$ od ON orders.orderNumber = od.orderNumber
JOIN dim_product p ON od.productCode = p.productCode
JOIN dim_productline pl ON p.productCode = pl.productLine
JOIN dim_employee e ON orders.salesRepEmployeeNumber = e.employeeNumber
JOIN dim_office o ON e.employeeNumber = o.officeCode
JOIN dim_date d ON orders.orderDate = d.fullDate;