if MAX([parameter]) = 'pm25' then
       if     AVG([value]) >= 0  and AVG([value]) <= 10  then '1 Good'
       elseif AVG([value]) >  10 and AVG([value]) <= 20  then '2 Fair'
       elseif AVG([value]) >  20 and AVG([value]) <= 25  then '3 Moderate'
       elseif AVG([value]) >  25 and AVG([value]) <= 50  then '4 Poor'
       elseif AVG([value]) >  50 and AVG([value]) <= 75  then '5 Very poor'
       elseif AVG([value]) >  75 and AVG([value]) <= 800 then '6 Extremely poor'
       else '99 Error'
       end
elseif MAX([parameter]) = 'pm10' then
       if     AVG([value]) >= 0   and AVG([value]) <= 20   then '1 Good'
       elseif AVG([value]) >  20  and AVG([value]) <= 40   then '2 Fair'
       elseif AVG([value]) >  40  and AVG([value]) <= 50   then '3 Moderate'
       elseif AVG([value]) >  50  and AVG([value]) <= 100  then '4 Poor'
       elseif AVG([value]) >  100 and AVG([value]) <= 150  then '5 Very poor'
       elseif AVG([value]) >  150 and AVG([value]) <= 1200 then '6 Extremely poor'
       else '99 Error'
       end
elseif MAX([parameter]) = 'no2' then
       if     AVG([value]) >= 0   and AVG([value]) <= 40   then '1 Good'
       elseif AVG([value]) >  40  and AVG([value]) <= 90   then '2 Fair'
       elseif AVG([value]) >  90  and AVG([value]) <= 120  then '3 Moderate'
       elseif AVG([value]) >  120 and AVG([value]) <= 230  then '4 Poor'
       elseif AVG([value]) >  230 and AVG([value]) <= 340  then '5 Very poor'
       elseif AVG([value]) >  340 and AVG([value]) <= 1000 then '6 Extremely poor'
       else '99 Error'
       end
elseif MAX([parameter]) = 'o3' then
       if     AVG([value]) >= 0   and AVG([value]) <= 50  then '1 Good'
       elseif AVG([value]) >  50  and AVG([value]) <= 100 then '2 Fair'
       elseif AVG([value]) >  100 and AVG([value]) <= 130 then '3 Moderate'
       elseif AVG([value]) >  130 and AVG([value]) <= 240 then '4 Poor'
       elseif AVG([value]) >  240 and AVG([value]) <= 380 then '5 Very poor'
       elseif AVG([value]) >  380 and AVG([value]) <= 800 then '6 Extremely poor'
       else '99 Error'
       end
elseif MAX([parameter]) = 'so2' then
       if     AVG([value]) >= 0   and AVG([value]) <= 100  then '1 Good'
       elseif AVG([value]) >  100 and AVG([value]) <= 200  then '2 Fair'
       elseif AVG([value]) >  200 and AVG([value]) <= 350  then '3 Moderate'
       elseif AVG([value]) >  350 and AVG([value]) <= 500  then '4 Poor'
       elseif AVG([value]) >  500 and AVG([value]) <= 750  then '5 Very poor'
       elseif AVG([value]) >  750 and AVG([value]) <= 1250 then '6 Extremely poor'
       else '99 Error'
       end
else 'Unknown parameter'
end
