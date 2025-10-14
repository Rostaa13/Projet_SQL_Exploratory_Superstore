/* =====================================================
   05_REPORTING_SUMMARY.SQL
   Purpose: Generate summarized KPIs for dashboard/reporting
   Author: Taha Rostoume
   ===================================================== */

/* ===============================
   1. KPI Overview View
   =============================== */
CREATE OR REPLACE VIEW superstore_kpi_summary AS
SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin,
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Product_Name) AS nb_products
FROM sales_clean;

/* ===============================
   2. Sales by Region Summary
   =============================== */
CREATE OR REPLACE VIEW superstore_region_summary AS
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY Region;

/* ===============================
   3. Sales by Category Summary
   =============================== */
CREATE OR REPLACE VIEW superstore_category_summary AS
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY Category;

/* ===============================
   4. Monthly Trend Summary
   =============================== */
CREATE OR REPLACE VIEW superstore_monthly_trend AS
SELECT
    TO_CHAR(Order_Date, 'YYYY-MM') AS month_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_clean
GROUP BY TO_CHAR(Order_Date, 'YYYY-MM')
ORDER BY month_year;

/* ===============================
   5. Save Final KPI Snapshot
   =============================== */
SELECT * FROM superstore_kpi_summary;

SELECT * FROM superstore_region_summary ORDER BY total_profit DESC;
SELECT * FROM superstore_category_summary ORDER BY total_profit DESC;
SELECT * FROM superstore_monthly_trend;
