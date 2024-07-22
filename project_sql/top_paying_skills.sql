/*Answer: What are the top skills based on salary?
• Look at the average salary associated with each skill for Data Analyst positions
• Focuses on roles with specified salaries, regardless of location
• categorize the skills on the basis of salary
Why? It reveals how different skills impact salary levels for Data Analysts and helps identify
the most financially rewarding skills to acquire or improve */


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

/*The analysis shows that skills like PySpark, Bitbucket, and Couchbase are among the highest-paying, with average salaries exceeding $150,000. 
This indicates a strong demand for expertise in these technologies within the data analytics field.


[
  {
    "skills": "pyspark",
    "average_salary": "208172.25",
    "skills_level": "Senior Level"
  },
  {
    "skills": "bitbucket",
    "average_salary": "189154.50",
    "skills_level": "Senior Level"
  },
  {
    "skills": "couchbase",
    "average_salary": "160515.00",
    "skills_level": "Mid Level"
  },
  {
    "skills": "watson",
    "average_salary": "160515.00",
    "skills_level": "Mid Level"
  },
  {
    "skills": "datarobot",
    "average_salary": "155485.50",
    "skills_level": "Mid Level"
  },
  {
    "skills": "gitlab",
    "average_salary": "154500.00",
    "skills_level": "Mid Level"
  },
  {
    "skills": "swift",
    "average_salary": "153750.00",
    "skills_level": "Mid Level"
  },
  {
    "skills": "jupyter",
    "average_salary": "152776.50",
    "skills_level": "Mid Level"
  },
  {
    "skills": "pandas",
    "average_salary": "151821.33",
    "skills_level": "Mid Level"
  },
  {
    "skills": "elasticsearch",
    "average_salary": "145000.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "golang",
    "average_salary": "145000.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "numpy",
    "average_salary": "143512.50",
    "skills_level": "Entry Level"
  },
  {
    "skills": "databricks",
    "average_salary": "141906.60",
    "skills_level": "Entry Level"
  },
  {
    "skills": "linux",
    "average_salary": "136507.50",
    "skills_level": "Entry Level"
  },
  {
    "skills": "kubernetes",
    "average_salary": "132500.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "atlassian",
    "average_salary": "131161.80",
    "skills_level": "Entry Level"
  },
  {
    "skills": "twilio",
    "average_salary": "127000.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "airflow",
    "average_salary": "126103.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "scikit-learn",
    "average_salary": "125781.25",
    "skills_level": "Entry Level"
  },
  {
    "skills": "jenkins",
    "average_salary": "125436.33",
    "skills_level": "Entry Level"
  },
  {
    "skills": "notion",
    "average_salary": "125000.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "scala",
    "average_salary": "124903.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "postgresql",
    "average_salary": "123878.75",
    "skills_level": "Entry Level"
  },
  {
    "skills": "gcp",
    "average_salary": "122500.00",
    "skills_level": "Entry Level"
  },
  {
    "skills": "microstrategy",
    "average_salary": "121619.25",
    "skills_level": "Entry Level"
  }
]  */
