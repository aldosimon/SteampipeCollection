select
    event_time,
    event_name,
    event_source,
    username
 --jasonb_pretty(cloud_trail_event)   
from
    aws_cloudtrail_lookup_event
where
--filter using ASIA accesskeyid
--    cloud_trail_event -> 'userIdentity' ->> 'accessKeyId' like 'ASIA%'
order by event_time desc
limit 100