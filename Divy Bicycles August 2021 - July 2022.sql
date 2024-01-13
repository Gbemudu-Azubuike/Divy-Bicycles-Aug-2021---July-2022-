-- DIvy Cycling Data for 1 year (August 2021 - July 2022)

-- Import data into SQLSERVER Management Studio

-- Visually inspecting top 10 tows from 4 consecutive tows to better understand the data better

select top 10 *
from [Divy Cycling]..August_2021_1

select top 10 *
from [Divy Cycling]..September_2021

select top 10 *
from [Divy Cycling]..October_2021

select top 10 *
from [Divy Cycling]..November_2021


-- Checking Schema properties of all the months tables to better understand the data

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('August_2021_1')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('September_2021')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('October_2021')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('November_2021')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('December_2021')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('Janurary_2022')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('Feburary_2022')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('March_2022')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('April_2022')
order by c.name


select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('May_2022')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('June_2022')
order by c.name

select c.name as column_name,t.name as data_type
from sys.columns c
inner join sys.types t on
c.user_type_id = t.system_type_id
where c.object_id =  object_id('July_2022')
order by c.name

-- Delecting Duplicate columns from the table 'September_2021'

select *
from September_2021

Alter table september_2021
drop column  start_station_name6, start_station_id7, end_station_name8, end_station_id9, start_lat10, 
start_lng11, member_casual14;

Alter table october_2021
drop column started_date, started_time, ended_date, ended_time;


-- Creating a new table to compile the years worth of Divy Cycling Data

Create table Divy_2021(
Ride_id nvarchar(250),
Rideable_type nvarchar (250),
Started_at Datetime,
Ended_at Datetime,
Start_station_name nvarchar (250),
Start_Station_id nvarchar (250),
End_station_name nvarchar (250),
End_Station_Id nvarchar (250),
Start_lat float,
Start_lng float,
End_lat float,
End_lng float,
Member_Casual nvarchar(250))


-- Importing Data from each month August 2021 - July 2022 into the new table

insert into Divy_2021
select *
from August_2021_1

insert into Divy_2021
select *
from September_2021

insert into Divy_2021
select *
from October_2021

insert into Divy_2021
select *
from November_2021

insert into Divy_2021
select *
from December_2021

insert into Divy_2021
select *
from Janurary_2022

insert into Divy_2021
select *
from Feburary_2022

insert into Divy_2021
select *
from March_2022

insert into Divy_2021
select *
from April_2022

insert into Divy_2021
select *
from May_2022

insert into Divy_2021
select *
from June_2022

insert into Divy_2021
select *
from July_2022

-- Confirming Data import into the new table

select top 10 *
from Divy_2021


-- Spliting Date and time for easy Understanding

alter table Divy_2021
add started_Date date

alter table Divy_2021
add started_Time time

alter table Divy_2021
add ended_Date date

alter table Divy_2021
add ended_time time

update Divy_2021
set started_Date = CAST(started_at as date)

update Divy_2021
set ended_Date = CAST(ended_at as date)

update Divy_2021
set ended_time = CAST(ended_at as time)

update Divy_2021
set started_time = CAST(started_at as time)

-- Drop columns no longer in use (Started_at and Ended_at columns are to be dropped)
	
	Alter table divy_2021
	drop column started_at, ended_at

-- Renaming the columns to make them more readable

exec sp_rename 'divy_2021.Bicycle type', 'Bicycle_Type'
exec sp_rename 'divy_2021.Start_Station_name', 'Station_of_Origin'
exec sp_rename 'divy_2021.Start_Station_ID', 'Origin_Station_ID'
exec sp_rename 'divy_2021.End_Station_name', 'Destination_Station'
exec sp_rename 'divy_2021.End_Station_ID', 'Destination_Station_ID'
exec sp_rename 'divy_2021.Start_lat', 'Start_Latitude'
exec sp_rename 'divy_2021.Start_lng', 'Start_Longitude'
exec sp_rename 'divy_2021.End_lat', 'End_Latitude'
exec sp_rename 'divy_2021.End_lng', 'End_Longitude'
exec sp_rename 'divy_2021.Member_Casual', 'Membership_Type'



-- Identifying Duplicate Bike Trip Records

Select  *, count (*) as Count_of_Duplicate
from divy_2021
group by ride_id, Bicycle_type, Station_of_Origin, Origin_Station_ID,
Destination_station, Destination_station_id, start_latitude, start_longitude,
end_latitude, end_longitude, membership_type, started_date, started_time,
ended_date, ended_time
having COUNT(*) > 1

