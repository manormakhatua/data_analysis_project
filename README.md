# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.
🔍 SQL queries? Check them out here: [sql_project folder](/project_sql/)

## The questions I wanted to answer through my SQL queries were:
- What are the top-paying data analyst jobs?
- What skills are required for these top-paying jobs?
- What skills are most in demand for data analysts?
- Which skills are associated with higher salaries?
- What are the most optimal skills to learn?
# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.
```sql
SELECT
      job_id,
      job_title,
      job_location,
      job_schedule_type,
      salary_year_avg,
      job_posted_date,
      name as company_name
FROM
    job_postings_fact
    LEFT JOIN
    company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg is NOT NULL
    order BY salary_year_avg DESC
    limit 10;
 ```
**Insights on Top Paying Data Analyst Jobs**

The analysis indicates that there is a significant variation in salaries, with the highest salary reaching $650,000. The average salary for data analysts is approximately $197,050, which reflects the demand and value of data analysis skills in the job market.
- Average Salary: $197,050.00
- Median Salary: $145,000.00
- Highest Salary: $650,000.00
- Lowest Salary: $135,000.00

![chart](https://github.com/user-attachments/assets/756f6e64-0721-4950-96d6-5656a325472d)
*Bar graph visualizing the salary for the top 10 companies salary for data analysts; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
with top_paying_jobs AS(
SELECT
      job_id,
      job_title,
      salary_year_avg,
      name as company_name
FROM
    job_postings_fact
    LEFT JOIN
    company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg is NOT NULL
    order BY salary_year_avg DESC
    limit 10)
SELECT
top_paying_jobs.*,
skills
FROM top_paying_jobs
INNER JOIN skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
LEFT JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
```
**Insights on skills for Top Paying Data Analyst Jobs**

The analysis shows that skills like Python and SAS are among the most frequently mentioned in the job postings, indicating their importance in the data analyst field.

![skills_for_top_jobs](https://github.com/user-attachments/assets/30629b23-ef32-40ba-9a36-52d0cf8f4a19)*Bar graph visualizing the top skills for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
       skills,
       count(skills_job_dim.job_id) as Demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
LEFT JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
job_work_from_home = TRUE
Group BY
skills
ORDER BY Demand_count DESC
limit 5;
```

**Insights on Top Demand Skills for Data Analysts:**
- Total demand across all skills: 22,586
- Highest demand: 7,291 (SQL)
- Lowest demand: 2,609 (Power BI)
**Percentage of Total Demand for Each Skill:**
- SQL: 32.32%
- Excel: 20.39%
- Python: 19.19%
- Tableau: 16.54%
- Power BI: 11.51%

This analysis indicates that SQL is the most in-demand skill for data analysts, followed by Excel and Python.

![top_demand_skills](https://github.com/user-attachments/assets/fc85880f-2e9e-49a8-a956-52fc74715c75)
*Bar graph visualizing top demand skills for data analysts; ChatGPT generated this graph from my SQL query results*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT
skills,
round(avg(salary_year_avg),2 )as average_salary,
CASE
when round(avg(salary_year_avg),2 ) >= '168870.32' THEN 'Senior Level'
when round(avg(salary_year_avg),2 ) >= '146669.48' THEN 'Mid Level'
else 'Entry Level'
end as skills_level
from job_postings_fact
inner JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' AND
salary_year_avg is NOT NULL and
job_work_from_home = TRUE
group by skills
order by 
         average_salary DESC
limit 25;
```
**Here is the breakdown of salaries by skill level:**

**Average Salary by Skill Level:**
|               |  average_salary      |
|---------------|----------------------|
|skill_level    |                      |
|Senior-level	|    168870.32142857142|
|Mid-level	    |    146669.4883333333 |
|Entry-level	|    126865.90666666666|

**Top 5 Skills for Each Level:**

**Senior-level Skills:**
| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |           208172.25|
| bitbucket     |            189154.5|
| couchbase     |              160515|
| watson        |              160515|
| datarobot     |            155485.5|

**Mid-level Skills:**

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| jupyter       |            152776.5|   
|pandas         |           151821.33|
|elasticsearch  |              145000|
|golang         |              145000|
|numpy          |            143512.5|

**Entry-level Skills:**

| Skills        | Average Salary ($) |
|---------------|-------------------:|
|linux          |            136507.5|
|kubernetes     |              132500|
|atlassian      |            131161.8|
|twilio         |              127000|
|airflow        |              126103|


### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
skills_dim.skill_id,
skills_dim.skills,
count(skills_job_dim.job_id) as demand_count,
round(avg(job_postings_fact.salary_year_avg),2) as average_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_title_short = 'Data Analyst'
and salary_year_avg is not NULL
and job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
having count(skills_job_dim.job_id) >10
order BY
average_salary desc,
demand_count DESC
limit 25;
```
**Key Insights:**

**Skill Variety:** The dataset covers a wide range of skills, including programming languages (Go, C++), data technologies (Hadoop, Snowflake), cloud platforms (Azure), and data visualization tools (Tableau, Qlik).

**High-Demand Skills:** Based on the demand count, skills like Go, Snowflake, and Azure seem to be in high demand.

**Salary Trends:** While we don't have a complete salary distribution, we can see that the average salaries vary across skills. For example, Go has an average salary of $115,319.89, which is one of the highest in the dataset.

**Technology Focus:** The skills represented in the data suggest a strong focus on data-related technologies, including big data (Hadoop), cloud computing (Azure, Snowflake), and data visualization (Tableau, Qlik).

**Database Skills:** SQL Server and Redshift appear in the top skills, indicating the importance of database management skills in the job market.

**Data Analysis Tools:** The presence of SAS, Tableau, and Qlik in the top skills highlights the demand for proficiency in data analysis and visualization tools.



# What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Advanced SQL Expert:** Skilled in merging tables and utilizing WITH clauses for creating temporary tables.
- **📊 Data Aggregation:** Mastered GROUP BY, using COUNT() and AVG() to summarize data efficiently.
- **💡Analytical Wizardry:**  Mastering real-world puzzles, transforming questions into actionable SQL insights.


# Conclusions

### Insights
**1. Top Paying Data Analyst Jobs**

The analysis indicates that there is a significant variation in salaries, with the highest salary reaching $650,000. The average salary for data analysts is approximately $197,050, which reflects the demand and value of data analysis skills in the job market.

**2. Skills for Top Paying Jobs**

The analysis shows that skills like Python and SAS are among the most frequently mentioned in the job postings, indicating their importance in the data analyst field.

**3. In-Demand Skills for Data Analysts**

This analysis indicates that SQL is the most in-demand skill for data analysts, followed by Excel and Python.

**4. Skills Based on Salary**

The analysis shows that Senior-level skills have the highest average salary, followed by Mid-level and Entry-level skills. The visualizations provide a clear representation of the salary distribution and the top skills within each category.

**5. Most Optimal Skills to Learn**

The skills represented in the data suggest a strong focus on data-related technologies, including big data (Hadoop), cloud computing (Azure, Snowflake), and data visualization (Tableau, Qlik).

# Closing Thoughts

This project significantly enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a comprehensive guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration underscores the importance of continuous learning and adaptation to emerging trends in the field of data analytics, ultimately helping individuals to stay ahead and maximize their career potential.
