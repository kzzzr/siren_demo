{# {{
    config (
      order_by='lead_UUID'
    )
}} #}

{% set parts = [
      ref('data_1')
    , ref('data_10')
    , ref('data_11')
    , ref('data_12')
    , ref('data_13')
    , ref('data_14')
    , ref('data_15')
    , ref('data_16')
    , ref('data_17')
    , ref('data_18')
    , ref('data_19')
    , ref('data_2')
    , ref('data_20')
    , ref('data_21')
    , ref('data_22')
    , ref('data_3')
    , ref('data_4')
    , ref('data_5')
    , ref('data_6')
    , ref('data_7')
    , ref('data_8')
    , ref('data_9')
] %}

with unioned as (

    {{ dbt_utils.union_relations(
        relations=parts
        ,where="ENTRYDATE not in ('-----')"
    ) }}
    
)

SELECT

      parseDateTimeBestEffortOrNull(ENTRYDATE) AS entry_dt
    , assumeNotNull(LEADNUMBER) AS lead_number
    , email_hash AS email_hash
    , phone_hash AS phone_hash
    , {{ dbt_utils.generate_surrogate_key(['phone_hash', 'email_hash']) }} as lead_hash
    , COALESCE(CITY, CityName, trim(splitByChar('|', assumeNotNull(location))[1])) AS city
    , COALESCE(STATE, trim(splitByChar('|', assumeNotNull(location))[2])) AS state
    , ZIP AS zip
    , parseDateTimeBestEffortOrNull(`Appt Date`) AS appt_dt
    , `Set` AS is_set
    , COALESCE(Demo, 0) AS is_demo
    , Dispo AS dispo
    , `Job Status` AS job_status

FROM unioned