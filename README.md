# SQL Queries
The following is a description of 8 SQL queries written in a standard SQL syntax. These queries are designed to extract specific data from tables in a database and return the results in the form of a table.

1. Query 1: This query returns the customer number, first name, last name, and city of customers who have a balance greater than $150 and placed an order in February 2007. The data is retrieved from the CR_Customer table using a SELECT statement with a WHERE clause to filter the results based on the conditions mentioned above.

2. Query 2: This query returns the order number, order date, employee number, employee name, customer number, and customer name of orders placed on January 23, 2007. The query uses a combination of INNER JOIN and LEFT JOIN clauses to link the CR_OrderTbl, CR_Employee, and CR_Customer tables and return the required data.

3. Query 3: This query returns the customer number and name of customers in Colorado who did not place any orders in February 2007. The query uses the NOT EXISTS clause and a subquery to filter the data from the CR_Customer table based on the conditions mentioned above.

4. Query 4: This query returns the employee number, first name, and last name of employees in the 720 area code who have not taken any orders. The query uses the LIKE clause to filter employees based on their phone number and the IS NULL clause to exclude employees who have taken orders.

5. Query 5: This query returns the order number and order date of orders containing only one product with the words "Ink Jet" in the product description. The query uses the NOT EXISTS clause and a subquery to filter the data based on the conditions mentioned above.

6. Query 6: This query returns the order number and order date of orders containing every product with the words "Ink Jet" in the product description. The query uses a DISTINCT clause to return unique results and the LIKE clause to filter the data based on the conditions mentioned above.

7. Query 7: This query returns the customer number and name of customers who have ordered every product manufactured by "ColorMeg Inc." in January 2007. The query uses a combination of INNER JOIN and WHERE clauses to filter the data from the CR_Customer, CR_OrdLine, CR_Product, and CR_OrderTbl tables based on the conditions mentioned above.

8. Query 8: This query returns the employee number and name of employees who have taken orders in January 2007 from every Seattle customer. The query uses a DISTINCT clause, INNER JOIN clause, and WHERE clause to filter the data from the CR_Employee and CR_OrderTbl tables based on the conditions mentioned above.

## Note 
The tables and columns mentioned in the queries (e.g. CR_Customer, CustNo) are assumed to be present in the database being queried.
