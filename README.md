# 🧮 SQL Exploratory Data Analysis – Superstore Sales (Taha Rostoume)

## 📊 Contexte du projet
Ce projet vise à réaliser une **analyse exploratoire complète** d’un dataset de ventes (`Superstore Sales`) à l’aide de **SQL Developer**.  
L’objectif est de **nettoyer les données, explorer les tendances**, et **formuler des recommandations stratégiques** basées sur les insights obtenus.

---

## 🗂️ Contenu du projet

| Dossier | Description |
|----------|--------------|
| `data/` | Contient les fichiers bruts et nettoyés du dataset |
| `sql/` | Contient tous les scripts SQL (nettoyage, exploration, insights) |
| `reports/` | Rapport PDF final et livrable analytique |
| `visuals/` | Captures Power BI ou graphiques de soutien |
| `README.md` | Documentation principale |
| `LICENSE` | Licence open-source |

---

## 🧩 1. Nettoyage des données (SQL)
Fichier : [`sql/01_cleaning_queries.sql`](sql/01_cleaning_queries.sql)

Principales étapes :
- Suppression des doublons  
- Standardisation des valeurs nulles  
- Nettoyage des formats de dates et devises  
- Création de la table `sales_clean`

```sql
CREATE TABLE sales_clean AS
SELECT DISTINCT *
FROM superstore_raw
WHERE order_date IS NOT NULL
  AND sales > 0;
-- Total des ventes par catégorie
SELECT category, ROUND(SUM(sales), 2) AS total_sales
FROM sales_clean
GROUP BY category
ORDER BY total_sales DESC;

-- Top 10 clients par profit
SELECT customer_name, SUM(profit) AS total_profit
FROM sales_clean
GROUP BY customer_name
ORDER BY total_profit DESC
FETCH FIRST 10 ROWS ONLY;
```

## 🔍 2. Exploration & KPIs

Fichier : sql/02_exploration_queries.sql

Exemples d’indicateurs :
```sql
-- Total des ventes par catégorie
SELECT category, ROUND(SUM(sales), 2) AS total_sales
FROM sales_clean
GROUP BY category
ORDER BY total_sales DESC;

-- Top 10 clients les plus rentables
SELECT customer_name, SUM(profit) AS total_profit
FROM sales_clean
GROUP BY customer_name
ORDER BY total_profit DESC
FETCH FIRST 10 ROWS ONLY;

-- Profit moyen par segment
SELECT segment, ROUND(AVG(profit), 2) AS avg_profit
FROM sales_clean
GROUP BY segment;

-- Performance régionale
SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sales_clean
GROUP BY region
ORDER BY total_profit DESC;

```
Principaux KPIs
|Indicateur |	Description |	exemple
|------|--------------|---------------|
|Total Sales |	Total global des ventes |	2.3M $|
|Average Profit Margin |	Profit moyen / Vente	| 12.5%|
|Top Region |	Région la plus rentable |	West|
|Top Customer |	Client le plus rentable |	Sean Miller|


## 💡 3. Insights & Recommandations

Fichier : sql/03_insights_queries.sql
Insights clés
|Thème |	Observation |	Recommandation
|------|--------------|---------------|
|Catégories à faible marge	| Office Supplies & Furniture < 5%	| Réviser la politique de prix|
|Impact des remises	| Discount > 20% réduit la marge |	Limiter les promotions à 15%|
|Segments rentables	| Corporate = meilleure marge (17%)|	Accentuer le marketing B2B|
|Régions performantes	| West & East surperforment	| Réallouer budget marketing|
|Clients clés	| Top 10 = 20% du profit total| Lancer un programme fidélité|

## 📑 4. Rapport final

📄 rapport_data_insights_TahaRostoume.pdf

Ce document contient :

* Les insights consolidés

* Un tableau de synthèse des observations SQL

* Des recommandations stratégiques orientées business

* Des pistes d’automatisation future (Power BI + SQL)

## 📈 5. Visualisations

Dossier : visuals/

dashboard_powerbi_screenshot.png → aperçu du tableau de bord

insights_chart.png → visualisation des profits par catégorie

## 🧠 Compétences démontrées

SQL Developer : nettoyage, requêtes analytiques, agrégations

Data storytelling : transformation d’insights en recommandations

Reporting analytique (Power BI / PDF)

Documentation claire et structurée sur GitHub

## ⚙️ Stack utilisée

SQL Developer (Oracle)

Power BI / Excel

Git & GitHub pour la gestion du versioning

## 👤 Auteur

Taha Rostoume
📍 Laval, Québec, Canada
💼 Data Analyst Junior
📧 taharostom@yahoo.ca

🔗 LinkedIn
 | GitHub

##  🪪 Licence

Projet distribué sous licence MIT.
Libre d’utilisation à des fins éducatives et professionnelles avec attribution.
