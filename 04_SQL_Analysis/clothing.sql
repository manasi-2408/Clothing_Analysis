-- Problem Statement
-- Retail businesses often struggle to understand customer purchasing behaviour and 
-- identify hidden relationships among products. Without analyzing transaction data, 
-- businesses cannot effectively segment customers, recommend products, or implement 
-- cross-selling strategies. Therefore, this project aims to analyze customer purchase 
-- transactions to understand purchasing behaviour, discover frequently purchased product 
-- combinations, identify customer segments, and generate actionable business recommendations.

-- Sales Performance Analysis
-- Q1. Which month and year generated the highest sales revenue?

SELECT 
    Purchase_Year,
    Purchase_Month,
    SUM(Total_Spend) AS Sales_Revenue
FROM
    cloth
GROUP BY Purchase_Year , Purchase_Month
ORDER BY Sales_Revenue DESC;


-- Q2. Which season contributes the highest sales revenue?

SELECT 
    Season, SUM(Total_Spend) AS Sales_Revenue
FROM
    cloth
GROUP BY Season
ORDER BY Sales_Revenue DESC;


-- Q3. How has sales performance changed across different years?

SELECT 
    Purchase_Year, SUM(Total_Spend) AS Yearly_Revenue
FROM
    cloth
GROUP BY Purchase_Year
ORDER BY Purchase_Year;


-- Q4. What is the average transaction value across the dataset?

SELECT 
    AVG(Total_Spend) AS Average_Transaction_Value
FROM
    cloth;


-- Product Analysis
-- Q5. Which products are purchased most frequently?

SELECT 
    Product, COUNT(*) AS Purchase_Count
FROM
    cloth
GROUP BY Product
ORDER BY Purchase_Count DESC;


-- Q6. Which product categories generate the highest sales?

SELECT 
    Category, SUM(Total_Spend) AS Sales_Revenue
FROM
    cloth
GROUP BY Category
ORDER BY Sales_Revenue DESC;


-- Q7. Which products generate the highest revenue?

SELECT 
    Product, SUM(Total_Spend) AS Revenue
FROM
    cloth
GROUP BY Product
ORDER BY Revenue DESC;


-- Q8. What are the top performing products based on quantity sold?

SELECT 
    Product, SUM(Quantity) AS Quantity_Sold
FROM
    cloth
GROUP BY Product
ORDER BY Quantity_Sold DESC
LIMIT 10;


-- Q9. Which product categories contribute the most quantity sold?

SELECT 
    Category, SUM(Quantity) AS Quantity_Sold
FROM
    cloth
GROUP BY Category
ORDER BY Quantity_Sold DESC;


-- Customer Demographic Analysis
-- Q10. Which age group contributes the highest sales?

SELECT 
    Age_Group, SUM(Total_Spend) AS Revenue
FROM
    cloth
GROUP BY Age_Group
ORDER BY Revenue DESC;


-- Q11. What is the age distribution across product categories?

SELECT 
    Age_Group, Category, COUNT(*) AS Purchase_Count
FROM
    cloth
GROUP BY Age_Group , Category
ORDER BY Purchase_Count DESC;


-- Q12. Which gender contributes the highest revenue?

SELECT 
    Gender, SUM(Total_Spend) AS Revenue
FROM
    cloth
GROUP BY Gender
ORDER BY Revenue DESC;


-- Q13. Which gender purchases the highest quantity?

SELECT 
    Gender, SUM(Quantity) AS Total_Quantity
FROM
    cloth
GROUP BY Gender
ORDER BY Total_Quantity DESC;


-- Q14. Which cities generate the highest sales revenue?

SELECT 
    City, SUM(Total_Spend) AS Revenue
FROM
    cloth
GROUP BY City
ORDER BY Revenue DESC;


-- Q15. Which cities have the highest number of transactions?

SELECT 
    City, COUNT(TransactionID) AS Transactions
FROM
    cloth
GROUP BY City
ORDER BY Transactions DESC;


-- Customer Purchase Behaviour Analysis
-- Q16. How many products are typically purchased per transaction?

SELECT 
    AVG(Quantity) AS Avg_Products_Per_Transaction
FROM
    cloth;


-- Q17. What is the average spending per customer?

SELECT 
    AVG(Customer_Spend) AS Avg_Spending_Per_Customer
FROM
    (SELECT 
        CustomerID, SUM(Total_Spend) AS Customer_Spend
    FROM
        cloth
    GROUP BY CustomerID) x;


-- Q18. How many customers are repeat buyers?

