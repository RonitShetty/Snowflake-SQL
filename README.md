# ❄️ Snowflake Enterprise Data Pipeline & Analytics

![Snowflake](https://img.shields.io/badge/Snowflake-Data_Cloud-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-Blob_Storage-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Advanced-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![ThoughtSpot](https://img.shields.io/badge/ThoughtSpot-BI_&_Analytics-F38B00?style=for-the-badge)

> **A production-ready Data Engineering project showcasing a Medallion Architecture (Bronze/Silver/Gold), automated ELT pipelines, SCD Type 2 historical tracking, and self-service BI integration.**

---

## 🏗️ Architecture Overview

This project simulates a real-world enterprise data environment. It ingests raw data from **Azure Blob Storage** and **CSVs**, processes it through a multi-layered pipeline using **Snowflake Stored Procedures**, and serves insights via **ThoughtSpot**.

```mermaid
graph LR
    A[Azure Blob / CSVs] -->|Ingest| B(Bronze Layer - Raw)
    B -->|Clean & Dedupe| C(Silver Layer - Clean)
    C -->|SCD Type 2 Logic| D(Gold Layer - Curated)
    D -->|Visualize| E[ThoughtSpot / SQL Analytics]
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#e1f5fe,stroke:#29B5E8
    style C fill:#f3e5f5,stroke:#9c27b0
    style D fill:#fff9c4,stroke:#fbc02d
    style E fill:#e0f2f1,stroke:#009688

```

---

## 📂 Repository Contents

This repository contains **17 SQL scripts** organizing the end-to-end workflow, from infrastructure setup to advanced governance.

### 1️⃣ Infrastructure & Configuration

| File Name | Description |
| --- | --- |
| **`Connecting_Azure_Data_Stages.sql`** | ☁️ **Azure Integration:** Configures Storage Integrations, External Stages, and schemas (Bronze/Silver/Gold). |
| **`Create_DB.sql`** | 🏗️ **Database Setup:** Initial script creating `DEMO_DB` and the `EMP` table for CSV ingestion. |
| **`Titanic_Table_Creation.sql`** | ⚙️ **Parquet Config:** Defines the `TITANIC` schema and custom `PARQUET` file formats. |
| **`load_to_azure.sql`** | 🔌 **Legacy Config:** Initial Azure integration setup (kept for reference on storage policies). |

### 2️⃣ Ingestion (Bronze Layer)

| File Name | Description |
| --- | --- |
| **`Titanic_manual_load.sql`** | 📥 **ELT Ingestion:** Loads raw Parquet data into staging, parsing variant columns (e.g., `$1:Age`) on-the-fly. |
| **`Verifying_Data_Load.sql`** | ✅ **Quality Assurance:** Immediate row count checks and data integrity verification post-load. |

### 3️⃣ Transformation (Silver Layer)

| File Name | Description |
| --- | --- |
| **`sp_load_silver_titanic.sql`** | 🤖 **Stored Procedure:** Automates cleaning, casting, and deduplication (using `QUALIFY ROW_NUMBER`). |

### 4️⃣ Dimensional Modeling (Gold Layer)

| File Name | Description |
| --- | --- |
| **`SCD2.sql`** | 📐 **DDL:** Defines the `dim_passenger_scd2` table structure for Slowly Changing Dimensions. |
| **`sp_load_dim_passenger_scd2.sql`** | 🔄 **SCD Type 2 Logic:** Complex Stored Procedure using **Hash Diffs** to detect changes and track history (`effective_start/end_date`). |
| **`Data_Analysis.sql`** | 📊 **Reporting Marts:** Aggregates data for BI (e.g., `survival_by_age_group`, `survival_by_class`). |

### 5️⃣ Orchestration

| File Name | Description |
| --- | --- |
| **`Call_Procs.sql`** | 🚀 **Pipeline Trigger:** Single entry point to execute the Silver and Gold stored procedures sequentially. |

### 6️⃣ Advanced Analytics (Ad-Hoc)

| File Name | Description |
| --- | --- |
| **`Titanic_Queries.sql`** | 🚢 **Deep Dive:** Analytical queries on survival rates, demographics, and class privileges. |
| **`Basic_Queries.sql`** | 🔎 **Employee Stats:** Fundamental filtering, sorting, and aggregation on the Employee dataset. |
| **`Temporary_Table_Queries.sql`** | 🧪 **Session Analysis:** Uses Temporary Tables for complex text parsing (Email domains) and tenure calculations. |
| **`Monthwise_Hires.sql`** | 📅 **Time Series:** Reporting query to analyze hiring trends specifically for the year 2017. |

### 7️⃣ Data Governance & DevOps

| File Name | Description |
| --- | --- |
| **`Zero_Copy_Cloning.sql`** | 🐑 **Cloning:** Creates instant "Sandbox" environments for safe testing without data duplication. |
| **`Time_Travel.sql`** | ⏳ **Disaster Recovery:** Demonstrates restoring dropped tables or deleted rows using `AT(TIMESTAMP)` and `UNDROP`. |

---

## 📸 Screenshots & Output
[📄 View Project Screenshots (PDF)](./Project_Summary_&_Screenshots.pdf)

---
## 🌟 Key Highlights

### 🚄 Automation

* **Stored Procedures:** All transformation logic is encapsulated in SQL-based Stored Procedures.
* **Orchestration:** The entire pipeline from Silver to Gold can be refreshed with two simple `CALL` commands.

### 🧠 Advanced Modeling

* **SCD Type 2:** Implemented full history tracking. If a passenger's record changes, the old record is expired, and a new active record is inserted.
* **Hash Diffing:** Uses `HASH(col1, col2...)` to efficiently detect changes in large datasets without full row comparisons.

### 🛡️ Governance & Safety

* **Zero Copy Cloning:** Enables specific "Dev/Test" branches of the database in seconds.
* **Time Travel:** Provides a safety net allowing the database to be queried as it existed in the past (up to 90 days).

## 🛠️ Tech Stack

* **Snowflake Data Cloud** (Warehousing, Compute, Governance)
* **SQL** (Transformation, DDL, DML)
* **Microsoft Azure** (Blob Storage Integration)
* **ThoughtSpot** (Business Intelligence & Visualization)

---

*Created by Ronit Shetty*

```

```
