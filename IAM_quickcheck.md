# About

## run credential report first

```bash
aws iam generate-credential-report
```

## does the root account accessed recently

```SQL
select
  user_name,
  password_last_used,
  age(date(current_timestamp), date(password_last_used)) as pw_last_used
from
  aws_iam_credential_report
where
  user_name = '<root_account>';
```

## is root MFA enabled

```SQL
select
  user_name,
  mfa_active
from
  aws_iam_credential_report
where
  user_name = '<root_account>';

```

## Is MFA enabled for all users

```SQL
select
  user_name,
  mfa_active
from
  aws_iam_credential_report
where
  not mfa_active;

```

## Does the root account have access keys enabled

```SQL
select
  user_name,
  access_key_1_active,
  access_key_2_active
from
  aws_iam_credential_report
where
  user_name = '<root_account>';

```

## users with unused access keys

```SQL
select
  user_name,
  access_key_1_last_used_date,
  age(
    date(current_timestamp),
    date(access_key_1_last_used_date)
  ) as key1_last_used,
  access_key_2_last_used_date,
  age(
    date(current_timestamp),
    date(access_key_2_last_used_date)
  ) as key2_last_used
from
  aws_iam_credential_report
where
  (
    access_key_1_active
    and (
      access_key_1_last_used_date is null
      or (
        date(current_timestamp) - date(access_key_1_last_used_date)
      ) > 30
    )
  )
  or (
    access_key_2_active
    and (
      access_key_2_last_used_date is null
      or(
        date(current_timestamp) - date(access_key_2_last_used_date)
      ) > 30
    )
  );

```

## Are there any users with access keys and console credentials? 

Users should either be console users or API users, not both; check for users with both console credentials and programmatic credentials (access keys).

```SQL
select
  user_name,
  password_enabled,
  access_key_1_active,
  access_key_2_active
from
  aws_iam_credential_report
where
  password_enabled
  and (
    access_key_1_active
    or access_key_2_active
  );

```

## Find any users with passwords that have not been rotated

```SQL
select
  user_name,
  password_last_changed,
  age(
    date(current_timestamp),
    date(password_last_changed)
  ) as pw_last_changed
from
  aws_iam_credential_report
where
  user_name != '<root_account>'
  and password_enabled
  and (
    date(current_timestamp) - date(password_last_changed)
  ) > 90;

```