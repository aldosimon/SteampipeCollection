--original author primeharbor/ Chris Farris
--script to list akia
--Access key IDs beginning with AKIA are long-term credentials for an IAM user or the AWS account root user. 
select
  access_key_id,
  user_name,
  create_date,
  access_key_last_used_date,
--  _ctx ->> 'connection_name' AS account_name
from
  aws_iam_access_key
where
  status = 'Active'
ORDER BY create_date ASC;