--original author primeharbor/ Chris Farris
--with changes
SELECT id, name, status,
  tags ->> 'ExecutiveOwner' as Executive_Owner,
  tags ->> 'TechnicalContact' as Technical_Contact,
  tags ->> 'DataClassification' as Data_Classification
FROM aws_organizations_account;