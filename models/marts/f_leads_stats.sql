{{
    config (
        engine='MergeTree()'
    )
}}

SELECT

      leads.lead_uuid AS lead_uuid
    , leads.email_hash AS email_hash
    , leads.phone_hash AS phone_hash
    , leads.lead_hash AS lead_hash
    , crm_lead_progress.lead_number AS lead_number
    
    , crm_lead_progress.entry_dt AS entry_dt
    , crm_lead_progress.appt_dt AS appt_dt
    
    , crm_lead_progress.is_set AS is_set
    , crm_lead_progress.is_demo AS is_demo

    , crm_lead_progress.city AS city
    , crm_lead_progress.state AS state
    , crm_lead_progress.zip AS zip
    , crm_lead_progress.dispo AS dispo
    , crm_lead_progress.job_status AS job_status

FROM {{ ref('stg_backend_leads') }} AS leads
    LEFT JOIN {{ ref('int_crm_lead_progress') }} AS crm_lead_progress USING (lead_hash)