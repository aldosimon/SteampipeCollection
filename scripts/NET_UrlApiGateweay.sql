--https://steampipe.io/blog/aws-attack-surface
--format: https://[api-id].execute-api.[region].amazonaws.com/[stage]/[path]


select
  'https://' || api_id || '.execute-api.' || region || '.amazonaws.com/' || stage_name as url
from
  aws_api_gatewayv2_stage;