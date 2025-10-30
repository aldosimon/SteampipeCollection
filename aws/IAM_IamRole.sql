-- list iam role that have inline policy
--https://hub.steampipe.io/plugins/turbot/aws/tables/aws_iam_role


select
  name,
  create_date
from
  aws_iam_role
where
  inline_policies is not null;


--list attached policy
--https://hub.steampipe.io/plugins/turbot/aws/tables/aws_iam_role

select
  name,
  description,
  split_part(policy, '/', 3) as attached_policy
from
  aws_iam_role
  cross join jsonb_array_elements_text(attached_policy_arns) as policy;

--list assume_role policy for aws_iam_role
--https://stratus-red-team.cloud/user-guide/examples/#detonating-an-attack-technique

SELECT
  name,
  account_id,
  arn,
  assume_role_policy -> 'Statement' AS trust_statements
FROM
  aws_iam_role
WHERE
  -- Filter for statements that allow sts:AssumeRole
  assume_role_policy :: text LIKE '%"sts:AssumeRole"%'
ORDER BY
  name;