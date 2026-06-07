use SupplyChainDB;
-- Q1. What is the total revenue generated across all products?
select sum(revenue_generated) as total_revenue from supply_chain;

-- Q2. How many unique products (SKUs) are in the dataset?
select count(distinct SKU) as Unique_Products from supply_chain;

-- Q3. What are the different product types available?
select distinct(product_type) from supply_chain;

-- Q4. What is the total number of products sold across all SKUs?
select sum(number_of_products_sold) as total_products_sold from supply_chain;

-- Q5. What is the average product price?
select AVG(price) as average_price from supply_chain;

-- Q6. Show the top 10 highest revenue generating products.
select top 10 SKU, product_type, revenue_generated from supply_chain order by Revenue_generated desc;

-- Q7. What is the total shipping cost across all orders?
select SUM(shipping_costs) as total_Sipping_cost from supply_chain;

-- Q8. How many products are supplied by each supplier?
select Supplier_name , COUNT(*) as products from supply_chain group by supplier_name order by products desc;

-- Q9. What are the different shipping carriers used? 
select distinct(shipping_carriers) from supply_chain;

-- Q10. What is the average defect rate across all products?
select AVG(defect_rates_0_1_scale) as average_defect_rates from supply_chain;

-- Q11. Show all products with defect rate above 5%.
select SKU, Product_type, Defect_rates_0_1_scale as Defect_rate from supply_chain 
where Defect_rates_0_1_Scale>0.50 order by Defect_rate desc;

-- Q12. What is the average lead time across all suppliers?
select AVG(Lead_times) as average_lead_time from supply_chain;

-- Q13. Show products with stock level below 50 (low stock alert)
select SKU, Product_type, Stock_levels from supply_chain where Stock_levels<50 order by Stock_levels asc;

-- Q14. What transportation modes are used for shipping?
select distinct(transportation_modes) from supply_chain;

-- Q15. What is the total manufacturing cost for all products?
select SUM(manufacturing_costs) as total_manufacturing_cost from supply_chain;

-- Q16. What is the total revenue per product type?
select product_type, SUM(revenue_generated) as total_revenue from supply_chain
group by Product_type order by total_revenue desc;

--Q17. What is the average defect rate per supplier?
select supplier_name, AVG(defect_rates_0_1_scale) as average_defect_rate from supply_chain
group by Supplier_name order by average_defect_rate desc;

--Q18. Which supplier has the highest average lead time? 
select top 1 supplier_name, AVG(lead_times) from supply_chain
group by Supplier_name order by AVG(lead_times) desc;

--Q19. What is the total revenue per shipping carrier?
select shipping_carriers, SUM(revenue_generated) as total_revenue from supply_chain
group by Shipping_carriers order by total_revenue desc;

-- Q20. What is the average shipping cost per transportation mode?
select transportation_modes, AVG(shipping_costs) as average_shipping_cost from supply_chain
group by Transportation_modes order by average_shipping_cost desc;

-- Q21. Show suppliers with average defect rate above 50% — these are problem suppliers.
select supplier_name, AVG(defect_rates_0_1_scale) from supply_chain
group by Supplier_name having AVG(defect_rates_0_1_scale) >0.5;

-- Q22. Show product types where average stock level is below 50 — low inventory risk.
select product_type, avg(stock_levels) as low_inventort_risk from supply_chain
group by Product_type having AVG(stock_levels) < 50;

-- Q23. What is the avg manufacturing cost per product type?
select product_type, AVG(manufacturing_costs) as average_manufacturing_cost from supply_chain
group by Product_type order by average_manufacturing_cost desc;

--Q24. Which location has the highest total revenue? 
select top 1 Location, SUM(revenue_generated) as highest_total_revenue from supply_chain
group by Location order by SUM(Revenue_generated) desc;

-- Q25. Show revenue and shipping cost side by side per carrier — which carrier is most cost efficient?
select shipping_carriers, sum(revenue_generated) as total_revenue, sum(shipping_costs) as total_shippings_cost
from supply_chain group by Shipping_carriers;

-- Q26. Categorize products using CASE WHEN — High/Medium/Low revenue.
select SKU, Revenue_generated, case when revenue_generated>5000 then 'high'
when revenue_generated>2000 then 'medium' else 'low' end as revenue_category from supply_chain;

-- Q27. Count how many products fall in each revenue category.
select case when revenue_generated>5000 then 'high'
when revenue_generated>2000 then 'medium' else 'low'end as category, COUNT(*) from supply_chain
group by case when revenue_generated>5000 then 'high'
when revenue_generated>2000 then 'medium' else 'low' end;

--Q28. Which inspection result type (Pass/Fail/Pending) has the highest avg defect rate?
select inspection_results, AVG(defect_rates_0_1_scale) as Average_defect_rate from supply_chain
group by Inspection_results order by AVG(defect_rates_0_1_scale) desc;

-- Q29. Show products where shipping time exceeds lead time — delayed shipments.
select SKU, shipping_times, lead_times from supply_chain
where Shipping_times>Lead_times order by Shipping_times desc;

-- Q30. What % of products are delayed (shipping time > lead time)?
select ROUND(sum(case when shipping_times>lead_times then 1 else 0 end)*100.0/COUNT(*),3) 
as delayed_percentage from supply_chain;

-- Q31. Show avg order quantity per product type. 
select product_type, AVG(order_quantities) as average_order_quantity from supply_chain
group by Product_type order by AVG(order_quantities) desc;

-- Q32. What is the total production volume per supplier? 
select supplier_name, SUM(production_volumes)as total_production_volume from supply_chain
group by Supplier_name order by SUM(production_volumes) desc;

