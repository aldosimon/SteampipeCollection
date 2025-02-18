--steampipe samples github

select
  'https://' || name || '.s3.' || region || '.amazonaws.com/' as url
from
  aws_s3_bucket
where 
  bucket_policy_is_public is True;

-- see if this needs adjusments, format of an S3 URL is:
-- https://bucket-name.s3.region-code.amazonaws.com/key-name