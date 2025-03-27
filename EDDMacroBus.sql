--Creation de l'entrepot de données
CREATE DATABASE MacroBusDW;
USE MacroBusDW;

--Creation table dim_customer
CREATE TABLE dim_customer(
    id INT IDENTITY(1,1) PRIMARY KEY,
    customerNumber INT NOT NULL,
    customerName VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    creditLimit INT NOT NULL,
    salesRepEmployeeNumber INT NOT NULL
);

 --Creation table dim_employee
 CREATE TABLE  dim_employee(
    id INT IDENTITY(1,1) PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    jobTitle VARCHAR(100) NOT NULL,
    officeCode INT NOT NULL
    );

--Creation table dim_product
CREATE TABLE  dim_product(
    id INT IDENTITY(1,1) PRIMARY KEY,
    productCode VARCHAR(100) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productScale VARCHAR(100) NOT NULL,
    productVendor VARCHAR(100) NOT NULL,
    buyPrice DECIMAL NOT NULL,
    productLine VARCHAR(100) NOT NULL
);

--Creation talbe dim_office
CREATE TABLE  dim_office(
    id INT IDENTITY(1,1) PRIMARY KEY,
    officeCode VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    territory VARCHAR(100) NOT NULL
);

--Creation table dim_productline
CREATE TABLE  dim_productline(
    id INT IDENTITY(1,1) PRIMARY KEY,
    productLine VARCHAR(100) NOT NULL,
    textDescription VARCHAR(1000) NOT NULL
);

--Creation table dim_date
CREATE TABLE  dim_date(
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullDate DATE NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

--Creation table faits_orders
CREATE TABLE  faits_orders(
    idDim_customer INT NOT NULL,
    idDim_employee INT NOT NULL,
    idDim_product INT NOT NULL,
    idDim_office INT NOT NULL,
    idDim_productline INT NOT NULL,
    idDim_date INT NOT NULL,
    orderDate DATE NOT NULL,
    quantityOrdered INT NOT NULL,
    totalAmount DECIMAL NOT NULL,
    priceEach DECIMAL NOT NULL,

    FOREIGN KEY (idDim_customer) REFERENCES dim_customer(id),
    FOREIGN KEY (idDim_employee) REFERENCES dim_employee(id),
    FOREIGN KEY (idDim_product) REFERENCES dim_product(id),
    FOREIGN KEY (idDim_office) REFERENCES dim_office(id),
    FOREIGN KEY (idDim_productline) REFERENCES dim_productline(id),
    FOREIGN KEY (idDim_date) REFERENCES dim_date(id)
);
