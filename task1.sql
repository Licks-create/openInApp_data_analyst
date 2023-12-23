-- Task1

-- table link
-- https://docs.google.com/spreadsheets/d/1qwhJfLwe78CdyJCeUbBDf_BbUzoXzDHrGejQLGVCjkI/edit#gid=1142524462

-- A.Retrieve the names and salaries of all employees, along with the average salary in their respective
-- departments.

SELECT "Name","Salary" "Department",
AVG("Salary") OVER (PARTITION BY "Department") AS AvgrageSalary
FROM "EMPLOYEE"

-- B.Calculate the total sales amount for each employee, including those who have not made any sales.
-- Display their names and total sales amount.
SELECT e."Name",COALESCE(SUM(s."Sales_Amount"),0) AS TotalSales
FROM "EMPLOYEE" as e
Left Join "SALES" as s
ON e."Employee_ID"=s."Employee_ID"
GROUP BY e."Name"

-- C.Rank employees within each department based on their salary in descending order. The ranking should reset for each department. If two employees have the highest salary, they will both be assigned the rank 1, and the next distinct salary will be assigned the rank 3 (skipping 2)
SELECT "Name","Salary","Department",
DENSE_RANK() OVER (PARTITION BY "Department" ORDER BY "Salary" DESC)
AS SalaryRank
FROM "EMPLOYEE"

-- D. Rank employees within each department based on their salary in descending order. The ranking should reset for each department. If two employees have the highest salary, they will both be assigned the rank 1, and the next distinct salary will be assigned the rank 2
SELECT "Name","Salary","Department",
RANK() OVER (PARTITION BY "Department" ORDER BY "Salary" DESC) 
AS SalaryRank
FROM "EMPLOYEE"