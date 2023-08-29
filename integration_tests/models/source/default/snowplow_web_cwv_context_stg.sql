{#
Copyright (c) 2020-present Snowplow Analytics Ltd. All rights reserved.
This program is licensed to you under the Snowplow Community License Version 1.0,
and you may not use this file except in compliance with the Snowplow Community License Version 1.0.
You may obtain a copy of the Snowplow Community License Version 1.0 at https://docs.snowplow.io/community-license-1.0
#}

select
  cls,
  fcp,
  fid,
  inp,
  lcp,
  navigation_type,
  ttfb,
  root_tstamp::timestamp,
  root_id,
  schema_name

from {{ ref('snowplow_web_cwv_context') }}