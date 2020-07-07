create or replace view default.openaq_germany_2017_to_now as
select
      date_utc
    , country
    , city
    , location
    , latitude
    , longitude
    , parameter
    , unit
    , value
    , index
    , averagingperiod_value
    , averagingperiod_unit
    , attribution_name
    , attribution_url
    , sourcename
    , sourcetype
    , mobile
from ( select
               date_parse(date.utc, '%Y-%m-%dT%H:%i:%s.%fZ') as date_utc
          -- , date.utc
          -- , date.local
             , country
             , city
             , location
             , coordinates.latitude  as latitude
             , coordinates.longitude as longitude
             , parameter
             , unit
             , value
             , case when parameter = 'pm25' then
                    case when value >= 0  and value <= 10  then '1 Good'
                         when value >  10 and value <= 20  then '2 Fair'
                         when value >  20 and value <= 25  then '3 Moderate'
                         when value >  25 and value <= 50  then '4 Poor'
                         when value >  50 and value <= 75  then '5 Very poor'
                         when value >  75 and value <= 800 then '6 Extremely poor'
                     end
                    when parameter = 'pm10' then
                    case when value >= 0   and value <= 20   then '1 Good'
                         when value >  20  and value <= 40   then '2 Fair'
                         when value >  40  and value <= 50   then '3 Moderate'
                         when value >  50  and value <= 100  then '4 Poor'
                         when value >  100 and value <= 150  then '5 Very poor'
                         when value >  150 and value <= 1200 then '6 Extremely poor'
                     end
                    when parameter = 'no2' then
                    case when value >= 0   and value <= 40   then '1 Good'
                         when value >  40  and value <= 90   then '2 Fair'
                         when value >  90  and value <= 120  then '3 Moderate'
                         when value >  120 and value <= 230  then '4 Poor'
                         when value >  230 and value <= 340  then '5 Very poor'
                         when value >  340 and value <= 1000 then '6 Extremely poor'
                     end
                     when parameter = 'o3' then
                     case when value >= 0   and value <= 50  then '1 Good'
                          when value >  50  and value <= 100 then '2 Fair'
                          when value >  100 and value <= 130 then '3 Moderate'
                          when value >  130 and value <= 240 then '4 Poor'
                          when value >  240 and value <= 380 then '5 Very poor'
                          when value >  380 and value <= 800 then '6 Extremely poor'
                      end
                     when parameter = 'so2' then
                     case when value >= 0   and value <= 100  then '1 Good'
                          when value >  100 and value <= 200  then '2 Fair'
                          when value >  200 and value <= 350  then '3 Moderate'
                          when value >  350 and value <= 500  then '4 Poor'
                          when value >  500 and value <= 750  then '5 Very poor'
                          when value >  750 and value <= 1250 then '6 Extremely poor'
                      end
                 end as index
             , averagingperiod.value as averagingperiod_value
             , averagingperiod.unit  as averagingperiod_unit
             , attribution[1].name   as attribution_name
             , attribution[1].url    as attribution_url
             , sourcename
             , sourcetype
             , mobile
          from default.openaq
         where country = 'DE'
           and date_trunc('day',date_parse(date.utc, '%Y-%m-%dT%H:%i:%s.%fZ')) >= date_parse('2017-01-01T00:00:00.000Z', '%Y-%m-%dT%H:%i:%s.%fZ')
           and (   (parameter = 'pm25' and value between 0 and 800)
                or (parameter = 'pm10' and value between 0 and 1200)
                or (parameter = 'no2'  and value between 0 and 1000)
                or (parameter = 'o3'   and value between 0 and 800)
                or (parameter = 'so2'  and value between 0 and 1250)
             -- or (parameter = 'co')
             -- or (parameter = 'bc')
               )
         ) aq
;
