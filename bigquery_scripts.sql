select * from `bigquery-public-data.iowa_liquor_sales.sales` limit 100;

-- 20 milions of rows 
SELECT distinct count (invoice_and_item_number) FROM `bigquery-public-data.iowa_liquor_sales.sales` ;

-- продажи по странам 
select cast(county_number as NUMERIC) as country_code, lower(county) as county,lower(city) as city,
sum(sale_dollars), sum(volume_sold_liters)
from `bigquery-public-data.iowa_liquor_sales.sales`
group by county_number, county, city

-- продажи алкоголя по месяцам 
select  EXTRACT(MONTH FROM date) as month, EXTRACT(YEAR FROM date) as year,
sum(sale_dollars) as sum_sales, sum(volume_sold_liters) as sum_sold_liters
from `bigquery-public-data.iowa_liquor_sales.sales`
group by EXTRACT(MONTH FROM date), EXTRACT(YEAR FROM date)



-- about county and county_number
-- problem: 11,17,71,78 - country with this codes have duplicates
-- reason: different county names
select * from (
select lower(county) as county, cast(county_number as NUMERIC) as county_number
from `bigquery-public-data.iowa_liquor_sales.sales`
where county_number is not null 
group by county_number, county) 
group by county_number, county
order by county_number

