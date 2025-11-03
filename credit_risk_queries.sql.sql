DROP TABLE IF EXISTS credit_risk;
CREATE TABLE credit_risk (
    person_age FLOAT,
    person_income INT,
    person_home_ownership VARCHAR(20),
    person_emp_length FLOAT,
    loan_intent VARCHAR(50),
    loan_grade VARCHAR(5),
    loan_amnt INT,
    loan_int_rate FLOAT,
    loan_status INT,
    loan_percent_income FLOAT,
    cb_person_default_on_file VARCHAR(5),
    cb_person_cred_hist_length INT
);

SELECT * FROM credit_risk LIMIT 10;

-- Check for missing values
SELECT COUNT(*) - COUNT(person_age) AS missing_age 
FROM credit_risk;

-- See distinct loan intents
SELECT DISTINCT loan_intent 
FROM credit_risk;

-- See summary of loan status
SELECT loan_status, COUNT(*) 
FROM credit_risk 
GROUP BY loan_status;

--QUERY(1) - Customer Distribution by Loan Intent

SELECT loan_intent, COUNT(*) AS total_applications
FROM credit_risk
GROUP BY loan_intent
ORDER BY total_applications DESC;

--QUERY(2) - Average Loan Amount and Default Rate by Grade

SELECT 
    loan_grade,
    ROUND(AVG(loan_amnt),2) AS avg_loan_amount,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY loan_grade
ORDER BY default_rate DESC;

--QUERY(3) - Relationship Between Income and Default Probability

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

--QUERY(4) - Home Ownership vs Loan Defaults

SELECT 
    person_home_ownership,
    COUNT(*) AS total_applicants,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY person_home_ownership
ORDER BY default_rate DESC;

--QUERY(5) - Loan Intent and Default Behavior Cross-Analysis

SELECT 
    loan_intent,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate,
    ROUND(AVG(loan_int_rate),2) AS avg_interest_rate
FROM credit_risk
GROUP BY loan_intent
ORDER BY default_rate DESC;

--QUERY(6) - Impact of Credit History Length on Default

SELECT 
    cb_person_cred_hist_length AS credit_history_years,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY credit_history_years
ORDER BY credit_history_years ASC;

--QUERY(7) - Default Trend by Employment Length

SELECT 
    ROUND(person_emp_length,1) AS employment_years,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS default_rate
FROM credit_risk
GROUP BY employment_years
ORDER BY employment_years;

--QUERY(8) - Overall Default Rate and Loan Portfolio Health

SELECT 
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS total_defaults,
    ROUND(SUM(loan_status)::numeric / COUNT(*) * 100, 2) AS portfolio_default_rate,
    ROUND(AVG(loan_int_rate)::numeric, 2) AS avg_interest_rate
FROM credit_risk;














