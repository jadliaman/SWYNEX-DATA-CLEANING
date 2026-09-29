# SWYNEX Cafe Sales Data Cleaning Project

## Project Overview

This project focuses on cleaning and preparing a public Cafe Sales dataset using MySQL.

## Dataset

* Dataset -> Cafe Sales
* Original rows -> 9,006
* Tool used -> MySQL Workbench

## Data Quality Issues Identified

The dataset contained:

* Missing/blank values
* `ERROR` and `UNKNOWN` values
* Duplicate Transaction IDs were checked
* Incorrect data types
* Potential inconsistencies between Quantity, Price per unit, and Total Spent

## Cleaning Performed

* Converted blank, `ERROR`, and `UNKNOWN` values to `NULL`
* Checked for duplicate Transaction IDs
* Verified that `Total Spent` matched `Quantity × Price per unit`
* Changed `Total Spent` from `TEXT` to `DECIMAL(10,2)`
* Changed `Transaction Date` from `TEXT` to `DATE`
* Preserved the original raw table and created a separate cleaned table

## Final Result

* Cleaned dataset contains 9,006 rows
* No remaining `ERROR` or `UNKNOWN` values
* Original raw data was preserved
* Cleaned dataset was exported as a CSV file

## Files

* `cafe_sales_cleaning.sql` — SQL queries used for data cleaning
* `cafe_sales_cleaned.csv` — cleaned dataset
* `README.md` — project documentation
