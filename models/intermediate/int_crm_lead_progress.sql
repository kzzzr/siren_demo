{{
    config (
        engine='ReplacingMergeTree()',
        order_by=['lead_hash'],
        post_hook=['OPTIMIZE TABLE {{ this }} FINAL DEDUPLICATE BY lead_hash, entry_dt, appt_dt']
    )
}}

SELECT

      entry_dt
    , lead_number
    , email_hash
    , phone_hash
    , lead_hash
    , city
    , state
    , zip
    , appt_dt
    , is_set
    , is_demo
    , dispo
    , job_status

FROM {{ ref('stg_crm_lead_progress') }}