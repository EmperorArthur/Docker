#!/usr/bin/env sh
#This just runs acme the first time, and then waits while watching the logfile so the docker container does not exit immediately

ACME_HOME_FOLDER="/acme"
ACME_SITE_FOLDER="/ssl"

mkdir -p "$ACME_HOME_FOLDER"
mkdir -p "$ACME_SITE_FOLDER"

#Append '-d' to every domain passed in
DOMAINS_INTERNAL=""
for domain in $@
do
	DOMAINS_INTERNAL="$DOMAINS_INTERNAL -d $domain"
done

#Set the staging flag unless IsProduction is "production"
STAGING="--staging"
if [ "$IS_PRODUCTION" = "production" ]; then
    echo "Running in production mode!"
    STAGING=""
fi

#Can't exit immediately if a command fails since acme.sh returns 2 if the keys already exist
#echo the command being run (with variables substituted)
set -x

./acme.sh \
    --issue \
    --standalone \
    --home "$ACME_HOME_FOLDER"\
    --reloadcmd "touch $ACME_SITE_FOLDER/reload" \
    --cert-file "$ACME_SITE_FOLDER/site.cer" \
    --key-file "$ACME_SITE_FOLDER/site.key" \
    --ca-file "$ACME_SITE_FOLDER/ca.cer" \
    --fullchain-file "$ACME_SITE_FOLDER/fullchain.cer" \
    $STAGING \
    $DOMAINS_INTERNAL \
    $EXTRA_ARGUMENTS

retval=$?
set +x

if [ ${retval} -ne 0 ]; then
    if [ ${retval} -ne 2 ]; then
    echo "acme.sh failed! Returned: $retval"
    exit ${retval}
    fi
fi

set -ex

crond
echo "" > "$ACME_HOME_FOLDER/acme_cron.log"
exec tail -F "$ACME_HOME_FOLDER/acme_cron.log"
