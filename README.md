# Salvation Army NZ: Food Parcel Program Analysis

## Project Overview
This data analytics project aims to optimize The Salvation Army New Zealand's food parcel distribution and referral services. By analyzing 890 household records, provided by Salvation Army, the project identifies key trends in demographics, visit frequency, and seasonal demand to enhance operational efficiency, improve resource allocation, and increase the uptake of crucial financial mentoring services.

**Objective:** To provide data-driven strategies for reducing waste, boosting referral outreach, and forecasting parcel needs, ultimately supporting more families in need with limited resources.

---

## Project Phases & Deliverables

This project was executed in three key phases:

### 1. Excel - Data Exploration & Executive Summary
*   **File:** `SalvationArmy_FoodAssistance_Analysis.pdf` and excel file
*   **Activity:** Initial data cleaning, pivot table analysis, chart creation, and development of an executive summary with key findings and strategic recommendations.
*   **Key Insights:**
    *   81.35% of households rely on government support.
    *   Demand peaks in November (166 parcels) and March (153 parcels).
    *   Only 32.36% of households are referred to financial mentoring, indicating a significant service gap.
    *   Culturally tailored parcel sizing (e.g., larger parcels for Pasifika families) can reduce waste.

### 2. SQL - Deep-Dive Data Analysis
*   **File:** `salvation_army_food_parcel_analysis.sql`
*   **Data:** `households.csv`
*   **Output:** `SalvationArmy_SQL_Output.pdf`
*   **Activity:** Advanced querying using SQLite to uncover complex patterns and validate hypotheses from the Excel phase.
*   **Key Analyses Performed:**
    *   Referral rates by family type and ethnicity.
    *   Seasonal trends in parcel assignments.
    *   Correlation between household size and parcel size.
    *   Visit frequency analysis with referral rates.
    *   Monthly referral trends and cumulative assignments over time.

### 3. Power BI - Interactive Data Visualization & Reporting
*   **Dashboard Executive Summary Link:** [Executive Summary](https://app.powerbi.com/groups/me/reports/785098e9-5158-4308-bdfd-aafea2e70fd5/5b7b49e375cb85b7da13?experience=power-bi)
*   **Dashboard Demographic Insights Link:** [Demographic Insights](https://app.powerbi.com/groups/me/reports/785098e9-5158-4308-bdfd-aafea2e70fd5/1d8293835521744d0828?experience=power-bi)
*   **Dashboard Operational Analysis Link:** [Operational Analysis](https://app.powerbi.com/groups/me/reports/785098e9-5158-4308-bdfd-aafea2e70fd5/368ec7a2243515c85981?experience=power-bi)
*   **Dashboard Powerpoint:** `SalvationArmy - PowerBI.ppsx`
*   **Activity:** Developed an interactive dashboard to visualize insights dynamically, allowing stakeholders to filter by ethnicity, income source, date, and family type.
*   **Key Visuals:**
    *   Monthly parcel demand forecasting.
    *   Demographic breakdown of beneficiaries (Ethnicity & Age).
    *   Financial mentoring referral rates by ethnicity.
    *   Audit of parcel allocation consistency across family types.

---

## Technologies Used
*   **Microsoft Excel:** Data cleaning, pivot tables, static charts, and executive reporting.
*   **SQL (SQLite):** Complex data analysis and querying.
*   **Power BI:** Interactive data visualization and dashboard creation.
*   **Git & GitHub:** Version control and project documentation.

---

## How to Use This Repository

### Viewing the Analysis
1.  **Executive Summary (Excel):** Download and open `SalvationArmy_FoodAssistance_Analysis.pdf` or `SalvationArmy_FoodAssistance_Analysis.xlsx`
2.  **SQL Analysis:** View the `salvation_army_food_parcel_analysis.sql` file directly on GitHub to see the query logic. For a deeper dive:
    *   **Option A (Quick):** Use an online SQLite browser like [SQLiteOnline](https://sqliteonline.com/). Upload the `households.csv` and run the queries.
    *   **Option B (Local):** Use DB Browser for SQLite (a free desktop tool). Create a new database, import the `households.csv` file, and run the SQL queries.
3.  **Power BI Dashboard:** Click the link above to view the interactive report. 

### Replicating the SQL Analysis
1.  Download the `households.csv` file.
2.  Open your preferred SQL database tool (e.g., DB Browser for SQLite).
3.  Create a new database and import the CSV file into a table named `HOUSEHOLDS`.
4.  Open the `salvation_army_food_parcel_analysis.sql` file and execute the queries step-by-step.

---

## Key Strategic Recommendations (Summary)
1.  **Inventory Optimization:** Reallocate stock from smaller parcels (Size 2) to larger ones (Sizes 10, 16, 20) to match demographic needs, reducing waste by an estimated 20%.
2.  **Referral Program Expansion:** Target 100% of households with no income for financial mentoring referrals. Focus outreach efforts on the Māori community, which has the lowest current referral rate (28.81%).
3.  **Seasonal Planning:** Increase inventory by 15% for peak months (November and March) to meet heightened demand.
4.  **Culturally Tailored Services:** Partner with Māori and Pasifika community leaders to design and promote support services, ensuring they are accessible and relevant.

**Projected Impact:** These data-driven optimizations could yield approximately **$47,000 in annual savings**, allowing for the funding of over 65 additional food parcels per month.

---

## Author
**Juliana Binondo** \
[LinkedIn](https://www.linkedin.com/in/juliana-binondo-0b71a6300/) | [Email](mailto:julianabinondo04@gmail.com)

*Prepared for: The Salvation Army New Zealand* \
*Date: August 2025*
