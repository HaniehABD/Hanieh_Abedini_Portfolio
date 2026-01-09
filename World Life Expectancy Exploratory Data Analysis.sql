SELECT * 
FROM worldlifeexpectancy;

select country, year, concat(country,year), count(concat(country,year))
from worldlifeexpectancy
group by country, year, concat(country,year)
having count(concat(country,year)) > 1
;

select*
from(
select Row_ID, concat(country,year),
row_number() over(partition by concat(country,year) order by concat(country,year) ) as row_num
from worldlifeexpectancy) as row_tabel
where row_num >1
;

delete from worldlifeexpectancy
where
Row_ID in (
select Row_ID
from(
select Row_ID, concat(country,year),
row_number() over(partition by concat(country,year) order by concat(country,year) ) as row_num
from worldlifeexpectancy) as row_tabel
where row_num >1);


SELECT *
FROM worldlifeexpectancy
WHERE Status = ''
;

select distinct(Status)
from worldlifeexpectancy
where status <> ''
;

select distinct (country)
from worldlifeexpectancy
where Status = 'Developing'
;

update worldlifeexpectancy t1
join worldlifeexpectancy t2
     on t1.country = t2.country
     set t1.status = 'Developing'
     where t1.status = ''
     and t2.status <> ''
     and t2.status = 'Developing'
     ;
     
     update worldlifeexpectancy t1
join worldlifeexpectancy t2
     on t1.country = t2.country
     set t1.status = 'Developed'
     where t1.status = ''
     and t2.status <> ''
     and t2.status = 'Developed'
     ;

SELECT * 
FROM worldlifeexpectancy;

select*
from worldlifeexpectancy
where `Life expectancy` = ''
;

select t1.country, t1.year, t1.`Life expectancy`,
t2.country, t2.year, t2.`Life expectancy`,
t3.country, t3.year, t3.`Life expectancy`,
round(( t1.`Life expectancy`+ t2.`Life expectancy`)/2, 1)
from worldlifeexpectancy t1
join worldlifeexpectancy t2
     on t1.country=t2.country
     and t1.year = t2.year -1
join worldlifeexpectancy t3
     on t1.country=t3.country
     and t1.year = t3.year +1
where t1.`Life expectancy` = ''
;

update worldlifeexpectancy t1
join worldlifeexpectancy t2
     on t1.country=t2.country
     and t1.year = t2.year -1
join worldlifeexpectancy t3
     on t1.country=t3.country
     and t1.year = t3.year +1
set t1.`Life expectancy` = round(( t1.`Life expectancy`+ t2.`Life expectancy`)/2, 1)
where t1.`Life expectancy` = '';

-- 
select country, min(`Life expectancy`),
 max(`Life expectancy`),
 round(max(`Life expectancy`) - min(`Life expectancy`), 1) as life_increase_15_years
FROM worldlifeexpectancy
group by country
having min(`Life expectancy`) <> 0
and max(`Life expectancy`) <> 0
order by life_increase_15_years Desc
;

select year, round(avg(`Life expectancy`),2)
from worldlifeexpectancy
where `Life expectancy`<>0
and `Life expectancy` <>0
group by year
order by year
;

select Country,ROUND(AVG(GDP),1)AS GDP, round(avg(`Life expectancy`),1) AS LIFE_EX
from worldlifeexpectancy
GROUP BY Country
HAVING life_ex > 0
and GDP >0
ORDER BY GDP ASC
;


SELECT 
SUM(CASE WHEN GDP >= 1500 then 1 else 0 end) high_GDP_count,
avg(case when GDP >= 1500 then `Life expectancy` else null end ) high_GDP_Life_expectancy,
SUM(CASE WHEN GDP <= 1500 then 1 else 0 end) low_GDP_count,
avg(case when GDP <= 1500 then `Life expectancy` else null end ) low_GDP_Life_expectancy
from worldlifeexpectancy
;


select status, round(avg(`Life expectancy`),1)
from worldlifeexpectancy
group by status
;

select status, count(distinct country)
from worldlifeexpectancy
group by status
;

select country, round(avg(`Life expectancy`),1) as life_exp,round(avg(BMI),1) as BMI
from worldlifeexpectancy
group by country
having life_exp > 0
order by BMI desc
;

select country,
year,
`Life expectancy`,
`Adult Mortality`,
sum(`Adult Mortality`) over (partition by country order by year) as rolling_total
from worldlifeexpectancy
where country like'%United%'
;
