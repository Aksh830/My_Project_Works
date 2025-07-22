# 📊 Google AdSense Web Traffic Analysis (Excel)

This project presents an exploratory data analysis (EDA) of web traffic using data exported from **Google AdSense**, processed and visualized using **Microsoft Excel**.

---

## 🔍 Objective

To analyze visitor behavior and website performance using key metrics such as **bounce rate**, **session time**, **conversion rate**, and **revenue**, using Excel tools like **Power Query**, **PivotTables**, and **charts**.

---

## 📂 Data Source

- **Source**: Google AdSense export
- **Format**: `.csv` file
- **Size**: ~12,000+ rows

---

## 🧼 Data Cleaning (Using Power Query)

The following steps were taken to clean and prepare the dataset:

- **Imported** the raw `.csv` file into Excel using **Power Query**
- **Transformed** comma-separated values into a structured Excel **table with over 12,000 rows**
- **Assigned appropriate data types** to each column (e.g., Date, Decimal Number, Text)
- **Removed unnecessary columns** that did not contribute to the analysis
- **Removed 400+ duplicate rows** to ensure accuracy
- **Converted time columns** (initially in numeric format) into **readable minutes and seconds**

---

## 📈 Analysis Performed

After cleaning the data, a **Pivot Table** and corresponding **chart** were created to answer the following key business questions:

1. **What is the proportion of visitors who made a purchase?**
   - Calculated the conversion rate by comparing total visitors vs. purchase completions.

2. **What is the average time spent on the website by the visitors?**
   - Used calculated fields to analyze session durations across different user groups.

3. **What is the correlation between the bounce rate and the revenue?**
   - Explored relationship using grouped data and visual correlation via charting.

4. **What is the distribution of the operating system used by the visitors?**
   - Created a visual breakdown of OS usage (e.g., Windows, macOS, Android, iOS) among visitors.

---

## 🛠️ Tools Used

- **Microsoft Excel** (Power Query, PivotTables, Charts, Data Types)
- **Data Cleaning**: Power Query Editor
- **Visualization**: Bar and pie charts within Excel
- **File Type**: `.xlsx`, `.csv`

---

## 📷 Screenshots

> _Include screenshots of your pivot table, chart, or dashboard here if possible._

```md
![Pivot Table](images/pivot_table_screenshot.png)
![Chart](images/chart_screenshot.png)
****
