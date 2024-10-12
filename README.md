
# Formula1 Azure Databricks Incremental Data Project (Formula 1 Races Data)

## Overview
This project showcases an end-to-end data pipeline built using Azure Databricks and Azure Data Factory to handle incremental loads of Formula 1 race data. The pipeline processes raw data from Azure Data Lake Gen 2, transforming it across three data layers (Bronze, Silver, Gold), and then connects to Power BI for visualization.

The primary goal of this project is to demonstrate skills in data engineering and pipeline orchestration on Azure, focusing on transforming raw data into insightful reports via incremental processing.

## Architecture

![Project Architecture](https://github.com/nandan2003/Databricks-Formula1-Project/blob/main/Databricks%20%26%20Power%20BI%20Images/Project%20Architecture.jpeg)

- Raw (Bronze Layer): Stores raw, unprocessed data.
- Processed (Silver Layer): Cleansed and transformed data for further analysis.
- Presentation (Gold Layer): Final structured data tables, optimized for enterprise reporting and analytics.

The pipeline is scheduled to run periodically (weekly), handling new incoming data efficiently through Azure Data Factory triggers and pipelines. The final visualizations are available in Power BI, connected directly to the gold layer.

## Tech Stack
- Azure Databricks: Data transformation and processing.
- Azure Data Factory: Pipeline orchestration and scheduling.
- Azure Data Lake Gen 2: Storage for raw, processed, and presentation data.
- Azure Key Vault: Secure storage for secrets and credentials.
- Python & SQL: Used in Databricks notebooks for data transformations.
- Power BI: Visualization and reporting.

## Project Workflow

1. Data Ingestion (Bronze Layer): 
   - Raw data (Formula 1 races data) is stored in the bronze container of Azure Data Lake.
   - The raw data is ingested into Databricks via a mounted Azure Data Lake Gen 2 container.

2. Data Transformation (Silver Layer): 
   - The raw data is cleaned and transformed into usable formats (e.g., Parquet, Delta Lake).
   - The transformed data is stored in the silver container.

3. Data Structuring (Gold Layer): 
   - The cleansed and transformed data is further processed into structured tables designed for reporting purposes.
   - These tables are saved in the gold container and connected to Power BI.

4. Orchestration (Azure Data Factory):
   - Pipelines and triggers are set up in Azure Data Factory to automate data movement and transformation at regular intervals.
   - The pipeline runs weekly to ingest and process new data incrementally.

5. Visualization (Power BI):
   - The gold data layer is connected to Power BI, providing insightful visualizations such as race results, driver standings, and lap performance trends.
   - Power BI can pull live data from the gold container for real-time reporting.
   - The visualizations included in this project are solely for demonstrating the workflow, as the primary focus is on building the data pipeline, not on creating in-depth visualizations.

## Getting Started

### Prerequisites

To run this project, you need:

- Azure Subscription (for Databricks, Data Factory, Data Lake Gen 2, Key Vault, etc.)
- Azure Databricks Workspace
- Azure Data Factory with proper permissions
- Power BI Desktop or Service account

### Setup Instructions

1. Clone the Repository:
   ```bash
   gh repo clone nandan2003/Databricks-Formula1-Project
   ```

2. Setup Azure Data Lake Gen 2:
   - Create the raw, processed and presentation containers.
   - Upload all the unprocessed files into the raw container.
  
3. Azure App Registration:
   - Create a new App Registration in Azure portal.
   - Create a new client secret. Store the Client ID, Client Secret and Tenant ID in Azure Key Vault.
  
4. Scope in Databricks:
   - Create a Scope in Databricks workspace. The scope is created by adding `#secrets/createScope` at the end of Databricks homepage URL.
   - A scope name, Azure Key Vault DNS name and Resourse ID should be given to create a scope.

5. Setup Databricks Notebooks:
   - Mount the Azure Data Lake Gen 2 containers (Bronze, Silver, and Gold) using the provided `set-up/mount_adls_storage.ipynb`.
   - Run `utils/prepare_for_incremental_load.sql` to drop all databases if exists including all tables and creates new database.
   - Run `raw/create_raw_tables.sql` to create tables in raw database.
   - Run the provided Jupyter Notebooks in `ingestion` and `trans` your Databricks workspace for data transformation.
   
6. Setup Azure Data Factory:
   - Import the ADF Pipelines JSON from the `ADF Pipeline Files` folder.
   - Create a trigger to run the pipeline at your preferred interval (e.g., weekly).

4. Connect to Power BI:
   - Databricks can be connected to Power BI through the hive_metastore database in Databricks.
   
### Project Structure

```plaintext
├── set-up
│   ├── mount_adls_storage.ipynb           # Data Lake containers mount in Databricks
├── utils
│   ├── prepare_for_incremental_load.sql   # Dropping and Creating database
├── raw
│   ├── create_raw_tables.sql              # Creates tables in Processed database
├── includes
│   ├── configuration.ipynb                # Creating variables to mounted path
│   ├── common_functions.ipynb             # Functions to use in ingestion and Trans notebooks
├── ingestion
│   ├── 0.ingest_all_files.ipynb           # Runs 1 to 8 files
│   ├── 1.ingest_circuits_files.ipynb      # Runs circuits file
│   ├── 2.ingest_races_files.ipynb         # Runs races file
│   ├── 3.ingest_constructors_files.ipynb  # Runs constructors file
│   ├── 4.ingest_drivers_files.ipynb       # Runs drivers file
│   ├── 5.ingest_results_files.ipynb       # Runs results file
│   ├── 6.ingest_pit_stops_files.ipynb     # Runs pit stops file
│   ├── 7.ingest_lap_times_files.ipynb     # Runs lap times file
│   ├── 8.ingest_qualifying_files.ipynb    # Runs qualifying file
├── Trans                                  # Files loaded from processed and transformed according to industry purposes
│   ├── 1.race_results.ipynb             
│   ├── 2.driver_standings.ipynb             
│   ├── 3.constructor_standings.ipynb             
│   ├── 4.calculated_race_results.ipynb             
├── ADF Pipeline Files
│   ├── pl_ingest_formula1                 # Pipeline to run ingest files
│   ├── pl_transform_formula1              # Pipeline to run transform files
│   ├── pl_process_formula1                # Pipeline to run two pipelines with a trigger
├── Data
│   ├── 2021-03-21                         # Cutout data
│   ├── 2021-03-28                         # Next week data
│   ├── 2021-03-28                         # Next week data
├── Analysis                               # SQL files for simple analysis
└── Databricks & Power BI Images           # All screenshots of this project
```

## Pipeline Details

### pl_ingest_formula1
- Runs with a trigger every week.
- Runs successfully all ingest files if new data is added to ADLS Gen 2 Raw container.

### pl_transform_formula1
- Runs transform files in Databricks after pl_ingest_formula1
- Data cleaning and transformation steps include:
  - Handling missing values.
  - Converting data types for further analysis.
  - Removing duplicates and outliers.

### pl_process_formula1
- A pipeline to run pl_ingest_formula1 followed by pl_process_formula1 with a trigger to run on every sunday.

## Power BI Visualizations

Power BI pulls data from the Gold layer to visualize:

- Race Results: Driver positions, lap times, and race outcomes.
- Driver Standings: Performance tracking throughout the season.
- Lap Performance: Insights into race and lap-specific performance.

![Power BI Report](https://github.com/nandan2003/Databricks-Formula1-Project/blob/main/Databricks%20%26%20Power%20BI%20Images/Power%20BI%20Analysis%203.png)

## Azure Services Used

- Azure Databricks: Executes the Python and SQL code for transforming the data.
- Azure Data Factory: Schedules and orchestrates the entire data pipeline.
- Azure Data Lake Gen 2: Stores the raw, processed, and final presentation data.
- Azure Key Vault: Secure storage of credentials and secrets used in Databricks and ADF.

## Future Enhancements

- Automate the entire deployment using Terraform or Bicep for Azure infrastructure.
- Add support for real-time data streaming using Azure Event Hubs.
- Implement additional Power BI visualizations for deeper analytics.

