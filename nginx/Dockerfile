FROM alpine:latest

MAINTAINER Wei Gao<wei@gaofamily.org

ENV NGINX_VERSION nginx-1.8.0

RUN addgroup -S -g 999 nginx && adduser -S -G nginx -u 999 nginx && \
    apk --update add openssl openssl-dev pcre pcre-dev zlib zlib-dev \
    linux-headers wget build-base && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
    tar -zxvf ${NGINX_VERSION}.tar.gz && \
    cd /tmp/src/${NGINX_VERSION} && \
    ./configure \
        --prefix=/usr/share/nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx/nginx.pid \
        --lock-path=/var/run/nginx/nginx.lock \
        --http-client-body-temp-path=/var/lib/nginx/tmp/client_body \
        --http-proxy-temp-path=/var/lib/nginx/tmp/proxy \
        --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi \
        --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi \
        --http-scgi-temp-path=/var/lib/nginx/tmp/scgi \
        --user=nginx --group=nginx --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_auth_request_module \
        --with-http_spdy_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-file-aio \
        --with-ipv6 && \
    make && \
    make install && \
    apk del build-base openssl-dev pcre-dev zlib-dev linux-headers wget && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/cache/nginx && \
    mkdir -p /var/lib/nginx/tmp && \
    chown nginx:nginx /var/cache/nginx /var/lib/nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME [ "/usr/share/nginx/html", "/var/log/nginx", "/var/run/nginx", "/var/lib/nginx" ]

WORKDIR /usr/share/nginx

EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
