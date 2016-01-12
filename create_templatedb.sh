#!/bin/bash
# @author Max Pittore <pittore@gfz-potsdam.de>
#requires postgresql >=9.2

#create database and extensions
createdb $1
echo 'create extension postgis; create extension postgis_topology; create extension hstore; create extension tablefunc' | psql $1

#create schemas
psql $1 -f ./taxonomy.sql
psql $1 -f ./survey.sql
psql $1 -f ./asset.sql
psql $1 -f ./image.sql
