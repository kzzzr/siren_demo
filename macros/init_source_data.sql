{% macro init_source_data() -%}

    {% set sql %}
        DROP DATABASE IF EXISTS landing ;
    {% endset %}    
    {% set result = run_query(sql) %}
    {{ print('DROP DATABASE IF EXISTS landing') }}

    {% set sql %}
        CREATE DATABASE IF NOT EXISTS landing ;
    {% endset %}    
    {% set result = run_query(sql) %}
    {{ print('CREATE DATABASE IF NOT EXISTS landing') }}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS landing.leads
        ENGINE = MergeTree
        ORDER BY tuple() AS
        SELECT *
        FROM file('leads.parquet', Parquet)
        ;
    {% endset %}    
    {% set result = run_query(sql) %}
    {{ print('CREATE TABLE IF NOT EXISTS landing.leads') }}

{%- endmacro %}
