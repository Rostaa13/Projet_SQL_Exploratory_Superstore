/* =====================================================
   03_EXPLORATORY_ANALYSIS.SQL
   Exploratory Data Analysis – Superstore Sales Dataset
   Author: Taha Rostoume
   Goal: Clean dataset exploration to extract insights
   ===================================================== */

/* ===============================
   1. Dataset Overview
   =============================== */
   
/* Insight: Identify dataset coverage, total sales, total profit, and overall margin */
SELECT 
    COUNT(*) AS total_rows,
    MIN(Order_Date) AS first_order_date,
    MAX(Order_Date) AS last_order_date,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin_pct
FROM sales_clean;


/* ===============================
   2. Top 10 Products by Total Sales
   =============================== */

/* Insight: Identify best-selling and most profitable products */
SELECT 
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_clean
GROUP BY Product_Name
ORDER BY total_sales DESC
FETCH FIRST 10 ROWS ONLY;


/* ===============================
   3. Profitability by Category and Sub-Category
   =============================== */

/* Insight: Determine which product lines have the best margins */
SELECT 
    Category,
    Sub_Category,
    ROUND(AVG(Sales), 2) AS avg_sales,
    ROUND(AVG(Profit), 2) AS avg_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY Category, Sub_Category
ORDER BY margin_pct DESC;


/* ===============================
   4. Monthly Sales Trends
   =============================== */

/* Insight: Detect seasonal trends and revenue peaks */
SELECT 
    TO_CHAR(Order_Date, 'YYYY-MM') AS month_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_clean
GROUP BY TO_CHAR(Order_Date, 'YYYY-MM')
ORDER BY month_year;


/* ===============================
   5. Regional Performance
   =============================== */

/* Insight: Rank regions by profitability to identify best-performing areas */
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin
FROM sales_clean
GROUP BY Region
ORDER BY total_profit DESC;


/* ===============================
   6. Performance by Customer Segment
   =============================== */

/* Insight: Identify most profitable customer segments (e.g., Consumer, Corporate, Home Office) */
SELECT 
    Segment,
    COUNT(DISTINCT Customer_ID) AS nb_customers,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY Segment
ORDER BY margin_pct DESC;


/* ===============================
   7. Top 10 Customers by Profit
   =============================== */

/* Insight: Identify loyal and high-value customers */
SELECT 
    Customer_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT Order_ID) AS nb_orders
FROM sales_clean
GROUP BY Customer_Name
ORDER BY total_profit DESC
FETCH FIRST 10 ROWS ONLY;


/* ===============================
   8. Discount Impact Analysis
   =============================== */

/* Insight: Observe how discount rates affect profitability */
SELECT 
    ROUND(Discount, 2) AS discount_rate,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY ROUND(Discount, 2)
ORDER BY discount_rate;


/* ===============================
   9. Shipping Mode Analysis
   =============================== */

/* Insight: Determine which shipping modes drive profitability */
SELECT 
    Ship_Mode,
    ROUND(AVG(Profit), 2) AS avg_profit,
    ROUND(SUM(Sales), 2) AS total_sales,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM sales_clean
GROUP BY Ship_Mode
ORDER BY avg_profit DESC;


/* ===============================
   10. Global Sales–Profit Relationship
   =============================== */

/* Insight: Check overall margin and relationship between total sales and profit */
SELECT 
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin
FROM sales_clean;


/* ===============================
   11. Optional: Yearly Sales Trend
   =============================== */

/* Insight: Compare performance by year */
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY EXTRACT(YEAR FROM Order_Date)
ORDER BY year;


/* ===============================
   END OF FILE
   =============================== */
