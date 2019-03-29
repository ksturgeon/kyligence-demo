ADD JAR /opt/mapr/hive/hive-2.1/hcatalog/share/hcatalog/hive-hcatalog-core-2.1.1-mapr-1803.jar;

DROP TABLE IF EXISTS stage;

CREATE EXTERNAL TABLE stage(
business_id string COMMENT 'Business ID',
name string COMMENT 'Name',
address string COMMENT 'Street Address',
city string COMMENT 'City',
state string COMMENT 'Address State',
postal_code string COMMENT 'Postal Code',
stars long COMMENT 'Stars',
review_count long COMMENT 'num reviews')
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

LOAD DATA INPATH '/demo-files/business.json' into table stage;

DROP TABLE IF EXISTS yelp_business;

CREATE TABLE yelp_business(
business_id string COMMENT 'Business ID',
name string COMMENT 'Name',
address string COMMENT 'Street Address',
city string COMMENT 'City',
state string COMMENT 'Address State',
postal_code string COMMENT 'Postal Code',
stars long COMMENT 'Stars',
review_count long COMMENT 'num reviews')
STORED BY 'org.apache.hadoop.hive.maprdb.json.MapRDBJsonStorageHandler' 
TBLPROPERTIES("maprdb.table.name" = "/demo-tables/business","maprdb.column.id" = "business_id");

INSERT OVERWRITE TABLE yelp_business SELECT business_id, name, address, city, state, postel_code stars review_count
FROM stage;

DROP TABLE STAGE;
