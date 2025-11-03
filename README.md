# 💳 Credit Risk Analytics using SQL & Power BI

![Finance Banner](https://github.com/user-attachments/assets/1ab48838-36a9-4cb1-95ab-8194f3cfcbec)

## 📊 Overview
This project presents an **end-to-end Credit Risk Analysis** that leverages **PostgreSQL** for advanced data querying and **Power BI** for interactive visualization.  
It provides deep insights into customer credit behavior, loan performance, and potential risk exposures — designed to mirror real-world analytics used in top financial institutions like **Goldman Sachs**, **S&P Global**, and **Barclays**.

---

## 🎯 Objectives
- Evaluate customer **creditworthiness and default probability**.  
- Identify **high-risk loan segments** and key factors influencing risk.  
- Build an **interactive financial dashboard** for portfolio intelligence.  
- Perform **SQL-based analytics** to extract critical business insights.

---

## 🧠 Key Business Questions
1. What is the overall **loan default rate** across the portfolio?  
2. Which **customer segments** are most at risk?  
3. How do **interest rates, income, and age** impact default behavior?  
4. What are the **top-performing vs. underperforming** credit categories?  
5. How can a bank use these insights to **improve loan approval strategies**?

---

## 🗂️ Dataset
**Dataset Name:** Credit Risk Dataset  
**Source:** [Kaggle - Credit Risk Dataset](https://www.kaggle.com/datasets/laotse/credit-risk-dataset)  
**Rows:** 10,000+  
**Columns:** 10+  

This dataset includes customer credit history, loan information, and repayment patterns.  

---

## 🧱 Database Schema
```sql
CREATE TABLE credit_risk (
    person_age INT,
    person_income FLOAT,
    person_home_ownership VARCHAR(50),
    person_emp_length FLOAT,
    loan_intent VARCHAR(100),
    loan_grade VARCHAR(10),
    loan_amnt FLOAT,
    loan_int_rate FLOAT,
    loan_status INT,
    loan_percent_income FLOAT,
    cb_person_default_on_file VARCHAR(10),
    cb_person_cred_hist_length INT
);
