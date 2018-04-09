-- AirBNB analysis	
-- 1. What's the most expensive listing? What else can you tell me about the listing?
select
	*
from 
	listings
where
	price = (select max(price) from listings)
	
-- method 2
with
	maxprice
as
(select
	max(price) as PR
from 
	listings
)
select
	*
from
	maxprice
join
	listings
on
	maxprice.PR = listings.price
	
--	2. What neighborhoods seem to be the most popular?
select
		neighbourhood,
		count(name)
from	
		listings
group by 
		neighbourhood
order by
		count(name) desc limit 5

--	3a. What time of year is the cheapest time to go to your city? 
--  I approached this different ways.  First, I looked at which day had the lowest price, and ordered by price.
with sum_table
as
(select
	date as fecha,
	sum(substr(price,2)) as sum_price,
	count(*) as instances
from
	calendar
where
	available = 't'
group by
	date
)

select
	fecha,
	(sum_price / instances) as avg_price,
	instances
from
	sum_table
group by
	fecha
order by
	(sum_price / instances)

-- I also queried based on average price per month, to find the least expensive month.
with sum_table
as
(select
	substr(date,1,7) as month,
	sum(substr(price,2)) as sum_price,
	count(*) as instances
from
	calendar
where
	available = 't'
group by
	substr(date,1,7)
)

select
	month,
	(sum_price / instances) as avg_price,
	instances
from
	sum_table
group by
	month
order by
	(sum_price / instances)
	
-- 3b. What about the busiest?  
-- Here again, I queried by day first to find the occupancy rate for each day.  
-- The highest occupancy rate meant the busiest.

with sum_table
as
(select
	date as day,
	count(*) as instances,
	count(case when available = 'f' then 1 end) as not_avail
from
	calendar
group by
	day
)
select
	day,
	instances,
	not_avail,
	((not_avail*1.0)/instances) as occupancy_rate
from
	sum_table
group by
	day
order by
	((not_avail*1.0)/instances) desc
	
--  I completed the analysis by looking at the data from the persective of busiest month.

with sum_table
as
(select
	substr(date,1,7) as month,
	count(*) as instances,
	count(case when available = 'f' then 1 end) as not_avail
from
	calendar
group by
	month
)
select
	month,
	instances,
	not_avail,
	((not_avail*1.0)/instances) as occupancy_rate
from
	sum_table
group by
	month
order by
	((not_avail*1.0)/instances) desc

-- Additional queries:  how many listings in the most expensive neighbourhoods and 
--  the average price in that neighbourhood?
select
	neighbourhood,
	count(name) frequency,
	avg(price)
from	
	listings
group by 
	neighbourhood
order by
	avg(price) desc limit 10
