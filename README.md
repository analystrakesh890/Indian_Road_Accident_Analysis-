# 🚦 Indian Road Accident Analytics

An end-to-end data analytics project on **20,000 Indian road accident records (2022 – Apr 2025)**. The goal is to understand which causes, conditions, times, cities, and festivals are linked to more severe accidents.

**Workflow:** Python (cleaning and statistical tests) → MySQL (SQL analysis) → Power BI (interactive dashboard)

---

## 📸 Dashboard Preview

![Power BI Dashboard](images/dashboard.png)

---

## 📂 Dataset

| Item | Detail |
|---|---|
| File | `indian_roads_dataset.csv` |
| Records | 20,000 accidents |
| Coverage | 8 cities, 7 states, 2022 to April 2025 |
| Columns | 24 raw, 29 after feature engineering |
| Key fields | city, state, date, hour, road type, weather, visibility, traffic density, cause, severity, casualties, vehicles involved, festival, risk score |

---

## 🛠️ Tools & Technologies

- **Python:** pandas, NumPy, Matplotlib, SciPy (chi-square, ANOVA, t-tests)
- **MySQL:** joins, CTEs, window functions
- **Power BI:** KPI cards, map, slicers, charts, DAX measures

---

## 🔄 Project Workflow

1. **Data Cleaning (Python)**
   - Filled missing `festival` values with "No Festival" and added an `is_festival` flag
   - Checked for duplicates, outliers, and inconsistent labels (none found)
   - Converted dates and categories to proper types
   - Validated that day of week, weekend flag, and hour matched the date and time
2. **Feature Engineering:** year, month, time of day, casualties per vehicle
3. **Exploratory Analysis and Hypothesis Testing:** severity, cause, time, city, festival, and weather
4. **SQL Analysis (MySQL):** fatal rate by cause and city, region-wise comparison using a JOIN, year-over-year change (`LAG`), top fatal cause per city (`RANK`), monthly running total, festival vs normal days
5. **Dashboard (Power BI):** interactive report with slicers for State, Cause, and Road type

---

## 📊 Dashboard Features

- **KPI cards:** Total Accidents, Total Casualties, Avg Casualties, Fatal Rate
- **Visuals:** state map, accidents by severity, accidents by casualties, visibility split by weather
- **Slicers:** State, Cause, Road type

---

## 🔍 Key Findings

| Area | Finding |
|---|---|
| **Severity** | 55.1% minor, 29.9% major, **14.9% fatal**. Fatal accidents average 3.0 casualties vs about 1.5 for others |
| **Cause** | Fatal rate is highest for Poor Road (15.7%) and Drunk Driving (15.5%), and lowest for Distraction (13.5%). The difference is small but significant (chi-square p = 0.045) |
| **Time** | No significant pattern by hour (p = 0.47), weekday (p = 0.10) or month (p = 0.16) |
| **City** | Accident counts (p = 0.08), fatal rates (p = 0.45) and casualties (p = 0.24) are similar across the 8 cities |
| **Weather** | Average risk score: Fog 0.59, Rain 0.49, Clear 0.24 |
| **Peak hours** | Risk score 0.60 in peak hours vs 0.38 otherwise |
| **Festivals** | Average casualties 2.04 vs 1.73 on normal days (p = 0.03). Holi shows a 34.2% fatal rate, but this is based on only 38 accidents |

> **Note:** Festival accidents are only 115 of 20,000, so the Holi spike should be treated as a signal worth monitoring, not a confirmed effect.

---

## 💡 Recommendations

- Prioritise road quality improvements and drink-driving checks, which have the highest fatal rates
- Add fog and rain alerts and speed controls, since weather conditions raise risk the most
- Increase patrolling during peak hours and festival periods

---

## 📁 Repository Structure

```
indian-road-accident-analytics/
│
├── data/
│   ├── indian_roads_dataset.csv
│   └── indian_roads_clean.csv
├── notebooks/
│   └── Indian_road_accident.ipynb
├── sql/
│   └── Indian_Road_Accident.sql
├── powerbi/
│   └── Indian_Road_Accident.pbix
├── presentation/
│   └── Indian_Road_Accident_Analytics.pptx
├── images/
│   └── dashboard.png
└── README.md
```

---

## ▶️ How to Run

1. Clone the repository
   ```bash
   git clone https://github.com/<your-username>/indian-road-accident-analytics.git
   ```
2. Run `notebooks/Indian_road_accident.ipynb` to clean the data and generate `indian_roads_clean.csv`
3. Load the clean data into MySQL (database `roads_db`, table `accidents`) and run `sql/Indian_Road_Accident.sql`
4. Open `powerbi/Indian_Road_Accident.pbix` in Power BI Desktop and refresh the data source

---

## 📚 What I Learned

- Cleaning and validating a raw dataset step by step
- Testing whether patterns are statistically significant instead of trusting charts alone
- Writing SQL with joins, CTEs, and window functions
- Building an interactive Power BI dashboard

---

## 📬 Connect With Me

- LinkedIn: []
- GitHub: []

⭐ If you found this project useful, consider giving it a star!
