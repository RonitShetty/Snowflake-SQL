# ❄️ Snowflake Employee Data Analysis

This repository demonstrates enterprise-grade data engineering patterns in **Snowflake Data Cloud**. It showcases two specific workflows: handling multi-part **CSV** uploads for employee records and performing ELT (Extract, Load, Transform) on **Parquet** files for complex analytics.

## 📂 Repository Structure

| File Name | Description |
| :--- | :--- |
| **`Create_DB.sql`** | Initial setup script to create the `DEMO_DB` database, `DEMO_SC` schema, and the `EMP` table structured for CSV loading. |
| **`load_to_azure.sql`** | Configures a Storage Integration (`azure_int`) to connect Snowflake securely with Azure Blob Storage. |
| **`Titanic_Table_Creation.sql`** | Sets up the Titanic environment, including a custom `PARQUET` file format and the primary table schema. |
| **`Titanic_manual_load.sql`** | Demonstrates loading binary **Parquet** data into a staging table using variant parsing (`$1`) and creating a simplified View. |
| **`Titanic_Queries.sql`** | Analytical queries on the Titanic dataset (Survival rates, Class analysis, etc.). |
| **`Basic_Queries.sql`** | Fundamental SQL operations on the Employee table (Filtering, Sorting, Aggregation). |
| **`Temporary_Table_Queries.sql`** | Advanced analysis using **Temporary Tables**, including email domain parsing and tenure calculation. |
| **`Monthwise_Hires.sql`** | Reporting query to analyze hiring trends by month for 2017. |
| **`Verifying_Data_Load.sql`** | Quality assurance scripts to verify row counts and data integrity. |

## 📊 Datasets & Formats

### 1. Employee Data (CSV)
* **Source Format:** **CSV** (Comma Separated Values)
* **File Structure:** Split across 5 separate files (`employees01.csv` – `employees05.csv`).
* **Target Table:** `DEMO_DB.DEMO_SC.EMP`
* **Schema:** `first_name`, `last_name`, `email`, `streetaddress`, `city`, `start_date`.
* **Workflow:** These 5 CSV files are loaded into the standard relational `EMP` table for unified analysis.

### 2. Titanic Data (Parquet)
* **Source Format:** **Parquet** (Columnar Storage)
* **File Name:** `titanic.parquet`
* **Target Table:** `DEMO_DB.DEMO_SC.TITANIC` (and `TITANIC_RAW`)
* **Workflow:** Loaded using a specialized Parquet file format (`my_parquet_format`). The load process transforms the raw data on-the-fly (e.g., casting `$1:Survived` integers to booleans).

## 🚀 Key Features

### 1. Mixed-Format Ingestion
* **Structured (CSV):** Handling standard structured data imports for the Employee roster.
* **Semi-Structured (Parquet):** utilizing Snowflake's variant syntax (`$1:Key`) to parse binary files directly into tables.

### 2. Analytics & Reporting
* **Date & Time:** Calculating employment tenure with `DATEDIFF` and analyzing hiring trends by `MONTHNAME`.
* **Text Processing:** parsing email domains using `SPLIT_PART` and handling address wildcards.
* **Statistical Analysis:** Aggregating survival rates, average fares, and age demographics.

## 🛠️ Usage Guide

1.  **Setup:** Run `Create_DB.sql` to initialize the database and `EMP` table.
2.  **Connections:** Run `load_to_azure.sql` to link your Azure Blob Storage.
3.  **Data Loading:**
    * **Employees:** Load the 5 CSV files into the `EMP` table using standard CSV file formats.
    * **Titanic:** Run `Titanic_Table_Creation.sql` to define the Parquet format, then `Titanic_manual_load.sql` to ingest the Parquet file.
4.  **Analysis:** Run the various `*_Queries.sql` files to generate insights.


## 📸 Screenshots & Output
[📄 View Project Screenshots (PDF)](./Project_Summary_&_Screenshots.pdf)

## 🛠️ Technologies Used
* **Snowflake Data Cloud**
* **SQL (ANSI Standard + Snowflake Extensions)**
* **Microsoft Azure Blob Storage** (Integration)

---
*Created by Ronit Shetty*
