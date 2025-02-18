--https://steampipe.io/blog/aws-trusts
/*
Another key third-party trust relationship is via IAM Role cross-account trusts. With AWS IAM, you can grant other AWS customers access to perform actions in your account. Obviously, this has third-party risk-management implications, and all third-party access should be reviewed.
Within an AWS organization, there are often a lot of cross-account trusts. Various accounts are created to audit configuration, write logs, perform auto-remediation tasks, or deploy resources via a centralized pipeline. These are not third-party risks and should be excluded from any list of foreign AWS accounts in your organization.
The following query will pull a list of foreign AWS accounts that are trusted across your AWS organization:
*/

/*
The above two queries provide you a list of the 12-digit account IDs, but that doesn’t tell you who they are. AWS doesn’t publish a list of known account IDs, but the cloud security community does. The CloudMapper project from Duo has a yaml file with a number of known AWS accounts. With the config plugin you can query this resource. First install the Steampipe Config plugin, then create a connection in the config.spc file that looks like this:
https://steampipe.io/blog/aws-trusts
*/


WITH org_accounts AS (
  SELECT
    id
  FROM
    aws_payer.aws_organizations_account
),
roles AS (
  SELECT
    name,
    (regexp_match(principals, ':([0-9]+):')) [ 1 ] AS trusted_account,
    _ctx ->> 'connection_name' AS account_name
  FROM
    aws_iam_role AS role,
    jsonb_array_elements(role.assume_role_policy_std -> 'Statement') AS statement,
    jsonb_array_elements_text(statement -> 'Principal' -> 'AWS') AS principals
)
SELECT
  roles.name as role_name,
  roles.account_name,
  roles.trusted_account
FROM
  org_accounts
  RIGHT JOIN roles ON org_accounts.id = roles.trusted_account
WHERE
  org_accounts.id IS NULL