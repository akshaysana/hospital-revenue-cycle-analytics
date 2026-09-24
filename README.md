# Hospital Revenue Cycle Analytics: Denial Remediation

## Business Problem
Healthcare organizations frequently experience revenue leakage due to denied claims and administrative friction. This project simulates a Big 4 advisory engagement to identify, quantify, and visualize the root causes of claim denials, allowing financial leadership to target the highest-impact administrative errors and specific insurance payers. 

## Key Performance Indicators (KPIs)
* **Total Billed:** The aggregate dollar amount billed to all payers.
* **Total Paid:** The actual cash collected.
* **Total Revenue Leakage:** The absolute dollar amount lost due to denials.
* **Denial Rate:** The percentage of billed revenue that evaporated (Revenue Leakage / Total Billed).

## Data Architecture & Design Decisions
* **Dimensional Modeling:** The backend is structured in SQL Server using a strict 3-table Star Schema to prevent data multiplication and optimize aggregation speed.
  * `Fact_Claims`: Contains the mathematical event records and foreign keys.
  * `Dim_Payer`: Contains payer demographic descriptions.
  * `Dim_Denial_Context`: Contains categorical text data regarding claim status and reason codes.
* **Financial Color Psychology:** Green universally implies positive profit. Because this dashboard strictly tracks revenue loss and pain points, green was explicitly excluded. The UI utilizes a strict corporate grayscale palette with a single Crimson (`#B33939`) accent color to draw executive attention directly to the most critical leakage points via pre-attentive processing.

## Dashboard 
![Executive Dashboard](assets/Revenue%20Cycle%20Analytics-denial%20remediation.png)