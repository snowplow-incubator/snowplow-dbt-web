{#
Copyright (c) 2020-present Snowplow Analytics Ltd. All rights reserved.
This program is licensed to you under the Snowplow Community License Version 1.0,
and you may not use this file except in compliance with the Snowplow Community License Version 1.0.
You may obtain a copy of the Snowplow Community License Version 1.0 at https://docs.snowplow.io/community-license-1.0
#}

{% macro core_web_vital_pass_query() %}
  {{ return(adapter.dispatch('core_web_vital_pass_query', 'snowplow_web')()) }}
{%- endmacro -%}

{% macro default__core_web_vital_pass_query() %}

case when m.lcp_result = 'good' and m.fid_result = 'good' and m.cls_result = 'good' then 1 else 0 end

{% endmacro %}
