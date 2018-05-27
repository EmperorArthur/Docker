FROM alpine as build

RUN apk add --no-cache git
RUN git clone https://github.com/Neilpang/acme.sh.git /app

FROM alpine

EXPOSE 80/tcp

RUN apk update -f \
  && apk --no-cache add -f \
  openssl \
  coreutils \
  curl \
  socat \
  && rm -rf /var/cache/apk/*

#Where the actual acme.sh client lives
COPY --from=build /app /app
WORKDIR /app

#This contains The acme generated config, all the keys, and things like the account.json and account key
VOLUME /acme

#acme puts the final certificates and private key here for ease of use
VOLUME /ssl

#Set acme to run once per day (not at midnight exactly though)
RUN echo '23 0 * * * /app/acme.sh --cron --home "/acme" >> "/acme/acme_cron.log"'|crontab -

COPY startup.sh /app/startup.sh

#If this is set to "production", then get keys from the real LetsEncrpyt instead of their testing server
ENV IS_PRODUCTION "staging"

#Set this to determine what domains we support
#Use the form "domain1 domain2 domain3"
ENV DOMAINS ""
CMD /app/startup.sh ${DOMAINS}
