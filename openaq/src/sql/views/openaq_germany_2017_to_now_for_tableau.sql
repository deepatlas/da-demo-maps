create or replace view default.openaq_germany_2017_to_now_for_tableau as
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
select
        aq.day
      , aq.country
      , aqs.state
      , aq.location
      , aq.latitude
      , aq.longitude
      , aq.parameter
      , aq.unit
      , aq.value
      , aq.index
      , aq.averagingperiod_value
      , aq.averagingperiod_unit
      , aq.attribution_name
      , aq.attribution_url
      , aq.sourcename
      , aq.sourcetype
      , aq.mobile
  from default.openaq_germany_2017_to_now aq
  join aq_states aqs
    on aq.longitude = aqs.longitude and aq.latitude = aqs.latitude;
