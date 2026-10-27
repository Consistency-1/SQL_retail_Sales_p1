

--select  count(*) from [DataWarehouseAnalytics].[gold].[Retail_Sales ]
--select  count(distinct customer_id) from [DataWarehouseAnalytics].[gold].[Retail_Sales ]

--select  distinct category  from [DataWarehouseAnalytics].[gold].[Retail_Sales ]

--Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from gold.Retail_Sales
where sale_date = '2022-11-05'


--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select *
from gold.Retail_Sales
where category in ('Clothing') and quantiy>=4 and FORMAT(sale_date, 'MMM yyyy') = 'Nov 2022'

--Write a SQL query to calculate the total sales (total_sale) for each category.:
select 
category,
sum(total_sale) as total_sales
from gold.Retail_Sales
group by category



--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select 
category,
round(avg(age),2) as average_age
from gold.Retail_Sales
where category='Beauty'
group by category



--Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select 
transactions_id
from gold.Retail_Sales
where total_sale > 1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select 
category,
gender,
count(transactions_id) as no_of_transactions
from gold.Retail_Sales
group by category,
gender


--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select * from 
(select 
month(sale_date) as month,
year(sale_date) as year,
avg(total_sale) as avg_sales,
rank() over (partition by year(sale_date) order by avg(total_sale) desc ) as rank_1
from gold.Retail_Sales
group by 
month(sale_date),
year(sale_date)
) as temp
where rank_1 =1
--order by 2,
--avg(total_sale) desc


--**Write a SQL query to find the top 5 customers based on the highest total sales **:


select top 5
customer_id ,
sum(total_sale) as total_sales
from gold.Retail_Sales
group by customer_id
order by sum(total_sale) desc


--Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct customer_id) as distinct_Customer,
category
from gold.Retail_Sales
group by category



--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


with hourly as
(
select *,
case 
when datepart(hour, sale_time) < 12 then 'Morning'
when datepart(hour, sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as Shift
from gold.Retail_Sales
)
select 
count(*) as orders,
Shift
from
hourly
group by shift



---end project
