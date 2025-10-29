-- made with a lot of AI, will fix later
-- get identity_store_id

SELECT
  identity_store_id,
  arn
FROM
  aws_ssoadmin_instance;


-- list sso users

SELECT
  display_name,
  id AS user_id,
  emails -> 0 ->> 'Value' AS primary_email,
  identity_store_id,
  locale,
  timezone
FROM
  aws_identitystore_user
WHERE
  identity_store_id = '$identitystoreid' -- Required filter
ORDER BY
  display_name;

-- with groupname  
  
SELECT
  u.display_name AS user_name,
  g.name AS group_name,
  u.id AS user_id,
  g.id AS group_id
FROM
  aws_identitystore_user AS u
INNER JOIN
  aws_identitystore_group_membership AS m
  ON u.id = m.member_id
INNER JOIN
  aws_identitystore_group AS g
  ON m.group_id = g.id
WHERE
  u.identity_store_id = '$identitystoreid'
  AND g.identity_store_id = '$identitystoreid'
  AND m.identity_store_id = '$identitystoreid'
ORDER BY
  u.display_name,
  g.name;
  
  
  
  