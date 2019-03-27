DROP TABLE IF EXISTS yelp_business;

CREATE EXTERNAL TABLE yelp_business (
business_id string,
address string,
categories array<string>,
city string,
name string,
review_count int,
stars int,
state string)
STORED BY 'org.apache.hadoop.hive.maprdb.json.MapRDBJsonStorageHandler' 
TBLPROPERTIES("maprdb.table.name" = "/demo-tables/business","maprdb.column.id" = "business_id");

DROP TABLE IF EXISTS yelp_user;

CREATE EXTERNAL TABLE yelp_user (
user_id string,
name string,
review_count int,
yelping_since date,
friends array<string>,
useful int,
funny int,
cool int,
fans int,
elite array<string>,
average_stars float)
STORED BY 'org.apache.hadoop.hive.maprdb.json.MapRDBJsonStorageHandler'
TBLPROPERTIES("maprdb.table.name" = "/demo-tables/user","maprdb.column.id" = "user_id");
