ADD JAR /opt/mapr/hive/hive-2.1/hcatalog/share/hcatalog/hive-hcatalog-core-2.1.1-mapr-1803.jar;

DROP TABLE IF EXISTS stage;

CREATE EXTERNAL TABLE stage(
review_id string COMMENT 'Review ID',
user_id string COMMENT 'Reviewing User ID',
business_id string COMMENT 'Business ID',
stars float COMMENT 'Stars Rating',
`date` string COMMENT 'Review Date - String',
text string COMMENT 'Review Text',
useful int COMMENT 'Useful',
funny int COMMENT 'Funny',
cool int COMMENT 'Cool')
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

LOAD DATA INPATH '/demo-files/review.json' into table stage;

DROP TABLE IF EXISTS yelp_review;

CREATE TABLE yelp_review(
review_id string COMMENT 'Review ID',
user_id string COMMENT 'Reviewing User ID',
business_id string COMMENT 'Business ID',
stars float COMMENT 'Stars Rating',
r_date date COMMENT 'Review Date',
text string COMMENT 'Review Text',
useful int COMMENT 'Useful',
funny int COMMENT 'Funny',
cool int COMMENT 'Cool')
STORED BY 'org.apache.hadoop.hive.maprdb.json.MapRDBJsonStorageHandler' 
TBLPROPERTIES("maprdb.table.name" = "/demo-tables/review","maprdb.column.id" = "review_id");

INSERT OVERWRITE TABLE yelp_review SELECT review_id, user_id, business_id, stars, cast(`date` as date) r_date, text, useful, funny, cool
FROM stage;

DROP TABLE STAGE;
