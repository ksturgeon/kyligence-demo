ADD JAR /opt/mapr/hive/hive-2.1/hcatalog/share/hcatalog/hive-hcatalog-core-2.1.1-mapr-1803.jar;

DROP TABLE IF EXISTS stage;

CREATE EXTERNAL TABLE stage(
business_id string COMMENT 'Business ID',
address string COMMENT 'Street Address',
categories array<string> COMMENT 'Business categories',
city string COMMENT 'Address City',
name string COMMENT 'Business Name',
review_count int COMMENT 'Number of reviews',
stars float COMMENT 'stars rating',
state string COMMENT 'Address State',
postal_code string COMMENT 'Address Postal Code')
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

LOAD DATA INPATH '/demo-files/business.json' into table stage;

DROP TABLE IF EXISTS yelp_business;

CREATE TABLE yelp_business(
business_id string COMMENT 'Business ID',
address string COMMENT 'Street Address',
categories array<string> COMMENT 'Business categories',
city string COMMENT 'Address City',
name string COMMENT 'Business Name',
review_count int COMMENT 'Number of reviews',
stars float COMMENT 'stars rating',
state string COMMENT 'Address State',
postal_code string COMMENT 'Address Postal Code')
STORED BY 'org.apache.hadoop.hive.maprdb.json.MapRDBJsonStorageHandler' 
TBLPROPERTIES("maprdb.table.name" = "/demo-tables/business","maprdb.column.id" = "business_id");

INSERT OVERWRITE TABLE yelp_review SELECT business_id, address, categories, city, name, review_count, stars, state, postal_code
FROM stage;

DROP TABLE STAGE;
