-- Rape Case Analysis in India (2018 - 2022)

-- Create new database
create database r_casein_inida ; 

-- Name of current database that use  
use r_casein_inida ; 

-- Information from the tables 
select * from r_case_in_state ;
select * from r_case_in_ut ; 

-- Rename the column 
alter table r_case_in_ut
rename column `ï»¿Sl. No.` to  Sl_No  ; 

alter table r_case_in_state
rename column `ï»¿Sl. No.` to Sl_No ; 

-- Somehow Ladakh data is not imported, so add Ladakh row

Insert into r_case_in_ut (
  Sl_No, UT,
  Rape_2018_Girls_Below_18, Rape_2018_Women_Above_18, Rape_2018_TotalCasesRegistered,
  CCS_2018, CTC_2018,
  Rape_2019_Girls_Below_18, Rape_2019_Women_Above_18, Rape_2019_TotalCasesRegistered,
  CCS_2019, CTC_2019,
  Rape_2020_Girls_Below_18, Rape_2020_Women_Above_18, Rape_2020_TotalCasesRegistered,
  CCS_2020, CTC_2020,
  Rape_2021_Girls_Below_18, Rape_2021_Women_Above_18, Rape_2021_TotalCasesRegistered,
  CCS_2021, CTC_2021,
  Rape_2022_Girls_Below_18, Rape_2022_Women_Above_18, Rape_2022_TotalCasesRegistered,
  CCS_2022, CTC_2022)
Values (34, 'Ladakh',Null, Null, Null, Null, Null,Null, Null, Null, Null, 
Null,1, 1, 2, 1, 2,1, 1, 2, 1, 1,1, 4, 5, 5, 1);

-- Quick Stats 

-- Total tables in the database 
select count(*) as Total_tables 
from information_schema.tables
where table_schema = database() ; 

-- Total Fileds OR Columns from table 1 
select count(*)
from information_schema.columns 
where table_schema =  "r_casein_inida"
and table_name =  "r_case_in_state" ; 
-- Total Fileds OR Columns from table 2
select count(*)
from information_schema.columns 
where table_schema =  "r_casein_inida"
and table_name =  "r_case_in_ut" ; 

-- Infromation about the fileds(Column heading) of the table 1 
Describe r_case_in_state ; 
-- or 
show columns from r_case_in_state ; 
-- Infromation about the fileds(Column heading) of the table 1 
describe r_case_in_ut ;
-- or 
show columns from r_case_in_ut ; 

-- Total records from both tables
Select (select count(*) from  r_case_in_state ) as Total_States,
		(select count(*) from r_case_in_ut ) as Total_UT,
        (select count(*) from  r_case_in_state )  +
        (select count(*) from r_case_in_ut ) as Total_Records ; 
-- OR

select count(*) as Total_Records from r_case_in_state
union All 
select count(*) as Total_UT from r_case_in_ut ; 

-- OR as we know both state and UT are unique 
select r_case_in_state as Sate, count(*)  as Total_records from r_case_in_state
union 
select r_case_in_ut as UT, count(*) as Total_records from r_case_in_ut ; 

-- Creating master table as there is no common col. b/w state & UT 
ALTER TABLE r_case_in_state RENAME COLUMN State TO RegionName;
ALTER TABLE r_case_in_ut RENAME COLUMN UT TO RegionName;

select * from r_case_in_state ;
select * from r_case_in_ut; 

Create table  r_case_StateUT as
Select  
  "State" as RegionType,
  Sl_No,
  RegionName,
  Rape_2018_Girls_Below_18,
  Rape_2018_Women_Above_18,
  Rape_2018_TotalCasesRegistered,
  CCS_2018,
  CTC_2018,
  Rape_2019_Girls_Below_18,
  Rape_2019_Women_Above_18,
  Rape_2019_TotalCasesRegistered,
  CCS_2019,
  CTC_2019,
  Rape_2020_Girls_Below_18,
  Rape_2020_Women_Above_18,
  Rape_2020_TotalCasesRegistered,
  CCS_2020,
  CTC_2020,
  Rape_2021_Girls_Below_18,
  Rape_2021_Women_Above_18,
  Rape_2021_TotalCasesRegistered,
  CCS_2021,
  CTC_2021,
  Rape_2022_Girls_Below_18,
  Rape_2022_Women_Above_18,
  Rape_2022_TotalCasesRegistered,
  CCS_2022,
  CTC_2022
