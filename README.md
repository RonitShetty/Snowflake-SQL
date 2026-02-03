# ❄️ Snowflake Employee Data Analysis

This project demonstrates a complete Data Warehousing workflow using **Snowflake**. It covers the end-to-end process of setting up a cloud database, loading semi-structured CSV data (from local storage and Azure Blob Storage), and performing analytical queries to derive insights about employee hiring trends and demographics.

## 📂 Project Structure

The repository contains the following SQL scripts:

* **`Create_DB.sql`**
    * Initial setup script to initialize the Database (`demo_db`), Schema (`demo_sc`), and the primary target Table (`emp`).
* **`load_to_azure.sql`**
    * Configures a **Storage Integration** to connect Snowflake securely with Microsoft Azure Blob Storage.
    * Sets up an **External Stage** (`azure_int`) for cloud-based data loading.
* **`Verifying_Data_Load.sql`**
    * Quality assurance queries to validate record counts (`COUNT(*)`), check for nulls, and preview data after the initial load.
* **`Basic_Queries.sql`**
    * Fundamental SQL operations including filtering (`WHERE`), sorting (`ORDER BY`), and basic aggregations (`GROUP BY`) to explore the dataset.
* **`Temporary_Table_Queries.sql`**
    * Advanced session-based analysis using **Temporary Tables**.
    * Includes logic for email domain extraction, tenure calculations (`DATEDIFF`), and conditional labeling (Veteran vs. Newcomer).
* **`Monthwise_Hires.sql`**
    * Targeted analytical script to visualize hiring spikes by month and year.

## 🚀 Getting Started

### Prerequisites
* A valid **Snowflake Account** (Trial or Standard).
* **SnowSQL** CLI (optional) or access to the **Snowsight** Web Interface.
* Employee Data CSV files (`employees01.csv` - `employees05.csv`).

### Installation & Run Order

1.  **Setup Database:** Run `Create_DB.sql` to initialize your environment.
2.  **Load Data:**
    * *Option A (Cloud):* Use `load_to_azure.sql` if your files are hosted on Azure.
    * *Option B (Local):* Use the Web UI or SnowSQL `PUT` command to load the CSVs into the internal stage.
3.  **Verify:** Run `Verifying_Data_Load.sql` to ensure data integrity.
4.  **Analyze:** Execute `Basic_Queries.sql` and `Temporary_Table_Queries.sql` to generate insights.

## 📸 Screenshots & Output
[📄 View Project Screenshots (PDF)](./Project_Screenshots.pdf)
## 🛠️ Technologies Used
* **Snowflake Data Cloud**
* **SQL (ANSI Standard + Snowflake Extensions)**
* **Microsoft Azure Blob Storage** (Integration)

---
*Created by Ronit Shetty*
