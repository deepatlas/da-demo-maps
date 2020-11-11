create or replace view openaq_germany_2017_to_now_for_kepler as
with aq_coordinates as (
     select
            longitude
          , latitude
       from default.openaq_germany_2017_to_now
      group by longitude
             , latitude
)
, aq_states as (
     select
            aq.longitude
          , aq.latitude
          , sb.state
       from aq_coordinates aq
      cross join default.state_boundaries_germany sb
      where st_contains(ST_POLYGON(state_boundaries_wkt), ST_POINT(aq.longitude, aq.latitude))
)
, aq as (
     select
            date_trunc('day',date_utc) as day
          , country
          , city
          , location
          , latitude
          , longitude
          , round(SUM(case when parameter = 'pm25' then value end) / SUM(case when parameter = 'pm25' then 1 else 0 end),2) as pm25_avg_value
          , round(SUM(case when parameter = 'pm10' then value end) / SUM(case when parameter = 'pm10' then 1 else 0 end),2) as pm10_avg_value
          , round(SUM(case when parameter = 'no2'  then value end) / SUM(case when parameter = 'no2'  then 1 else 0 end),2) as no2_avg_value
          , round(SUM(case when parameter = 'o3'   then value end) / SUM(case when parameter = 'o3'   then 1 else 0 end),2) as o3_avg_value
          , round(SUM(case when parameter = 'so2'  then value end) / SUM(case when parameter = 'so2'  then 1 else 0 end),2) as so2_avg_value
          , averagingperiod_value
          , averagingperiod_unit
          , attribution_name
          , attribution_url
          , sourcename
          , sourcetype
          , mobile
       from default.openaq_germany_2017_to_now
      group by date_trunc('day',date_utc)
             , country
             , city
             , location
             , latitude
             , longitude
             , averagingperiod_value
             , averagingperiod_unit
             , attribution_name
             , attribution_url
             , sourcename
             , sourcetype
             , mobile
)
select
       day
     , country
  -- , city
     , aqs.state
     , location
     , aq.latitude
     , aq.longitude

     , pm25_avg_value
     , case when pm25_avg_value >= 0  and pm25_avg_value <= 10  then '1 Good'
            when pm25_avg_value >  10 and pm25_avg_value <= 20  then '2 Fair'
            when pm25_avg_value >  20 and pm25_avg_value <= 25  then '3 Moderate'
            when pm25_avg_value >  25 and pm25_avg_value <= 50  then '4 Poor'
            when pm25_avg_value >  50 and pm25_avg_value <= 75  then '5 Very poor'
            when pm25_avg_value >  75 and pm25_avg_value <= 800 then '6 Extremely poor'
        end as pm25_avg_index

     , pm10_avg_value
     , case when pm10_avg_value >= 0   and pm10_avg_value <= 20   then '1 Good'
            when pm10_avg_value >  20  and pm10_avg_value <= 40   then '2 Fair'
            when pm10_avg_value >  40  and pm10_avg_value <= 50   then '3 Moderate'
            when pm10_avg_value >  50  and pm10_avg_value <= 100  then '4 Poor'
            when pm10_avg_value >  100 and pm10_avg_value <= 150  then '5 Very poor'
            when pm10_avg_value >  150 and pm10_avg_value <= 1200 then '6 Extremely poor'
        end as pm10_avg_index

     , no2_avg_value
     , case when no2_avg_value >= 0   and no2_avg_value <= 40   then '1 Good'
            when no2_avg_value >  40  and no2_avg_value <= 90   then '2 Fair'
            when no2_avg_value >  90  and no2_avg_value <= 120  then '3 Moderate'
            when no2_avg_value >  120 and no2_avg_value <= 230  then '4 Poor'
            when no2_avg_value >  230 and no2_avg_value <= 340  then '5 Very poor'
            when no2_avg_value >  340 and no2_avg_value <= 1000 then '6 Extremely poor'
        end as no2_avg_index

     , o3_avg_value
     , case when o3_avg_value >= 0   and o3_avg_value <= 50  then '1 Good'
            when o3_avg_value >  50  and o3_avg_value <= 100 then '2 Fair'
            when o3_avg_value >  100 and o3_avg_value <= 130 then '3 Moderate'
            when o3_avg_value >  130 and o3_avg_value <= 240 then '4 Poor'
            when o3_avg_value >  240 and o3_avg_value <= 380 then '5 Very poor'
            when o3_avg_value >  380 and o3_avg_value <= 800 then '6 Extremely poor'
        end as o3_avg_index

     , so2_avg_value
     , case when so2_avg_value >= 0   and so2_avg_value <= 100  then '1 Good'
            when so2_avg_value >  100 and so2_avg_value <= 200  then '2 Fair'
            when so2_avg_value >  200 and so2_avg_value <= 350  then '3 Moderate'
            when so2_avg_value >  350 and so2_avg_value <= 500  then '4 Poor'
            when so2_avg_value >  500 and so2_avg_value <= 750  then '5 Very poor'
            when so2_avg_value >  750 and so2_avg_value <= 1250 then '6 Extremely poor'
        end as so2_avg_index

     , averagingperiod_value
     , averagingperiod_unit
     , attribution_name
     , attribution_url
     , sourcename
     , sourcetype
     , mobile

  from aq
  join aq_states aqs
    on aq.longitude = aqs.longitude and aq.latitude = aqs.latitude;
