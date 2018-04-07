-- 1. What are the three longest trips on rainy days?

WITH
    rainy_day
AS (
	select
		date, ZIP
	from
		weather
	where	
		events = 'Rain'
)
select
	trip_id,
	duration,
	start_date
from
	rainy_day		
join
	trips
on
	date(trips.start_date) = rainy_day.date and trips.zip_code = rainy_day.ZIP
order by 
	duration desc 
	limit 3

-- 2. Which station is full most often?

select
	name,
	docks_available,
	count(*) minutes_full
from
	status
join	
	stations
on 
	stations.station_id = status.station_id
where
	docks_available = 0
group by
	name
order by
	count(*) desc


-- 3. Return a list of stations with a count of number of trips 
-- starting at that station but ordered by dock count.

select
		station_id,
		name,
		dockcount
from 
stations
join
		trips
on 
		stations.name = trips.start_station
group by 1
order by dockcount

-- 4. (Challenge) What's the length of the longest trip for each day it rains anywhere?

WITH
    rainy_day
AS (
	select
		date as calendar_date
	from
		weather
	where	
		upper(events) like '%rain%'
	group by
		calendar_date
)

select
	date(t.start_date) day_of_trip,
	max(t.duration) length_of_trip
from	
	trips t
join	
	rainy_day r
on
	r.calendar_date = date(t.start_date)
group by
	date(t.start_date)
