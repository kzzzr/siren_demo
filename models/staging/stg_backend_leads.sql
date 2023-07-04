{{
    config (
      order_by='lead_uuid'
    )
}}

select 

      `lead_UUID` AS lead_uuid
    , phone_hash
    , email_hash
    , {{ dbt_utils.generate_surrogate_key(['phone_hash', 'email_hash']) }} as lead_hash

from {{ source('backend', 'leads') }}