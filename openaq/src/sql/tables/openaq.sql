CREATE EXTERNAL TABLE `openaq`(
  `date` struct<utc:string,local:string> COMMENT 'from deserializer',
  `parameter` string COMMENT 'from deserializer',
  `location` string COMMENT 'from deserializer',
  `value` float COMMENT 'from deserializer',
  `unit` string COMMENT 'from deserializer',
  `city` string COMMENT 'from deserializer',
  `attribution` array<struct<name:string,url:string>> COMMENT 'from deserializer',
  `averagingperiod` struct<unit:string,value:float> COMMENT 'from deserializer',
  `coordinates` struct<latitude:float,longitude:float> COMMENT 'from deserializer',
  `country` string COMMENT 'from deserializer',
  `sourcename` string COMMENT 'from deserializer',
  `sourcetype` string COMMENT 'from deserializer',
  `mobile` string COMMENT 'from deserializer')
ROW FORMAT SERDE
  'org.openx.data.jsonserde.JsonSerDe'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://openaq-fetches/realtime-gzipped'
TBLPROPERTIES (
  'transient_lastDdlTime'='1589794902')
