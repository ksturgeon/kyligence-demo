DROP TABLE IF EXISTS yelp_business;

CREATE EXTERNAL TABLE yelp_business (
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

DROP TABLE IF EXISTS yelp_user;

CREATE EXTERNAL TABLE yelp_user (
user_id string COMMENT 'User ID',
name string COMMENT 'First Name',
review_count int COMMENT 'Number of Reviews',
yelping_since string COMMENT 'Yelping Since',
friends array<string> COMMENT 'Friends list',
useful int COMMENT 'Useful Reviews',
funny int COMMENT 'Funny Reviews',
cool int COMMENT 'Cool Reviews',
fans int COMMENT 'Fans',
elite array<string> COMMENT 'Elite Reviews',
average_stars float COMMENT 'Average Stars')
STORED BY 'org.apache.hadoop.hive.maprdb.json.MapRDBJsonStorageHandler'
TBLPROPERTIES("maprdb.table.name" = "/demo-tables/user","maprdb.column.id" = "user_id");

ALTER TABLE yelp_user CHANGE yelping_since yelping_since date;

DROP TABLE IF EXISTS yelp_review;

CREATE EXTERNAL TABLE yelp_review (
review_id string COMMENT 'Review ID',
user_id string COMMENT 'Reviewing User ID',
business_id string COMMENT 'Business ID',
stars float COMMENT 'Stars Rating',
`date` string COMMENT 'Review Date',
text string COMMENT 'Review Text',
useful int COMMENT 'Useful',
funny int COMMENT 'Funny',
cool int COMMENT 'Cool')
STORED BY 'org.apache.hadoop.hive.maprdb.json.MapRDBJsonStorageHandler'
TBLPROPERTIES("maprdb.table.name" = "/demo-tables/review","maprdb.column.id" = "review_id");

ALTER TABLE yelp_review CHANGE `date` r_date date;

