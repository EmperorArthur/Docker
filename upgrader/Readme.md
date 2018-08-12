# HTTP Upgrader

This upgrades insecure requests (http) to secure ones (https).
It also supports obtaining ssl certificates via the ACME client.

# LetsEncrypt ACME Client

This obtains and automatically renews SSL certificates from LetsEncrypt.

## Environment variables:
    Environment variables are used to determine what certificates are obtained from LetsEncrypt
    Remember that each subdomain requires a seperate entry.
    Set the domains in a docker compose file like this:
    `- DOMAINS=test.site1.com site1.com www.site1.com site2.com ...`

    In addition, an 'IS_PRODUCTION' environment variable must be set to obtain production certificates.
    By Default, the client accesses LetsEncrypt's test servers.  These allow for testing, but do not provide valid certificates.
    To obtain certificates that browsers trust, add this line to a docker composer file:
    `- IS_PRODUCTION=production`