--Deleting duplicate rows of data using CTE
--(The CTE works by selecting all the data, partition the row number function in each row of our ride_id)

with Divy_2021CTE as
(
select *, ROW_NUMBER() over (Partition by ride_id order by ride_id) as RowNumber
from Divy_2021
)
Delete from Divy_2021CTE
where RowNumber >1

-- Checked for Null values in essential columns by using CASE statements

select 
sum (case when ride_id is null then 1 else 0 end) as ride_id_null_count,
sum (case when bicycle_type is null then 1 else 0 end) as bicycle_ride_null_count,
sum (case when station_of_origin is null then 1 else 0 end) as station_of_origin_null_count,
sum (case when Origin_station_id is null then 1 else 0 end) as origin_station_null_count,
sum (case when Destination_station is null then 1 else 0 end) as Destination_station_null_count,
sum (case when Destination_station_id is null then 1 else 0 end) as destination_station_id_null_count
from Divy_2021

--updating Null Names to Unavaila

update Divy_2021
set Station_of_Origin = 'Unavailable'
where Station_of_Origin is null

update Divy_2021
set Origin_Station_ID = 'Unavailable'
where Origin_Station_ID is null

update Divy_2021
set Destination_Station = 'Unavailable'
where Destination_Station is null

update Divy_2021
set Destination_Station_ID = 'Unavailable'
where Destination_Station_ID is null


-- Capitalizing First letters in the Bicycle_type and Membership_type columns

update Divy_2021
set Bicycle_Type = upper(substring(bicycle_type,1,1)) + LOWER(SUBSTRING(bicycle_type,2,len(bicycle_type)))

update Divy_2021
set Membership_Type = upper(substring(Membership_Type,1,1)) + LOWER(SUBSTRING(Membership_Type,2,len(bicycle_type)))


----- Data cleaning Done

---- Data Analysis
	-- Divy Cycling Business Questions to be answered

		-- 1 How do the 2 Membership_type differ from each other
		
		select membership_type, bicycle_type, COUNT(*) as Count_of_Trip
		from Divy_2021
		group by Membership_Type, Bicycle_Type
		order by Count_of_Trip desc

		-- 2 What motivates casual riders to purchase Cyclistic annual memberships?

		select Membership_Type, AVG(DATEDIFF(minute,started_Time, ended_time)) as Avg_Ride_lenght_Minutes
		from Divy_2021
		group by Membership_Type

		--3. How can Cyclistic leverage digital media to encourage casual riders to become members?

			-- Most Popular bike type per membership type
			select membership_type, bicycle_type, COUNT(*) as type_of_bike
			from Divy_2021
			group by Membership_Type, Bicycle_Type
			order by type_of_bike desc


	-- Most Popular bike type
		select Bicycle_type, COUNT(*) as type_of_bike
		from Divy_2021
		group by Bicycle_Type
		order by type_of_bike desc

	
		select Bicycle_type, station_of_origin, COUNT(*) as type_of_bike
		from Divy_2021
		where not Station_of_Origin = 'Unavailable'
		group by Station_of_Origin, Bicycle_Type
		order by type_of_bike
		
	-- Most Popular station of Origin
		select station_of_origin, COUNT(*) as rides_started
		from Divy_2021
		where not Station_of_Origin = 'Unavailable' 
		group by station_of_Origin
		order by rides_started desc

	-- Most Popular station of Destination

		select Destination_station, COUNT(*) as rides_ended
		from Divy_2021
		where not Destination_Station = 'Unavailable'
		group by Destination_Station
		order by rides_ended desc
		

	--Most popular start station for each membership type
		select Membership_Type, Station_of_Origin, COUNT(*) as Start_count
		from Divy_2021
		where not Station_of_Origin = 'Unavailable'
		group by Membership_Type, Station_of_Origin
		order by Start_count desc

	-- Most popualr end station name
		select Membership_Type, Destination_Station, COUNT(*) as end_count
		from Divy_2021
		where not Destination_Station = 'Unavailable'
		group by Membership_Type, Destination_Station
		order by end_count desc

	-- Most Popular ride routes
		select Station_of_Origin, Destination_Station, COUNT(*) as rides
		from Divy_2021
		where not Station_of_Origin = 'Unavailable' and not Destination_Station = 'Unavailable'
		group by Station_of_Origin, Destination_Station
		order by rides desc

	-- Distribution of ride duration
		select started_time, ended_time, DATEDIFF(MINUTE, started_Time, ended_time) as ride_duration_Minutes
		from Divy_2021
		order by ride_duration_Minutes desc