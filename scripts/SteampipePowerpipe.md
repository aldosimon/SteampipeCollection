# summary
Powerpipe bring compliance benchmarks, dashboards and visualisation to steampipe.
 
# preparation
## install powerpipe
`sudo /bin/sh -c "$(curl -fsSL https://powerpipe.io/install/powerpipe.sh)"`

## install steampipe
`sudo /bin/sh -c "$(curl -fsSL https://steampipe.io/install/steampipe.sh)"`

## configure credentials

see how to [here](https://hub.steampipe.io/plugins/turbot/aws#configuring-aws-credentials)

## install steampipe aws plugin
`steampipe plugin install aws`

## start steampipe
`steampipe service start`

## test connection with powerpipe
`powerpipe query run "select title from aws_account"`

# visualise cloud infrastructure

## create directory
```bash
mkdir powerpipeSteampipe
cd powerpipeSteampipe
```

## init mod
`powerpipe mod init`

## install mod
`powerpipe mod install github.com/turbot/steampipe-mod-aws-insights`

## start server
`powerpipe server`



