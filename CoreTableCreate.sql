USE Covid19DataVault 
GO

BEGIN TRANSACTION


If NOT exists (select * from sys.tables where name = 'WorldRegion' )
 
CREATE TABLE Core.WorldRegion 
(WorldRegionID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT WorldRegionPK PRIMARY KEY (WorldRegionID)); 


If NOT exists (select * from sys.tables where name = 'WorldSubRegion' )
 
CREATE TABLE Core.WorldSubRegion 
(WorldSubRegionID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT WorldSubRegionPK PRIMARY KEY (WorldSubRegionID)); 


If NOT exists (select * from sys.tables where name = 'Country' )
 
CREATE TABLE Core.Country 
(CountryID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT CountryPK PRIMARY KEY (CountryID)); 


If NOT exists (select * from sys.tables where name = 'CountryRegion' )
 
CREATE TABLE Core.CountryRegion 
(CountryRegionID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT CountryRegionPK PRIMARY KEY (CountryRegionID)); 


If NOT exists (select * from sys.tables where name = 'CountrySubRegion' )
 
CREATE TABLE Core.CountrySubRegion 
(CountrySubRegionID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT CountrySubRegionPK PRIMARY KEY (CountrySubRegionID)); 


If NOT exists (select * from sys.tables where name = 'ProvinceState' )
 
CREATE TABLE Core.ProvinceState 
(ProvinceStateID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT ProvinceStatePK PRIMARY KEY (ProvinceStateID)); 


If NOT exists (select * from sys.tables where name = 'CountyRegion' )
 
CREATE TABLE Core.CountyRegion 
(CountyRegionID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT CountyRegionPK PRIMARY KEY (CountyRegionID)); 


If NOT exists (select * from sys.tables where name = 'County' )
 
CREATE TABLE Core.County 
(CountyID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT CountyPK PRIMARY KEY (CountyID)); 


If NOT exists (select * from sys.tables where name = 'City' )
 
CREATE TABLE Core.City 
(CityID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT CityPK PRIMARY KEY (CityID)); 
  
COMMIT TRANSACTION
