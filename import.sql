DROP TABLE IF EXISTS `admin1CodesAscii`;

CREATE TABLE `admin1CodesAscii` (
  `code` char(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` text COLLATE utf8_unicode_ci,
  `nameAscii` text COLLATE utf8_unicode_ci,
  `geonameid` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `countryinfo`;

CREATE TABLE `countryinfo` (
  `iso_alpha2` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `iso_alpha3` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso_numeric` int(11) DEFAULT NULL,
  `fips_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `capital` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `areainsqkm` double DEFAULT NULL,
  `population` int(11) DEFAULT NULL,
  `continent` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tld` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currencyName` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Phone` char(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postalCodeFormat` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postalCodeRegex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geonameId` int(11) DEFAULT NULL,
  `languages` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `neighbours` char(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `equivalentFipsCode` char(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`iso_alpha2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `geoname`;

CREATE TABLE `geoname` (
  `geonameid` int(11) unsigned NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asciiname` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alternatenames` varchar(4000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `fclass` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fcode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc2` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin1` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin2` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin3` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin4` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `population` int(11) DEFAULT NULL,
  `elevation` int(11) DEFAULT NULL,
  `gtopo30` int(11) DEFAULT NULL,
  `timezone` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `moddate` date DEFAULT NULL,
  PRIMARY KEY (`geonameid`),
  KEY `country` (`country`),
  KEY `admin1` (`admin1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


LOAD DATA LOCAL INFILE 'US.txt'
INTO TABLE geoname
CHARACTER SET 'UTF8'
(geonameid, name, asciiname, alternatenames, latitude, longitude, fclass, fcode, country, cc2, admin1, admin2, admin3, admin4, population, elevation, gtopo30, timezone, moddate);

LOAD DATA LOCAL INFILE 'CA.txt'
INTO TABLE geoname
CHARACTER SET 'UTF8'
(geonameid, name, asciiname, alternatenames, latitude, longitude, fclass, fcode, country, cc2, admin1, admin2, admin3, admin4, population, elevation, gtopo30, timezone, moddate);

LOAD DATA LOCAL INFILE 'admin1CodesASCII.txt'
INTO TABLE admin1CodesAscii
CHARACTER SET 'UTF8'
(code, name, nameAscii, geonameid);

LOAD DATA LOCAL INFILE 'countryInfo.txt'
INTO TABLE countryinfo
CHARACTER SET 'UTF8'
IGNORE 51 LINES
(iso_alpha2, iso_alpha3, iso_numeric, fips_code, name, capital, areaInSqKm, population, continent, tld, currency, currencyName, phone, postalCodeFormat, postalCodeRegex, languages, geonameid, neighbours, equivalentFipsCode);

delete from geoname where population < 5000;
delete from geoname where fclass != 'P';