-- Q33. Show customer demographics breakdown — which segment buys most?
Select customer_demographics, COUNT(*) as total_count, SUM(revenue_generated) as total_revenue from supply_chain
group by Customer_demographics order by total_revenue desc;

--Q34. Which route has the highest average shipping cost?
select routes, AVG(shipping_costs) as average_shipping_cost from supply_chain
group by Routes order by average_shipping_cost desc;

-- Q35. Show top 5 most sold products by quantity
select top 5 SKU, Product_type, SUM(number_of_products_sold) as total_products_sold from supply_chain
group by SKU, Product_type order by total_products_sold desc;

-- Q36. Show products earning above average revenue — high performers.
select SKU,product_type, revenue_generated from supply_chain
where Revenue_generated > (select AVG(revenue_generated) from supply_chain) order by Revenue_generated desc;

-- Q37. Show suppliers whose avg defect rate is above company overall avg defect rate.
select supplier_name, AVG(defect_rates_0_1_scale) as average_defect_rate from supply_chain
group by Supplier_name having AVG(defect_rates_0_1_scale) > (select AVG(defect_rates_0_1_scale) from supply_chain)
order by average_defect_rate desc;

-- Q38. Find the most expensive route for each transportation mode.
select transportation_modes, routes, MAX(shipping_costs) as route_cost from supply_chain
group by Routes, Transportation_modes;

-- Q39. Show products with both high defect rate (>50%) AND high lead time (>15 days) — double risk products.
select SKU, product_type,defect_rates_0_1_scale as high_defect_rate, lead_times from supply_chain
where defect_rates_0_1_scale > 0.5 and Lead_times > 15 order by defect_rates_0_1_scale desc;

-- Q40. Calculate profit margin per product: (Revenue - Mfg Cost - Shipping Cost) / Revenue * 100.
select SKU, product_type, ROUND((revenue_generated-shipping_costs-Manufacturing_costs)*100/nullif(revenue_generated,0),2) 
as Profit_margin from supply_chain order by Profit_margin desc;

-- Q41. Which supplier contributes most to total revenue? Show % contribution.
select supplier_name, SUM(revenue_generated) as revenue, 
ROUND(SUM(revenue_generated)*100/(select sum(revenue_generated) from supply_chain),2) as Percent_contribution
from supply_chain group by Supplier_name order by SUM(revenue_generated) desc;

-- Q42. Show products where stock level is critically low AND high revenue — stockout risk for top earners.
select SKU, product_type, stock_levels, revenue_generated from supply_chain
where Stock_levels<50 and Revenue_generated>(select AVG(revenue_generated) from supply_chain) order by Revenue_generated desc;

-- Q43. Show avg revenue per unit sold for each product type.
select product_type, sum(revenue_generated)/nullif(SUM(number_of_products_sold),0) as revenue_per_unit_sold
from supply_chain group by Product_type order by revenue_per_unit_sold desc;

--Q44. Show shipping carrier efficiency: avg delay (shipping time - lead time) per carrier.
select shipping_carriers, AVG(cast(shipping_times as int)-cast(lead_times as int)) as average_delay from supply_chain
group by Shipping_carriers order by average_delay desc;

-- Q45. Create a supplier scorecard: avg defect rate, avg lead time, total revenue, products count per supplier.
select supplier_name, round(AVG(defect_rates_0_1_scale)*100,2) as average_defect_rate,AVG(lead_times) as average_lead_times,
SUM(revenue_generated) as total_revenue,COUNT(SKU) as product_count_Per_supplier from supply_chain group by Supplier_name;

-- Q46. Which transportation mode has the best cost-to-revenue ratio?
select transportation_modes, SUM(revenue_generated) as total_revenue, SUM(shipping_costs) as total_cost,
ROUND(sum(shipping_costs)*100.0/nullif(sum(revenue_generated),0),2)as cost_to_revenue from supply_chain
group by Transportation_modes order by cost_to_revenue asc;

-- Q47. Show products that failed inspection AND have high defect rate — critical quality issues.
select SKU, product_type, Inspection_results, defect_rates_0_1_scale from supply_chain
where Inspection_results = 'Fail' and Defect_rates_0_1_Scale>0.5 order by Defect_rates_0_1_Scale desc;

-- Q48. Show products below avg stock level within their product type — relative low stock.
select s.SKU, s.product_type, s.stock_levels from supply_chain s
where s.Stock_levels< (select AVG(stock_levels) from supply_chain where Product_type=s.Product_type);

-- Q49. Which location has the worst average defect rate?
select top 1 location, AVG(defect_rates_0_1_scale) as average_defect_rate from supply_chain
group by location order by average_defect_rate desc;

/* Q50. Supply Chain Health Report: per supplier show revenue, defect rate,
delay rate, profit margin, risk level using CASE WHEN.*/
SELECT [Supplier_name], ROUND(SUM([Revenue_generated]),0) AS Revenue, ROUND(AVG([Defect_rates_0_1_Scale])*100,1) AS Defect_Pct,
ROUND(SUM(CASE WHEN [Shipping_times]>[Lead_times] THEN 1 ELSE 0 END)*100.0/COUNT(*),1) AS Delay_Pct,
ROUND(AVG(([Revenue_generated]-[Manufacturing_costs]-[Shipping_costs])*100.0/NULLIF([Revenue_Generated],0)),1) AS Margin_Pct,
CASE WHEN AVG([Defect_rates_0_1_Scale])>0.5 THEN 'HIGH RISK' WHEN AVG([Defect_rates_0_1_Scale])>0.4 THEN 'MEDIUM RISK' ELSE
'LOW RISK' END AS Risk_Level FROM supply_chain GROUP BY [Supplier_name] ORDER BY Defect_Pct DESC;
