-- this is based off https://rootcat.de/blog/thecatflap
-- there could be a role with privilege access and an unknown user that can assume the role.
-- catflap example for the role is AWSControlTowerExecution which is a role that is used by AWS Control Tower to perform operations in the management account.
-- this script shows name of the role, attached policy arns, action and principal that can assume the role.
-- use this with IAM_AllTrustedAccount.sql to see if you know the user that is allowed to assume the role.

SELECT
    name,
    -- see if there is policy that gives administrator access or the like here.
    attached_policy_arns,
    jsonb_array_elements(assume_role_policy['Statement'])->>'Action' as action,
    -- see which user allowed to assume role here
    jsonb_array_elements(assume_role_policy['Statement'])->>'Principal' as principal
FROM
    aws_iam_role;