SELECT 
    COUNT(*) AS Repeat_Buyers
FROM
    (SELECT 
        CustomerID
    FROM
        cloth
    GROUP BY CustomerID
    HAVING COUNT(TransactionID) > 1) x;


-- Q19. What percentage of customers are repeat buyers?

SELECT 
    (COUNT(*) * 100.0 / (SELECT 
            COUNT(DISTINCT CustomerID)
        FROM
            cloth)) AS Repeat_Buyer_Percentage
FROM
    (SELECT 
        CustomerID
    FROM
        cloth
    GROUP BY CustomerID
    HAVING COUNT(TransactionID) > 1) x;


-- Q20. Which customers contribute the highest revenue?

SELECT 
    CustomerID, SUM(Total_Spend) AS Revenue
FROM
    cloth
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 10;


-- Customer Segmentation Analysis
-- Q21. How are customers distributed across clusters?

SELECT 
    Cluster_Label_Desc,
    COUNT(DISTINCT CustomerID) AS Customer_Count
FROM
    cloth
GROUP BY Cluster_Label_Desc;


-- Q22. Which customer segment generates the highest revenue?

SELECT 
    Cluster_Label_Desc, SUM(Total_Spend) AS Revenue
FROM
    cloth
GROUP BY Cluster_Label_Desc
ORDER BY Revenue DESC;


-- Q23. What is the average spending behaviour of each segment?

SELECT 
    Cluster_Label_Desc, AVG(Total_Spend) AS Avg_Spending
FROM
    cloth
GROUP BY Cluster_Label_Desc;


-- Q24. Which customer segment purchases the highest quantity?

SELECT 
    Cluster_Label_Desc, SUM(Quantity) AS Total_Quantity
FROM
    cloth
GROUP BY Cluster_Label_Desc
ORDER BY Total_Quantity DESC;


-- Q25. How does purchasing behaviour differ among customer segments?

SELECT 
    Cluster_Label_Desc,
    AVG(Total_Spend) AS Avg_Spend,
    AVG(Quantity) AS Avg_Quantity,
    AVG(UnitPrice) AS Avg_Price
FROM
    cloth
GROUP BY Cluster_Label_Desc;


-- Q26. Which products are most frequently purchased together?

-- Cap and Hoodie
-- Jeans and Belt
-- Jacket and Scarf
-- Shirt and Tie
-- Sneakers and Socks
-- Dress and Handbag


-- Q27. Which product combinations have the strongest association?

-- Cap ↔ Hoodie (Lift 3.30)
-- Jeans ↔ Belt (Lift 3.16)
-- Jacket ↔ Scarf (Lift 3.15)
-- Shirt ↔ Tie (Lift 3.13)
-- Sneakers ↔ Socks (Lift 3.12)


-- Q28. Which products should be bundled together?

-- Hoodie + Cap
-- Jeans + Belt
-- Jacket + Scarf
-- Shirt + Tie
-- Sneakers + Socks
-- Dress + Handbag


-- Q29. What cross-selling opportunities can be identified?

-- Recommend:
-- Belt when Jeans are purchased.
-- Socks when Sneakers are purchased.
-- Handbag when Dress is purchased.
-- Cap when Hoodie is purchased.


-- Q30. How can association rules improve recommendations?
-- Association rules can be integrated into recommendation systems to suggest complementary products during checkout, 
-- increasing average order value and improving customer experience.


-- Q31. Which products should be promoted together?

-- Hoodie and Cap
-- Jeans and Belt
-- Sneakers and Socks
-- Jacket and Scarf
-- Dress and Handbag


-- Q32. Which customer segment should be targeted for premium campaigns?

-- Premium Buyers (Cluster 1)
-- Reason:
-- Highest average unit price (~₹3841)
-- Willing to spend more per purchase


-- Q33. Which customer segment is most suitable for loyalty programs?

-- Frequent Buyers (Cluster 0)
-- Reason:
-- Largest segment
-- Highest average quantity purchased (4.5 products)


-- Q34. Which customer segment is most responsive to discounts?

-- Budget Buyers (Cluster 2)
-- Reason:
-- Lowest average spending
-- More price-sensitive purchasing behaviour


-- Q35. What strategies can increase average transaction value?

-- Bundle frequently purchased products.
-- Cross-sell complementary items.
-- Offer premium product recommendations to Premium Buyers.
-- Introduce loyalty rewards for Frequent Buyers.
-- Create discount bundles for Budget Buyers.
-- Use personalized product recommendations based on purchasing behaviour.