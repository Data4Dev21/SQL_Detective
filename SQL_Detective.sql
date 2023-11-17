--Murder mystery
/*A crime has taken place and the detective needs your help.
The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​.
Start by retrieving the corresponding crime scene report from the police department’s database.*/

--Crime scene report
SELECT * 
  FROM crime_scene_report
  WHERE city in ('SQL City') 
  AND type = 'murder'
  AND date = 20180115; --Last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

--Person Table (Witness 1)  
SELECT *
  FROM person
  WHERE address_street_name in ('Northwestern Dr')
  ORDER BY address_number desc
  limit 1; --14887

--Person Table (Witness 2)  
SELECT *
  FROM person
  WHERE address_street_name in ('Franklin Ave')
  ORDER BY address_number desc
  limit 1; --16371

--Interview Table
SELECT *
  FROM interview
  WHERE person_id in (16371,14887);

--Getfit_member/checkin
SELECT m.*
      ,c.check_in_date
  FROM get_fit_now_member m
  JOIN get_fit_now_check_in c on m.id=c.membership_id
  WHERE membership_status = 'gold'
  AND id like "48Z%"
  AND check_in_date = 20180109

--Tracing murderer to his car number
SELECT p.*
	  ,d.gender
	  ,d.plate_number
FROM person p
JOIN drivers_license d on p.license_id=d.id
WHERE d.gender = 'male'
AND d.plate_number like '%H42W%';

--Murderer CTE
WITH CTE AS
(
SELECT c.membership_id
	  ,m.person_id
	  ,m.name
	  ,m.membership_status
	  ,c.check_in_date
FROM get_fit_now_check_in c
JOIN get_fit_now_member m on c.membership_id=m.id
WHERE m.membership_status = 'gold'
AND c.membership_id like "48Z%"
AND c.check_in_date = 20180109
)
SELECT p.*
      ,m.person_id
	    ,d.gender
	    ,d.plate_number
  FROM person p
  JOIN drivers_license d on p.license_id=d.id
  JOIN cte m on m.person_id=p.id
  WHERE d.gender = 'male'
  AND d.plate_number like '%H42W%';

--Murderes Interview
SELECT *
FROM interview
WHERE person_id = 67318

--The Villain
SELECT p.id
      ,p.name
      ,p.license_id
      ,d.*
  FROM drivers_license d
  JOIN person p on d.id=p.license_id
  WHERE gender = 'female'
  AND car_make = 'Tesla'
  AND car_model = 'Model S'
  AND hair_color = 'red'
--Murder mystery
/*A crime has taken place and the detective needs your help.
The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​.
Start by retrieving the corresponding crime scene report from the police department’s database.*/

--Crime scene report
SELECT * 
  FROM crime_scene_report
  WHERE city IN ('SQL City') 
  AND type = 'murder'
  AND date = 20180115; --Last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

--Person Table (Witness 1)  
SELECT *
  FROM person
  WHERE address_street_name IN ('Northwestern Dr')
  ORDER BY address_number DESC
  LIMIT 1; --14887

--Person Table (Witness 2)  
SELECT *
  FROM person
  WHERE address_street_name IN ('Franklin Ave')
  ORDER BY address_number DESC
  limit 1; --16371

--Interview Table
SELECT *
  FROM interview
  WHERE person_id IN (16371,14887);

--Getfit_member/checkin
SELECT m.*
      ,c.check_in_date
  FROM get_fit_now_member m
  JOIN get_fit_now_check_in c ON m.id=c.membership_id
  WHERE membership_status = 'gold'
  AND id LIKE "48Z%"
  AND check_in_date = 20180109

--Tracing murderer to his car number
SELECT p.*
	  ,d.gender
	  ,d.plate_number
FROM person p
JOIN drivers_license d ON p.license_id=d.id
WHERE d.gender = 'male'
AND d.plate_number LIKE '%H42W%';

--Murderer CTE
WITH CTE AS
(
SELECT c.membership_id
	  ,m.person_id
	  ,m.name
	  ,m.membership_status
	  ,c.check_in_date
FROM get_fit_now_check_in c
JOIN get_fit_now_member m ON c.membership_id=m.id
WHERE m.membership_status = 'gold'
AND c.membership_id LIKE "48Z%"
AND c.check_in_date = 20180109
)
SELECT p.*
      ,m.person_id
	    ,d.gender
	    ,d.plate_number
  FROM person p
  JOIN drivers_license d ON p.license_id=d.id
  JOIN cte m ON m.person_id=p.id
  WHERE d.gender = 'male'
  AND d.plate_number LIKE '%H42W%';

--Murderes Interview
SELECT *
FROM interview
WHERE person_id = 67318

--The Villain
SELECT p.id
      ,p.name
      ,p.license_id
      ,d.*
  FROM drivers_license d
  JOIN person p ON d.id=p.license_id
  WHERE gender = 'female'
  AND car_make = 'Tesla'
  AND car_model = 'Model S'
  AND hair_color = 'red'

--Event Check
SELECT *, COUNT(person_id) AS attendance
  FROM facebook_event_checkin
  WHERE event_name LIKE '%symphony%'
  AND date BETWEEN 20171131 AND 20180101 
  GROUP BY person_id
  HAVING attendance =3
  ORDER BY attendance DESC 

Villain CTE
WITH CTE AS
(SELECT p.id, p.name, p.license_id, d.*
  FROM drivers_license d
  JOIN person p ON d.id=p.license_id
  WHERE gender = 'female'
  AND car_make = 'Tesla'
  AND car_model = 'Model S'
  AND hair_color = 'red'
)
SELECT fb.*,p.id,p.name, count(person_id) AS attendance
  FROM facebook_event_checkin fb
  JOIN CTE p ON p.id=fb.person_id
  WHERE event_name LIKE '%symphony%'
  AND date BETWEEN 20171131 AND 20180101 
  GROUP BY person_id
  HAVING attendance =3
  ORDER BY attendance DESC 
--Event Check
SELECT *, count(person_id) AS attendance
  FROM facebook_event_checkin
  WHERE event_name like '%symphony%'
  AND date between 20171131 and 20180101 
  GROUP BY person_id
  HAVING attendance =3
  ORDER BY attendance desc 

Villain CTE
WITH CTE AS
(SELECT p.id, p.name, p.license_id, d.*
  FROM drivers_license d
  JOIN person p on d.id=p.license_id
  WHERE gender = 'female'
  AND car_make = 'Tesla'
  AND car_model = 'Model S'
  AND hair_color = 'red'
)
SELECT fb.*,p.id,p.name, count(person_id) AS attendance
  FROM facebook_event_checkin fb
  JOIN CTE p on p.id=fb.person_id
  where event_name like '%symphony%'
  AND date between 20171131 and 20180101 
  GROUP BY person_id
  HAVING attendance =3
  ORDER BY attendance desc 
