CREATE EXTERNAL TABLE `state_boundaries_germany`(
  `state` string COMMENT 'from deserializer',
  `state_boundaries_wkt` string COMMENT 'from deserializer')
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  'separatorChar'='\;')
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://da-demo-maps/openaq/state_boundaries_germany/'
TBLPROPERTIES (
  'classification'='csv')
