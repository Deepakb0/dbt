
{{
    config(
        materialized='incremental',
        unique_key='EMPLOYEE_ID'
    )
}}

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    HIRE_DATE,
    JOB_ID,
    SALARY,
    COMMISSION_PCT,
    MANAGER_ID,
    DEPARTMENT_ID,
    CURRENT_TIMESTAMP() AS LOAD_TIME
FROM hr.src_employees

{% if is_incremental() %}
WHERE EMPLOYEE_ID NOT IN (
    SELECT EMPLOYEE_ID
    FROM {{ this }}
)
{% endif %}
