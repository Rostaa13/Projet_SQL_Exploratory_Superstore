/* =====================================================
   04_EXTRACT_INSIGHTS.SQL
   Purpose: Derive insights & build recommendations
   Author: Taha Rostoume
   ===================================================== */

/* ===============================
   1. Identify Low-Margin Categories
   =============================== */
SELECT 
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY Category, Sub_Category
HAVING SUM(Profit)/SUM(Sales) < 0.05
ORDER BY margin_pct ASC;

/* Insight:
   → Ces sous-catégories présentent une rentabilité faible.
   → Potentiel d’action : revoir la politique de prix ou réduire les coûts logistiques.
*/


/* ===============================
   2. Identify High Discount → Low Profit correlation
   =============================== */
SELECT 
    ROUND(Discount, 2) AS discount_rate,
    ROUND(AVG(Profit), 2) AS avg_profit,
    ROUND(AVG(Sales), 2) AS avg_sales
FROM sales_clean
GROUP BY ROUND(Discount, 2)
ORDER BY discount_rate;

/* Insight:
   → Plus le discount dépasse 0.2 (20%), le profit moyen chute fortement.
   → Recommandation : limiter les remises à 15% pour protéger les marges.
*/


/* ===============================
   3. Compare Profit Margin by Region
   =============================== */
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct
FROM sales_clean
GROUP BY Region
ORDER BY margin_pct DESC;

/* Insight:
   → Les régions "West" et "East" sont les plus rentables.
   → Recommandation : concentrer le budget marketing dans ces zones.
*/


/* ===============================
   4. Customer Lifetime Value (CLV) approximation
   =============================== */
SELECT 
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS nb_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Profit), 2) AS avg_profit_per_order
FROM sales_clean
GROUP BY Customer_Name
HAVING COUNT(DISTINCT Order_ID) >= 3
ORDER BY total_profit DESC
FETCH FIRST 10 ROWS ONLY;

/* Insight:
   → Ces clients génèrent plus de valeur récurrente.
   → Recommandation : créer un programme de fidélité ciblé sur ce segment.
*/


/* ===============================
   5. Year-over-Year Growth
   =============================== */
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS margin_pct,
    ROUND(
        (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY EXTRACT(YEAR FROM Order_Date)))
        / LAG(SUM(Sales)) OVER (ORDER BY EXTRACT(YEAR FROM Order_Date)) * 100, 2
    ) AS sales_growth_pct
FROM sales_clean
GROUP BY EXTRACT(YEAR FROM Order_Date)
ORDER BY year;

/* Insight:
   → Permet de visualiser la croissance annuelle du CA et du profit.
*/


/* ===============================
   END OF FILE
   =============================== */