from r_case_in_state

Union All

select  
  "UT" as RegionType,
  Sl_No,
  RegionName,
  Rape_2018_Girls_Below_18,
  Rape_2018_Women_Above_18,
  Rape_2018_TotalCasesRegistered,
  CCS_2018,
  CTC_2018,
  Rape_2019_Girls_Below_18,
  Rape_2019_Women_Above_18,
  Rape_2019_TotalCasesRegistered,
  CCS_2019,
  CTC_2019,
  Rape_2020_Girls_Below_18,
  Rape_2020_Women_Above_18,
  Rape_2020_TotalCasesRegistered,
  CCS_2020,
  CTC_2020,
  Rape_2021_Girls_Below_18,
  Rape_2021_Women_Above_18,
  Rape_2021_TotalCasesRegistered,
  CCS_2021,
  CTC_2021,
  Rape_2022_Girls_Below_18,
  Rape_2022_Women_Above_18,
  Rape_2022_TotalCasesRegistered,
  CCS_2022,
  CTC_2022
from r_case_in_ut;

select * from r_case_stateut ;

select sum(Rape_2018_Women_Above_18)
from r_case_in_ut ; 
select sum(Rape_2018_Women_Above_18)
from r_case_in_state ;
SELECT 
  COUNT(*) AS total_rows,
  COUNT(Rape_2018_Women_Above_18) AS non_null_rows,
  SUM(Rape_2018_Women_Above_18) AS raw_sum,
  SUM(COALESCE(Rape_2018_Women_Above_18, 0)) AS sum_with_nulls_as_zero
FROM r_case_in_ut ;

-- National Rape Average Across All States/UTs
SELECT ROUND((
    SUM(COALESCE(Rape_2018_Women_Above_18, 0)) +
    SUM(COALESCE(Rape_2019_Women_Above_18, 0)) +
    SUM(COALESCE(Rape_2020_Women_Above_18, 0)) +
    SUM(COALESCE(Rape_2021_Women_Above_18, 0)) +
    SUM(COALESCE(Rape_2022_Women_Above_18, 0))
) / 5) AS avg_rape_per_year_below_18
FROM r_case_stateut;
-- 27,140
/**/

Select 
  round(Avg(
    coalesce(Rape_2018_TotalCasesRegistered, 0) +
    coalesce(Rape_2019_TotalCasesRegistered, 0) +
    coalesce(Rape_2020_TotalCasesRegistered, 0) +
    coalesce(Rape_2021_TotalCasesRegistered, 0) +
    coalesce(Rape_2022_TotalCasesRegistered, 0)
  ) / 5) AS National_Avg_Rape_2018_22
from r_case_stateut;
-- 870 
/*💡 Insight: From 2018 to 2022, each State/UT in India registered an 
average of over 870 rape cases annually.
However, this number likely underrepresents the actual number of 
incidents, as many cases may go unreported due to fear of social stigma, 
threats, or concerns about family reputation. This highlights the 
urgent need for awareness, support systems for victims, and 
systemic reforms in justice and prevention.*/

/* India’s Average Annual Reported Rape Cases Involving Girls Below 18 
(2018–2022)*/
SELECT ROUND((
    SUM(COALESCE(Rape_2018_Girls_Below_18, 0)) +
    SUM(COALESCE(Rape_2019_Girls_Below_18, 0)) +
    SUM(COALESCE(Rape_2020_Girls_Below_18, 0)) +
    SUM(COALESCE(Rape_2021_Girls_Below_18, 0)) +
    SUM(COALESCE(Rape_2022_Girls_Below_18, 0))
) / 5) AS avg_rape_per_year_below_18
FROM r_case_stateut;
-- 4185
/*Between 2018 and 2022, India recorded an average of 4,185 rape cases 
each year involving girls under the age of 18.
This troubling statistic reveals the ongoing vulnerability of minors 
to sexual violence and reinforces the urgent need for stronger child 
protection laws, faster justice delivery, safer reporting environments, 
and widespread awareness to safeguard children from such heinous crimes.*/



-- Objective 


-- Analysis


