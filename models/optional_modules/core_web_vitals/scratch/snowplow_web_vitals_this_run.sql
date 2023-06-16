{{
  config(
     enabled=var("snowplow__enable_cwv", false) and target.type in ('databricks', 'spark', 'snowflake', 'bigquery') | as_bool(),
    tags=["this_run"],
    sql_header=snowplow_utils.set_query_tag(var('snowplow__query_tag', 'snowplow_dbt'))
  )
}}

with prep as (

  select
    e.event_id,
    e.event_name,
    e.app_id,
    e.platform,
    e.domain_userid,
    e.user_id,
    e.page_view_id,
    e.domain_sessionid,
    e.collector_tstamp,
    e.derived_tstamp,
    e.load_tstamp,
    e.geo_country,
    e.page_url,
    {{ core_web_vital_page_groups() }} as url_group,
    e.page_title,
    e.useragent,
    e.device_class,
    e.device_name,
    e.agent_name,
    e.agent_version,
    e.operating_system_name,
    e.lcp,
    e.fcp,
    e.fid,
    e.cls,
    e.inp,
    e.ttfb,
    e.navigation_type

  from {{ ref("snowplow_web_vital_events_this_run") }} as e

  where {{ snowplow_utils.is_run_with_new_events('snowplow_web') }} --returns false if run doesn't contain new events.

  qualify row_number() over (partition by e.page_view_id order by e.derived_tstamp, e.dvce_created_tstamp, e.event_id) = 1

)

select
  *,
  {{ snowplow_web.core_web_vital_results_query() }}

from prep p
