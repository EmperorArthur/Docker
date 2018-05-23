# HTTPS reverse proxy

This takes incoming https connections, and passes them off to internal sites based on rules files.

### Redirect Rules:
These files are named `something.conf.nginx` look like:
```
location /test/ {
    proxy_pass http://Docker_Compose_Container_Name/;
}

```

### SSL Keys

This container requires that two ssl keys be provided:
* The ssl certificate file: "/ssl/fullchain.cer"
* The ssl key file: "/ssl/site.key

The container **will not** start without these two files.
However, it will automatically reload whenever those files are changed.

#TODO: Reload when a reload file is added or `touch`ed
