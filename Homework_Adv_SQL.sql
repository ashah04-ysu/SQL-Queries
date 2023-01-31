--1. List the customer number, name (first and last), 
--and city of each customer who has a balance greater 
--than $150 and placed an order in February 2007.

SELECT CustNo, CustFirstName, CustLastName, CustCity FROM CR_Customer
WHERE CustBal > 150 AND CustNo IN
(SELECT CustNo FROM CR_OrderTbl
WHERE OrdDate BETWEEN '01-FEB-2007' AND '28-FEB-2007')

--2. List the order number, order date, employee number, 
--employee name (first and last) customer number, and
--customer name (first and last) of orders placed on 
--January 23, 2007. List the order even if there is not
--an associated employee.

SELECT CR_OrderTbl.OrdNo, CR_OrderTbl.OrdDate, 
CR_Employee.EmpNo, CR_Employee.EmpFirstName, CR_Employee.EmpLastName,
CR_Customer.CustNo, CR_Customer.CustFirstName, CR_Customer.CustLastName
FROM (CR_OrderTbl LEFT JOIN CR_Employee ON CR_OrderTbl.EmpNo = CR_Employee.EmpNo)
INNER JOIN CR_Customer ON CR_Customer.CustNo = CR_OrderTbl.CustNo
WHERE OrdDate = '23-Jan-2007'

--3. List the customer number and name of Colorado 
--customers who have not placed orders in February 2007.

SELECT CustNo, CustFirstName, CustLastName, CustCity FROM CR_Customer
WHERE CustCity = 'CO' AND NOT EXISTS
(SELECT * FROM CR_OrderTbl 
WHERE OrdDate BETWEEN '1-FEB-2007' AND '28-FEB-2007')

--4. List the employee number, first name and last name 
--of employees in the (720) area code who have not 
--taken orders. An employee is in the (720) area code 
--if the employee phone number contains the string (720) 
--in the beginning of the column value.

SELECT CR_OrderTbl.EmpNo, EmpFirstName, 
EmpLastName FROM CR_Employee, CR_OrderTbl
WHERE CR_OrderTbl.EmpNo IS NULL
AND CR_Employee.EmpPhone LIKE '%720%' 

--5. List the order number and order date of orders
--containing only one product with the words ‘Ink Jet’ 
--in the product description.

SELECT CR_OrderTbl.OrdNo, OrdDate 
FROM CR_OrderTbl, CR_OrdLine, CR_Product 
WHERE CR_OrderTbl.OrdNo = CR_OrdLine.OrdNo 
AND CR_OrdLine.ProdNo = CR_Product.ProdNo 
AND ProdName LIKE '%Ink Jet%' 
AND NOT EXISTS (SELECT * FROM CR_OrdLine OL1, CR_Product P1 
WHERE OL1.ProdNo = P1.ProdNo AND ProdName LIKE '%Ink Jet%' 
AND OL1.OrdNo = CR_OrderTbl.OrdNo AND OL1.ProdNo <> CR_Product.ProdNo)


--6. List the order number and order date of orders containing 
--every product with the words ‘Ink Jet’ in the product description.

SELECT DISTINCT CR_OrderTbl.OrdNo, OrdDate 
FROM CR_OrderTbl, CR_OrdLine, CR_Product 
WHERE CR_OrderTbl.OrdNo = CR_OrdLine.OrdNo 
AND CR_OrdLine.ProdNo = CR_Product.ProdNo 
AND ProdName LIKE '%Ink Jet%' 
ORDER BY OrdDate;

--7. List the customer number and name (first and last)
--of customers who have ordered every product manufactured 
--by ‘ColorMeg Inc.’ in January 2007.

SELECT CR_Customer.CustNo, CustFirstName, CustLastName
FROM CR_Customer, CR_OrdLine, CR_Product, CR_OrderTbl
WHERE CR_Customer.CustNo = CR_OrderTbl.CustNo 
AND CR_OrderTbl.OrdNo = CR_OrdLine.OrdNo 
AND CR_OrdLine.ProdNo = CR_Product.ProdNo 
AND ProdMfg LIKE '%ColorMeg%' 
AND CR_OrderTbl.OrdDate BETWEEN '01-Jan-2007' AND '31-Jan-2007'

--8. List the employee number and employee name 
--(first and last) of employees who have taken 
--orders in January 2007 from every Seattle customer.

SELECT DISTINCT CR_Employee.EmpNo, EmpFirstName, EmpLastName
FROM CR_Employee, CR_OrderTbl
WHERE CR_OrderTbl.OrdDate BETWEEN '01-Jan-2007' AND '31-Jan-2007'
AND CR_OrderTbl.OrdCity = 'Seattle'


--9. For Colorado  customers, compute the 
--average amount of their orders and the 
--number of orders placed. The result should
--include the customer number, customer last name,
--average order amount, and number of orders place.

SELECT CR_Customer.CustNo, CR_Customer.CustLastName,
AVG(CR_OrdLine.Qty * CR_Product.ProdPrice) AS "AVG"
FROM CR_Customer, CR_OrderTbl, CR_OrdLine, CR_Product 
WHERE (CR_Customer.CustNo = CR_OrderTbl.CustNo)
AND (CR_OrderTbl.OrdNo = CR_OrdLine.OrdNo)
AND (CR_OrdLine.ProdNo = CR_Product.ProdNo) 
AND CustState = 'CO' 
GROUP BY CR_Customer.CustNo, CR_Customer.CustLastName;

--10. For each ‘Connex’ product, compute the number
--of unique customers who ordered the product in January 2007. 
--The result should include the product number, product name, 
--and number of unique customers.

SELECT COUNT (DISTINCT CR_Customer.CustNo) AS "UNIQUE CustNo", CR_Product.ProdNo, CR_Product.ProdName --AS "UNIQUE"
FROM CR_Product, CR_OrdLine, CR_OrderTbl, CR_Customer
WHERE CR_Product.ProdNo = CR_OrdLine.ProdNo
AND CR_OrdLine.OrdNo = CR_OrderTbl.OrdNo
AND CR_OrderTbl.CustNo = CR_Customer.CustNo
AND ProdMfg = 'Connex'
AND CR_OrderTbl.OrdDate BETWEEN '01-Jan-2007' AND '31-Jan-2007'
GROUP BY CR_Product.ProdNo, CR_Product.ProdName
ORDER BY CR_Product.ProdName;
