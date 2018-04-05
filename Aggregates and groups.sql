--  Using SQL to query bikeshare database.

--	What was the hottest day in our data set? Where was that?
SELECT
		date,
		zip,
		max(MaxTemperatureF)
FROM
		weather

--	How many trips started at each station?
SELECT
		start_station,
		count(*) number
from
		trips
group by
		start_station

--	What's the shortest trip that happened?
select
	min(duration)
from
	trips
-- answer:60 min

-- What is the average trip duration, by end station?
select
	end_station,
	avg(duration)
from
	trips
group by
	end_station
