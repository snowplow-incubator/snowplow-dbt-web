-- page view context is given as json string in csv. Parse json
with prep as (
  select
    *,
    parse_json(contexts_com_snowplowanalytics_snowplow_web_page_1_0_0) as contexts_com_snowplowanalytics_snowplow_web_page_1,
    parse_json(unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1_0_0) as unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1,
    parse_json(unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1_0_0) as unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1
  from {{ ref('snowplow_web_events') }}
  )

, flatten as (
  select
    *,
    unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].basis_for_processing as basisForProcessing,
    unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].consent_scopes as consentScopes,
    unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].consent_url as consentUrl,
    unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].consent_version as consentVersion,
    unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].domains_applied as domainsApplied,
    unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].event_type as eventType,
    unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].gdpr_applies as gdprApplies,
    unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1[0]:elapsed_time as elapsedTime

  from prep

)

select
  app_id,
  platform,
  etl_tstamp,
  collector_tstamp,
  dvce_created_tstamp,
  event,
  event_id,
  txn_id,
  name_tracker,
  v_tracker,
  v_collector,
  v_etl,
  user_id,
  user_ipaddress,
  user_fingerprint,
  domain_userid,
  domain_sessionidx,
  network_userid,
  geo_country,
  geo_region,
  geo_city,
  geo_zipcode,
  geo_latitude,
  geo_longitude,
  geo_region_name,
  ip_isp,
  ip_organization,
  ip_domain,
  ip_netspeed,
  page_url,
  page_title,
  page_referrer,
  page_urlscheme,
  page_urlhost,
  page_urlport,
  page_urlpath,
  page_urlquery,
  page_urlfragment,
  refr_urlscheme,
  refr_urlhost,
  refr_urlport,
  refr_urlpath,
  refr_urlquery,
  refr_urlfragment,
  refr_medium,
  refr_source,
  refr_term,
  mkt_medium,
  mkt_source,
  mkt_term,
  mkt_content,
  mkt_campaign,
  se_category,
  se_action,
  se_label,
  se_property,
  se_value,
  tr_orderid,
  tr_affiliation,
  tr_total,
  tr_tax,
  tr_shipping,
  tr_city,
  tr_state,
  tr_country,
  ti_orderid,
  ti_sku,
  ti_name,
  ti_category,
  ti_price,
  ti_quantity,
  pp_xoffset_min,
  pp_xoffset_max,
  pp_yoffset_min,
  pp_yoffset_max,
  useragent,
  br_name,
  br_family,
  br_version,
  br_type,
  br_renderengine,
  br_lang,
  br_features_pdf,
  br_features_flash,
  br_features_java,
  br_features_director,
  br_features_quicktime,
  br_features_realplayer,
  br_features_windowsmedia,
  br_features_gears,
  br_features_silverlight,
  br_cookies,
  br_colordepth,
  br_viewwidth,
  br_viewheight,
  os_name,
  os_family,
  os_manufacturer,
  os_timezone,
  dvce_type,
  dvce_ismobile,
  dvce_screenwidth,
  dvce_screenheight,
  doc_charset,
  doc_width,
  doc_height,
  tr_currency,
  tr_total_base,
  tr_tax_base,
  tr_shipping_base,
  ti_currency,
  ti_price_base,
  base_currency,
  geo_timezone,
  mkt_clickid,
  mkt_network,
  etl_tags,
  dvce_sent_tstamp,
  refr_domain_userid,
  refr_dvce_tstamp,
  domain_sessionid,
  derived_tstamp,
  event_vendor,
  event_name,
  event_format,
  event_version,
  event_fingerprint,
  true_tstamp,
  load_tstamp,
  contexts_com_snowplowanalytics_snowplow_web_page_1,
  object_construct('basisForProcessing', basisForProcessing,'consentScopes', consentScopes, 'consentUrl', consentUrl, 'consentVersion', consentVersion, 'domainsApplied', domainsApplied, 'eventType', eventType, 'gdprApplies', gdprApplies) as unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1,
  object_construct_keep_null('elapsedTime', elapsedTime) as unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1

from flatten
