FROM nginx:alpine

RUN mkdir /etc/nginx/locations/
VOLUME /etc/nginx/locations/

#nginx uses:
#ssl_certificate "/ssl/fullchain.cer";
#ssl_certificate_key "/ssl/site.key";
RUN mkdir -p /ssl/
VOLUME /ssl/

RUN rm /etc/nginx/conf.d/*
VOLUME /etc/nginx/conf.d/

EXPOSE 443

COPY reload.sh /
COPY startup.sh /

COPY proxy.conf.nginx /etc/nginx/nginx.conf

CMD ["/startup.sh"]
