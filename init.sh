#!/bin/bash

dbhost="127.0.0.1"
dbport=33060
dbname="geonames"
dbusername="root"
dbpassword="secret"

rm -f admin1CodesASCII.txt CA.txt US.txt
wget http://download.geonames.org/export/dump/admin1CodesASCII.txt
wget http://download.geonames.org/export/dump/CA.zip
wget http://download.geonames.org/export/dump/US.zip
wget http://download.geonames.org/export/dump/countryInfo.txt
unzip CA.zip && rm CA.zip
unzip US.zip && rm US.zip


echo "Dropping tables if exist,  create tables for database $dbname... then import."
mysql -h$dbhost -P$dbport -u$dbusername -p$dbpassword $dbname < import.sql