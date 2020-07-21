# Air quality data visualizations
Air quality data visualizations with kepler.gl and Tableau

## Data

### Data sources
* source 1) **air quality**: https://registry.opendata.aws/openaq/  
* source 2) **german state geometries** (help data): https://public.opendatasoft.com/explore/dataset/bundesland/table/

### Data considerations and transformations

#### Air quality index info
Source: https://www.eea.europa.eu/themes/air/air-quality-index
![](openaq/info/air_quality_index_by_eea.png)

#### AWS Glue/Athena tables and views
* **default.openaq** table:  
  is linked to s3://openaq-fetches/realtime-gzipped AWS S3 bucket (source 1)) and contains realtime gzipped data in ndjson.gz format.

* **default.state_boundaries_germany** table:  
  contains german state geometries in WKT format. To get geometries in WKT format original file downloaded from source 2) was processed by https://geojson.io/.

* **default.openaq_germany_2017_to_now** view:  
  is based on default.openaq table and contains data for:
  * country = 'DE';
  * from 2017-01-01 till now;
  * pm25, pm10, no2, o3, so2 parameters only;
  * parameter values are >=0 and less than allowed values (see table above). All other values are treated as error ones.

* **default.openaq_germany_2017_to_now_for_kepler** view:  
  is based on default.openaq_germany_2017_to_now view and contains data prepared for kepler.gl:
  * data is grouped by day, country, city, location, latitude, longitude, averagingperiod_value, averagingperiod_unit, attribution_name, attribution_url, sourcename, sourcetype, mobile;
  * there are 10 new calculated columns per row (2 columns for each parameter): '{parameter}_avg_value' and '{parameter}_avg_index' (calculated as per table above).

* **default.openaq_germany_2017_to_now_for_tableau** view:  
  is based on default.openaq_germany_2017_to_now view and default.state_boundaries_germany table and contains data prepared for Tableau:
  * there is a new calculated column 'state' which points to federal state where combination of latitude and longitude belongs to.

## Visualization tools
  * kepler.gl: https://kepler.gl/
  * Tableau: https://www.tableau.com/

### kepler.gl visualization
Example can be found here (in public access): https://da-demo-maps.s3-eu-west-1.amazonaws.com/openaq/kepler/maps/openaq_germany.json

#### Steps

**1) Get data:**  
  In AWS Athena run the following query: ```select * from default.openaq_germany_2017_to_now_for_kepler;```

**2) Save result data as .csv**  

**3) Load data in kepler.gl**

**4) Customize map ([config screenshots](openaq/viz-tools/kepler/config/)):**
* Filters:
  * day
* Layers:
  * layer per parameter
  * Type: Point
  * Fill color:
    * Steps: 6
    * Custom palette: #1A9850 #91CF60 #FEE08B #FC8D59 #D73027 #861606
    * Color based on: '{parameter}_avg_index'
* Map general settings:
   * Dual map view
   * Show layer panel
   * Show legend

#### Screenshots
NO2 vs PM25:
![NO2 vs PM25](openaq/viz-tools/kepler/screenshots/openaq_germany_kepler1_no2_vs_pm25.png)

NO2 vs PM10:
![NO2 vs PM10](openaq/viz-tools/kepler/screenshots/openaq_germany_kepler2_no2_vs_pm10.png)

PM10 vs PM25:
![PM10 vs PM25](openaq/viz-tools/kepler/screenshots/openaq_germany_kepler3_pm10_vs_pm25.png)

### Tableau visualization
Tableau example can be found here: https://da-demo-maps.s3-eu-west-1.amazonaws.com/openaq/tableau/config/openaq_germany.twbx

For creating/editing visualizations Tableau Desktop app was used.  
For reading Tableau Reader app can be used.

#### Steps

**1) Get data:**  
  In AWS Athena run the following query: ```select * from default.openaq_germany_2017_to_now_for_tableau;```

**2) Save result data as .csv**  

**3) Load data in Tableau:**  
Tableau Desktop application is used.

**4) Create visualizations:**
* add a new calculated field [avg_index](openaq/viz-tools/tableau/config/calculated%20fields)
* add filters
* add marks

There are 4 tabs:
* 1 map view;
* 3 table views.

#### Screenshots
![](openaq/viz-tools/tableau/screenshots/openaq_germany_tableau1.png)

![](openaq/viz-tools/tableau/screenshots/openaq_germany_tableau2.png)

![](openaq/viz-tools/tableau/screenshots/openaq_germany_tableau3.png)

![](openaq/viz-tools/tableau/screenshots/openaq_germany_tableau4.png)
