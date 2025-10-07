# SQL Project: Dhaka Air Quality Analysis (2000–2025)

## 1. Project Objective
This project performs a comprehensive exploratory data analysis (EDA) on a synthetic dataset representing 25 years of hourly air quality in Dhaka, Bangladesh.  
The primary goal is to use **SQL** to query and analyze the data to identify long-term trends, seasonal patterns, and the relationships between various atmospheric pollutants and weather conditions.

---

## 2. Dataset
- **Source**: [Kaggle](https://www.kaggle.com/)  
- **Size**: 225,816 hourly records  
- **Time Period**: January 1, 2000 – October 4, 2025  
- **Key Columns**: `datetime`, `AQI`, `PM2.5`, `Temperature`, `Humidity`, `Wind_Speed`, etc.  

⚠️ **Important Note**:  
This is a synthetically generated dataset. While it provides an excellent opportunity to practice complex SQL queries and analyze broad, pre-programmed trends, some nuanced relationships between variables may not perfectly reflect real-world atmospheric physics.  
This became a key finding during the analysis.

---

## 3. Tools Used
- **Database**: PostgreSQL  
- **GUI / Client**: DBeaver  
- **Language**: SQL  

---

## 4. ETL Process: Database and Table Creation
The database environment was first set up:  
- A new database named `dhaka_air_quality` was created.  
- A table named `air_quality` was designed with appropriate data types for each column.  

### DDL Script
```sql
CREATE TABLE public.air_quality (
    datetime      TIMESTAMP,
    aqi           NUMERIC(15, 8),
    pm2_5         NUMERIC(15, 8),
    pm10          NUMERIC(15, 8),
    o3            NUMERIC(15, 8),
    no2           NUMERIC(15, 8),
    so2           NUMERIC(15, 8),
    co            NUMERIC(15, 8),
    temperature   NUMERIC(15, 8),
    humidity      NUMERIC(15, 8),
    wind_speed    NUMERIC(15, 8),
    pressure      NUMERIC(15, 8)
);
