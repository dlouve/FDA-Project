/*Descriptive Analysis*/

/*How many different countries have enforcement and which ones?*/
select country, count(country) as COUNTRY_COUNT
from schema_fda.enforcement
group by country
order by COUNTRY_COUNT desc

/*Who was the initiator of the Enforcement?*/
select VOLUNTARY_MANDATED, count(VOLUNTARY_MANDATED) as VOLUNTARY_MANDATED_COUNT
from schema_fda.enforcement
group by VOLUNTARY_MANDATED
order by VOLUNTARY_MANDATED_COUNT desc

/*How were the enforcements made public?*/
select INITIAL_FIRM_NOTIFICATION, count(INITIAL_FIRM_NOTIFICATION) as INITIAL_FIRM_NOTIFICATION_COUNT
from schema_fda.enforcement
group by INITIAL_FIRM_NOTIFICATION
order by INITIAL_FIRM_NOTIFICATION_COUNT

/*Which city is most affected?*/
select CITY, count(CITY) as CITY_COUNT
from schema_fda.enforcement
group by CITY
order by CITY_COUNT desc
LIMIT 10;

/*Which state is most affected?*/
select STATE, country
, count(STATE) as STATE_COUNT
from schema_fda.enforcement
group by STATE, country
order by STATE_COUNT desc
LIMIT 10;

/*Which companies from which countries are most affected?*/
select RECALLING_FIRM, country,
 count(RECALLING_FIRM) as RECALLING_FIRM_COUNT
from schema_fda.enforcement
group by RECALLING_FIRM, country
order by RECALLING_FIRM_COUNT desc
LIMIT 10;

/*Number of enforcements initiated per year*/
select count(event_id) as event_id_sum,
       substr(RECALL_INITIATION_DATE,1,4) as RECALL_INITIATION_DATE_YEAR     
from  schema_fda.enforcement
group by RECALL_INITIATION_DATE_YEAR
order by RECALL_INITIATION_DATE_YEAR

/*Current status of the enforcements?*/
select STATUS, count(STATUS) as STATUS_COUNT
from schema_fda.enforcement
group by STATUS
order by STATUS_COUNT desc

/*How much time lies between the initial date and the report date in average?*/
SELECT distinct
    RECALLING_FIRM,
    country,
    DATEDIFF(DAY, TO_DATE(RECALL_INITIATION_DATE, 'YYYYMMDD'), TO_DATE(REPORT_DATE, 'YYYYMMDD')) AS time_difference_in_days
FROM 
    schema_fda.enforcement
    order by time_difference_in_days desc
    LIMIT 10;
