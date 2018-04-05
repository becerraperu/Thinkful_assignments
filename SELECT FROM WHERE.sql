-- SELECT, FROM, WHERE questions and answers.

--	The ID's and durations for all trips of duration greater than 500, ordered by duration.
select
	trip_id,
	duration
from
	trips
where
	duration > 500
order by duration desc

-- Every column of the stations table for station id 84.

select
	*
from
	stations
where
	station_id = 84

--	The min temperatures of all the occurrences of rain in zip 94301.
select
	Date,
	MinTemperatureF,
	zip,
	events
from
	weather
where
	events like '%rain%' AND
	zip = 94301

