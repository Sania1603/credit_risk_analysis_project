# 💳 Credit Risk Analytics using SQL & Power BI

![Finance Banner](https://github.com/user-attachments/assets/1ab48838-36a9-4cb1-95ab-8194f3cfcbec)

## Overview
This project presents an **end-to-end Credit Risk Analysis** that leverages **PostgreSQL** for advanced data querying and **Power BI** for interactive visualization.  
It provides deep insights into customer credit behavior, loan performance, and potential risk exposures — designed to mirror real-world analytics used in top financial institutions like **Goldman Sachs**, **S&P Global**, and **Barclays**.

---

## Objectives
- Evaluate customer **creditworthiness and default probability**.  
- Identify **high-risk loan segments** and key factors influencing risk.  
- Build an **interactive financial dashboard** for portfolio intelligence.  
- Perform **SQL-based analytics** to extract critical business insights.

---

## Key Business Questions
1. What is the overall **loan default rate** across the portfolio?  
2. Which **customer segments** are most at risk?  
3. How do **interest rates, income, and age** impact default behavior?  
4. What are the **top-performing vs. underperforming** credit categories?  
5. How can a bank use these insights to **improve loan approval strategies**?

---

## Dataset
**Dataset Name:** Credit Risk Dataset  
**Source:** [Kaggle - Credit Risk Dataset](https://www.kaggle.com/datasets/laotse/credit-risk-dataset)  
**Rows:** 10,000+  
**Columns:** 10+  

This dataset includes customer credit history, loan information, and repayment patterns.  

---

## Database Schema
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
```

```sql
SELECT * FROM credit_risk LIMIT 10;
```

-- Check for missing values
```sql
SELECT COUNT(*) - COUNT(person_age) AS missing_age 
FROM credit_risk;
```

-- See distinct loan intents
```sql
SELECT DISTINCT loan_intent 
FROM credit_risk;
```

-- See summary of loan status
```sql
SELECT loan_status, COUNT(*) 
FROM credit_risk 
GROUP BY loan_status;
```

--QUERY(1) - Customer Distribution by Loan Intent
```sql
SELECT loan_intent, COUNT(*) AS total_applications
FROM credit_risk
GROUP BY loan_intent
ORDER BY total_applications DESC;
```

--QUERY(2) - Average Loan Amount and Default Rate by Grade
```sql
SELECT 
    loan_grade,
    ROUND(AVG(loan_amnt),2) AS avg_loan_amount,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY loan_grade
ORDER BY default_rate DESC;
```

--QUERY(3) - Relationship Between Income and Default Probability
```sql
SELECT 
    CASE 
        WHEN person_income < 30000 THEN 'Low Income'
        WHEN person_income BETWEEN 30000 AND 60000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS income_group,
    COUNT(*) AS customers,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY income_group
ORDER BY default_rate DESC;
```

--QUERY(4) - Home Ownership vs Loan Defaults
```sql
SELECT 
    person_home_ownership,
    COUNT(*) AS total_applicants,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY person_home_ownership
ORDER BY default_rate DESC;
```

--QUERY(5) - Loan Intent and Default Behavior Cross-Analysis
```sql
SELECT 
    loan_intent,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate,
    ROUND(AVG(loan_int_rate),2) AS avg_interest_rate
FROM credit_risk
GROUP BY loan_intent
ORDER BY default_rate DESC;
```

--QUERY(6) - Impact of Credit History Length on Default
```sql
SELECT 
    cb_person_cred_hist_length AS credit_history_years,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY credit_history_years
ORDER BY credit_history_years ASC;
```

--QUERY(7) - Default Trend by Employment Length
```sql
SELECT 
    ROUND(person_emp_length,1) AS employment_years,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY employment_years
ORDER BY employment_years;
```

--QUERY(8) - Overall Default Rate and Loan Portfolio Health
```sql
SELECT 
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS total_defaults,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS portfolio_default_rate,
    ROUND(AVG(loan_int_rate)::numeric, 2) AS avg_interest_rate
FROM credit_risk;
```




