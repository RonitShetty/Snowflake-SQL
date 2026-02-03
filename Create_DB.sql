create database demo_db;
create schema demo_db.demo_sc;

use database demo_db;
use schema demo_db.demo_sc;
create or replace table emp (
first_name string,
last_name string,
email string,
streetaddress string,
city string,
start_date date
);
