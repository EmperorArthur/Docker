#Simple acme client
This is used to obtain and automatically renew LetsEncrypt SSL certificates.

# Environment Variables

## Domains:
Set the `DOMAINS` enviornoment variable to a list of domains to be renewed, separated by spaces.
For example: "domain1 domain2 domain3".

## IS_PRODUCTION:
Set the `IS_PRODUCTION` environment variable to "production" to obtain real keys from the server.
By default testing keys are obtained.

## EXTRA_ARGUMENTS
Set the `EXTRA_ARGUMENTS` environment variable to whatever extra arguments you want to pass to the acme.sh script.
This is useful to add something like "--force" to force a renewal.
