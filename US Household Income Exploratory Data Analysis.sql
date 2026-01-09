
SELECT *
 FROM us_project.ushouseholdincome;
 
 SELECT *
 FROM us_project.ushouseholdincome_statistics;
 
 select id, count(id)
 from  us_project.ushouseholdincome
 group by id
 having count(id) >1
 ;
 
 -- now removing  duplicates
 select*
 from (
 select row_id,
 id,
 row_number() over (partition by id order by id) row_num
 from us_project.ushouseholdincome
 ) as duplicates
 where row_num >1
 ;
 
 
delete from us_project.ushouseholdincome
where row_id in(
  select row_id
 from (
 select row_id,
 id,
 row_number() over (partition by id order by id) row_num
 from us_project.ushouseholdincome
 ) as duplicates
 where row_num >1)
 ;
 
 
 -- now lets do it for other tables too
 
 select id, count(id)
 from  us_project.ushouseholdincome_statistics
 group by id
 having count(id) >1
 ;
 
 -- we had no duplicates yayy
 
 select state_name, count(state_name)
  from us_project.ushouseholdincome
  group by state_name
  ;
  
  select distinct state_name
  from us_project.ushouseholdincome
  ;
  
  update us_project.ushouseholdincome
  set state_name = 'Georgia'
  where state_name = 'georia'
  ;
  
  update us_project.ushouseholdincome
  set state_name = 'Alabama'
  where state_name = 'alabama'
  ;
 
 select*
 from us_project.ushouseholdincome
 where place = ''
 order by 1
 ;
 
 select*
 from us_project.ushouseholdincome
 where county = 'Autauga County'
 order by 1
 ;
 
 select type, count(type)
 from us_project.ushouseholdincome
 group by type
 ;
 
 update us_project.ushouseholdincome
 set type = 'Borough'
 where type = 'Boroughs'
 ;
 
 update us_project.ushouseholdincome
 set place = 'Autaugaville'
 where county = 'Autauga County'
 and city = 'Vinemont'
 ;
 
 select Aland, Awater
 from us_project.ushouseholdincome
 where Awater = 0 or Awater = '' or Awater is null
 ;
 