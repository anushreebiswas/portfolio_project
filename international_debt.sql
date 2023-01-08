--Checking the data
SELECT * FROM debt
Limit 1

--Finding the number of distinct countries
SELECT COUNT(DISTINCT country_name) AS total_distinct_countries
FROM debt

--Finding out the distinct debt indicators
SELECT DISTINCT(indicator_code) AS distinct_debt_indicators FROM debt
ORDER BY distinct_debt_indicators

--Totaling the amount of debt owed by the countries
SELECT ROUND((SUM(debt)/1000000),2) AS total_debt FROM debt

--Country with the highest debt
SELECT country_name,SUM(debt) AS total_debt FROM debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1

--Average amount of debt across indicators
SELECT indicator_code AS debt_indicator,indicator_name,avg(debt) AS average_debt FROM debt
GROUP BY debt_indicator,indicator_name
ORDER BY average_debt
LIMIT 10

--The highest amount of principal repayments
SELECT country_name,indicator_name FROM debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
ORDER BY debt DESC
LIMIT 1

--The most common debt indicator
SELECT indicator_code,COUNT(indicator_code) AS indicator_count FROM debt
GROUP BY indicator_code
ORDER BY indicator_count DESC,indicator_code DESC
LIMIT 20

--Other viable debt issues and conclusion
SELECT country_name,MAX(debt) AS maximum_debt FROM debt
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10