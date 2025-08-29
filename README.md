# Retail-Sales-and-Inventory-Analysis
Project Summary 📈
This project demonstrates a comprehensive Retail Inventory and Sales Analysis System built using Microsoft SQL Server. I designed and implemented a database from the ground up, simulating a real-world business environment. The project showcases a full range of SQL skills, from Database Definition Language (DDL) for creating a robust schema to Data Manipulation Language (DML) for managing data.

The core of the project is the analysis of key business questions using a wide array of SQL techniques, including aggregate functions, joins, subqueries, CTEs, and window functions. The project not only retrieves data but transforms it into actionable insights, such as identifying low-stock products, calculating store-level revenue, and ranking top-selling items. This project serves as a strong foundation for any data-focused role and highlights my ability to use SQL to solve real-world business problems.

Business Problems Solved 💼**
This project provides data-driven solutions to several critical business challenges faced by a retail company. The SQL queries developed here answer key questions related to sales, inventory, and supplier performance.

**1. Inventory Management & Optimization**
Problem: A business needs to know what products are low in stock to prevent stockouts and lost sales.

Solution: I used a Common Table Expression (CTE) (LowStockProducts) to identify products with a combined stock quantity below a certain threshold. This helps with proactive inventory replenishment.

Problem: The business needs to track inventory health across different stores.

Solution: A stored procedure (GetStoreInventory) was created to provide a quick, on-demand report of inventory levels for any specified store, allowing for efficient, targeted analysis.

**2. Sales and Revenue Analysis**
Problem: The business wants to understand which stores and products are the most profitable.

Solution: I calculated the total revenue per store by joining the Sales, Products, and Stores tables. This analysis provides clear insight into store performance.

Problem: Management needs to view sales performance over time.

Solution: A view (vw_DailySalesSummary) was created to provide a simplified daily sales report, including total items sold and total revenue. This view makes daily reporting and trend analysis simple and efficient.

**3. Supplier and Product Performance**
Problem: The business wants to identify which suppliers are providing the best-selling products.

Solution: I joined the Sales, Products, and Suppliers tables to calculate the total quantity of products sold by each supplier. This helps in evaluating and managing supplier relationships.

Problem: The business needs to quickly categorize products based on their price for marketing or strategic planning.

Solution: A CASE statement was used to categorize products into 'High,' 'Medium,' or 'Low' price tiers, providing an immediate way to segment the product catalog.

**4. Complex Data Reporting**
Problem: A business wants to compare product prices within their respective categories to identify pricing strategies.

Solution: A window function (RANK()) was used to rank products by price within each category. This allows for an easy comparison of product pricing across different categories.

Problem: The business needs to identify top-selling products in each store.

Solution: A combination of a CTE and ROW_NUMBER() window function was used to find the single top-selling product in each store, providing precise, actionable intelligence for store managers
