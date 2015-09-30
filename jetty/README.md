A jetty (9.3.3) docker image that based on minimum java 8 image.

1. Based on my minimum java 8 image.
2. I like to use --link to connect database container to jetty
   container, but java on alpine linux cannot use /etc/hosts
   without /etc/nsswitch.conf.
3. By default jetty will not process X-Forwarded- header, I
   prefer to let reverse-proxy (nginx for example) to handle SSL,
   so X-Forwarded- is required.
4. HTTP2 is not enabled yet.

To create a readonly jetty container:
   docker run -d -P --name jetty --link db:db \
          -v <tmp folder>:/tmp/jetty \
          -v <run folder>:/run/jetty \
          -v <webapps folder>:/var/lib/jetty/webapps \
          --read-only weigao/jetty
