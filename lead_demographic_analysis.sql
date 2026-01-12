-- Create Database for the project--

create database lead_demographic_analysis;

-- Create table leads --

create table leads (
lead_id varchar(20) primary key,
age int,
gender varchar(10),
current_city varchar(50),
current_education varchar(50),
parent_occupation varchar(50),
lead_gen_source varchar(50));

-- View all data --

select * from leads;

-- Count total leads --

select count(*) as total_leads from leads;

-- View leads from a specific city --

select * from leads
where current_city = 'Mumbai';

-- List Unique lead sources --

select distinct lead_gen_source
from leads;

-- Sort leads by age --

select lead_id, age
from leads
order by age desc;

-- Sort and count leads by gender --

select gender, count(*) as total_leads
from leads
group by gender;

-- Count the total number of leads by city --

select current_city, count(*) as leads_count
from leads
group by current_city
order by leads_count desc;

-- Count the total number of leads by educational level --

select current_education, count(*) as total_leads
from leads
group by current_education;

-- Calculate the average age by gender --

select gender, avg(age) as average_age
from leads
group by gender;

-- Find out the top 3 cities generating the most leads --

select current_city, count(*) as total_leads
from leads
group by current_city
order by total_leads desc limit 3;

-- Find out the best lead source for each city --

select current_city, lead_gen_source, count(*) as total_leads
from leads
group by current_city, lead_gen_source
order by current_city, total_leads desc;

-- Rank cities by lead volume --

select current_city, count(lead_id) as lead_count, rank() over(order by count(lead_id) desc) as city_rank
from leads
group by current_city;

-- Rank lead sources by performance --

select lead_gen_source, count(lead_id) as lead_count,
dense_rank() over(order by count(lead_id) desc) as source_rank
from leads
group by lead_gen_source;

-- Find the cities contributing more than average lead --

with a as (
select count(lead_id)/count(distinct current_city) as avg_leads from leads),
b as (select current_city, count(*) as total_leads
from leads
group by current_city)
select b.current_city from b
cross join a where b.total_leads > a.avg_leads;

-- Find out leads older than average age --

select * from leads
where age > (select avg(age) from leads);




