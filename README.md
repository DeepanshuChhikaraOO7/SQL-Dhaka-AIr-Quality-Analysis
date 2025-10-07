# 🌆 SQL Project: Dhaka Air Quality Analysis

## 🧠 Introduction
This project is a deep-dive analysis of **25 years of hourly air quality data** from **Dhaka, Bangladesh**. Using **SQL**, the goal was to explore a large dataset (~225,000+ records) to uncover:
- Long-term air quality trends  
- Seasonal pollution patterns  
- Relationships between weather factors and pollution levels  

> **Dataset:** [Dhaka Air Quality 2000–2025 (Synthetic Dataset)](https://www.kaggle.com/datasets/shakil10945/dhaka-air-quality-2000-2025-synthetic-dataset) from Kaggle.  
> Note: The dataset is *synthetically generated*, which became relevant during the analysis.

## 🧰 Tools Used
| Purpose | Tool |
|----------|------|
| **Database** | PostgreSQL |
| **SQL Client** | DBeaver |

## 🔍 Key Questions & Analysis

### 1️⃣ Is Dhaka's air quality getting better or worse over time?
**Objective:** Understand the long-term AQI trend.  
We calculated the **average Air Quality Index (AQI)** for each year.

    -- Yearly Trend: Average AQI per year
    SELECT
        EXTRACT(YEAR FROM datetime) AS year,
        ROUND(AVG(aqi), 2) AS avg_yearly_aqi
    FROM
        air_quality
    GROUP BY
        year
    ORDER BY
        year ASC;

**🧾 Findings:**  
Dhaka’s air quality has **consistently worsened** over the past 25 years.  
- **2000:** AQI ≈ 107.15 → *Unhealthy for Sensitive Groups*  
- **2025 (projected):** AQI ≈ 235.68 → *Very Unhealthy*  

📈 **Conclusion:** A clear long-term decline in air quality.

---

### 2️⃣ Are there specific seasons or months when pollution is at its worst?
**Objective:** Identify seasonal air quality variations by month.

    -- Monthly Trend: Average AQI per month (across all years)
    SELECT
        EXTRACT(MONTH FROM datetime) AS month_number,
        ROUND(AVG(aqi), 2) AS avg_monthly_aqi
    FROM
        air_quality
    GROUP BY
        month_number
    ORDER BY
        avg_monthly_aqi DESC;

**🧾 Findings:**  
A strong **seasonal pattern** emerges:
- **🌫️ Most Polluted Months:** December, January, February → *AQI > 200 (Very Unhealthy)*  
- **🌧️ Least Polluted Months:** June–September → *AQI ~160–165 (Unhealthy)*  

📅 **Conclusion:** Pollution peaks in **winter** and drops during the **monsoon**.

---

### 3️⃣ What is the relationship between wind speed and air quality?
**Hypothesis:** Higher wind speeds → lower AQI (wind clears pollution).  

    -- Analyzing the effect of Wind Speed on AQI
    SELECT
        CASE
            WHEN wind_speed < 5 THEN '0-5 (Calm Air)'
            WHEN wind_speed >= 5 AND wind_speed < 10 THEN '5-10 (Light Breeze)'
            WHEN wind_speed >= 10 AND wind_speed < 15 THEN '10-15 (Gentle Breeze)'
            ELSE '15+ (Moderate to Strong Wind)'
        END AS wind_category,
        ROUND(AVG(aqi), 2) AS average_aqi_in_category
    FROM
        air_quality
    GROUP BY
        wind_category
    ORDER BY
        average_aqi_in_category DESC;

**🧾 Findings:**  
Surprisingly, **higher wind speeds** corresponded to **higher AQI** — contradicting expectations.  
Further analysis revealed a **confounding variable**:
- **Windiest months** were also **most polluted winter months**, skewing the results.  
This reflects a **limitation of the synthetic dataset**, which modeled seasonal effects well but not secondary relationships like wind–pollution dynamics.

📉 **Conclusion:** The data’s artificial nature influenced the results — an important reminder to critically evaluate data sources.

---

## 🧩 Overall Conclusion
This SQL-based exploration confirmed three major insights about Dhaka’s air quality:

| # | Key Insight | Summary |
|---|--------------|----------|
| 1️⃣ | **Long-Term Decline** | Air quality has worsened steadily over 25 years. |
| 2️⃣ | **Strong Seasonality** | Pollution peaks in winter, dips in monsoon. |
| 3️⃣ | **Data Limitations** | Synthetic data led to unrealistic correlations. |

---

## 📚 Lessons Learned
- Always validate synthetic or simulated datasets before deep analysis.  
- SQL is a powerful tool not just for querying, but for **pattern discovery and hypothesis testing**.  
- Unexpected results can uncover **hidden assumptions** or **data flaws** — valuable insights in themselves.

