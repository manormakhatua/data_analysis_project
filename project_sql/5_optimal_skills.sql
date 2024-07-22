/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
-Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
-Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis 
*/

with skill_demand as (
SELECT 
       skills_dim.skills,
       skills_dim.skill_id,
       count(skills_job_dim.job_id) as Demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
LEFT JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
job_work_from_home = TRUE AND
salary_year_avg is NOT NULL 
Group BY
skills_dim.skill_id
), average_salary as(
SELECT
skills_job_dim.skill_id,
skills_dim.skills,
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
group by skills_job_dim.skill_id,
skills_dim.skills
)

SELECT
      skill_demand.skill_id,
      skill_demand.skills,
      average_salary,
      Demand_count
      from skill_demand
      inner join average_salary on skill_demand.skill_id = average_salary.skill_id
      WHERE Demand_count >10
      order BY
      Demand_count DESC,
      average_salary DESC
      limit 25;

--rewriting the query
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

/*

[
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "average_salary": "115319.89"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "demand_count": "11",
    "average_salary": "114209.91"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "22",
    "average_salary": "113192.57"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "37",
    "average_salary": "112947.97"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "34",
    "average_salary": "111225.10"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "13",
    "average_salary": "109653.85"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "32",
    "average_salary": "108317.30"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "17",
    "average_salary": "106906.44"
  },
  {
    "skill_id": 194,
    "skills": "ssis",
    "demand_count": "12",
    "average_salary": "106683.33"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "average_salary": "104917.90"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "37",
    "average_salary": "104533.70"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "49",
    "average_salary": "103795.30"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "13",
    "average_salary": "101413.73"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "236",
    "average_salary": "101397.22"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "148",
    "average_salary": "100498.77"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "16",
    "average_salary": "99936.44"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "demand_count": "13",
    "average_salary": "99630.81"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "230",
    "average_salary": "99287.65"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "demand_count": "14",
    "average_salary": "99171.43"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "13",
    "average_salary": "99076.92"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "demand_count": "11",
    "average_salary": "98958.23"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "average_salary": "98902.37"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "average_salary": "98902.37"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "35",
    "average_salary": "97785.73"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "20",
    "average_salary": "97587.00"
  }
]
*/