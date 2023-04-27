
CREATE TABLE SOURCE 
(
ID INT NOT NULL,
EMAIL VARCHAR(30),
CLIENT_NAME VARCHAR(30),
PRIMARY KEY (ID)
)
CREATE TABLE TARGET(
ID INT NOT NULL,
EMAIL VARCHAR(30),
CLIENT_NAME VARCHAR(30),
PRIMARY KEY (ID)
)
select * from [dbo].[TARGET];
select * from [dbo].[SOURCE];
INSERT INTO SOURCE VALUES (1,'Vicky@gmail.com','Vicky'),
                          (2,'Dennis@gmail.com','Dennis');
INSERT INTO SOURCE VALUES (3,'John@gmail.com','John');
INSERT INTO SOURCE VALUES (4,'Bob@gmail.com','Bob');
INSERT INTO SOURCE VALUES (5,'Zoe@gmail.com','Zoe');


update [dbo].[SOURCE]
set client_name='TestAgain'
where id=4;
delete from SOURCE where ID=3;


CREATE TYPE TARGET_TYPE AS TABLE(
ID INT NOT NULL,
EMAIL VARCHAR(30),
CLIENT_NAME VARCHAR(30),
PRIMARY KEY (ID)
)


CREATE PROCEDURE upsert_example_video @source_table TARGET_TYPE READONLY
AS
BEGIN
  MERGE [dbo].[TARGET] AS target
  USING @source_table AS source
  ON (target.ID = source.ID)
  WHEN MATCHED THEN
      UPDATE SET EMAIL = source.EMAIL,CLIENT_NAME = source.CLIENT_NAME
  WHEN NOT MATCHED THEN
      INSERT (ID, EMAIL, CLIENT_NAME)
      VALUES (source.ID, source.EMAIL, source.CLIENT_NAME);
END
GO


CREATE PROCEDURE delete_example_video @source_table TARGET_TYPE READONLY
AS
BEGIN
  MERGE [dbo].[TARGET] AS target
  USING @source_table AS source
  ON (target.ID = source.ID)
  WHEN NOT MATCHED BY SOURCE THEN DELETE;
END
GO