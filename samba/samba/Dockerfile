FROM alpine:3.10
LABEL maintainer="Wei Gao <wei@gaofamily.org>"

ARG CONFIG_FILE="/etc/samba/smb.conf"

# Install samba
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash samba shadow tini && \
    adduser -D -G users -H -S -g 'Samba User' -h /tmp smbuser && \
    sed -i 's|^;* *\(log file = \).*|   \1/dev/stdout|' $CONFIG_FILE && \
    sed -i 's|^;* *\(load printers = \).*|   \1no|' $CONFIG_FILE && \
    sed -i 's|^;* *\(printcap name = \).*|   \1/dev/null|' $CONFIG_FILE && \
    sed -i 's|^;* *\(printing = \).*|   \1bsd|' $CONFIG_FILE && \
    sed -i 's|^;* *\(unix password sync = \).*|   \1no|' $CONFIG_FILE && \
    sed -i 's|^;* *\(preserve case = \).*|   \1yes|' $CONFIG_FILE && \
    sed -i 's|^;* *\(short preserve case = \).*|   \1yes|' $CONFIG_FILE && \
    sed -i 's|^;* *\(default case = \).*|   \1lower|' $CONFIG_FILE && \
    sed -i '/Share Definitions/,$d' $CONFIG_FILE && \
    echo '   pam password change = yes' >>$CONFIG_FILE && \
    echo '   map to guest = bad user' >>$CONFIG_FILE && \
    echo '   usershare allow guests = yes' >>$CONFIG_FILE && \
    echo '   create mask = 0664' >>$CONFIG_FILE && \
    echo '   force create mode = 0664' >>$CONFIG_FILE && \
    echo '   directory mask = 0775' >>$CONFIG_FILE && \
    echo '   force directory mode = 0775' >>$CONFIG_FILE && \
    echo '   force user = smbuser' >>$CONFIG_FILE && \
    echo '   force group = users' >>$CONFIG_FILE && \
    echo '   follow symlinks = yes' >>$CONFIG_FILE && \
    echo '   load printers = no' >>$CONFIG_FILE && \
    echo '   printing = bsd' >>$CONFIG_FILE && \
    echo '   printcap name = /dev/null' >>$CONFIG_FILE && \
    echo '   disable spoolss = yes' >>$CONFIG_FILE && \
    echo '   socket options = TCP_NODELAY' >>$CONFIG_FILE && \
    echo '   strict locking = no' >>$CONFIG_FILE && \
    echo '   vfs objects = acl_xattr catia fruit recycle streams_xattr' \
                >>$CONFIG_FILE && \
    echo '   recycle:keeptree = yes' >>$CONFIG_FILE && \
    echo '   recycle:versions = yes' >>$CONFIG_FILE && \
    echo '' >>$CONFIG_FILE && \
    echo '   # Security' >>$CONFIG_FILE && \
    echo '   client ipc max protocol = default' >>$CONFIG_FILE && \
    echo '   client max protocol = default' >>$CONFIG_FILE && \
    echo '   server max protocol = SMB3' >>$CONFIG_FILE && \
    echo '   client ipc min protocol = default' >>$CONFIG_FILE && \
    echo '   client min protocol = CORE' >>$CONFIG_FILE && \
    echo '   server min protocol = SMB2' >>$CONFIG_FILE && \
    echo '' >>$CONFIG_FILE && \
    echo '   # Time Machine' >>$CONFIG_FILE && \
    echo '   durable handles = yes' >>$CONFIG_FILE && \
    echo '   kernel oplocks = no' >>$CONFIG_FILE && \
    echo '   kernel share modes = no' >>$CONFIG_FILE && \
    echo '   posix locking = no' >>$CONFIG_FILE && \
    echo '   fruit:aapl = yes' >>$CONFIG_FILE && \
    echo '   fruit:advertise_fullsync = true' >>$CONFIG_FILE && \
    echo '   fruit:time machine = yes' >>$CONFIG_FILE && \
    echo '   smb2 leases = yes' >>$CONFIG_FILE && \
    echo '' >>$CONFIG_FILE && \
    rm -rf /tmp/*

COPY samba.sh /usr/bin/

EXPOSE 137/udp 138/udp 139 445

HEALTHCHECK --interval=60s --timeout=15s \
             CMD smbclient -L '\\localhost' -U '%' -m SMB3

VOLUME ["/etc/samba"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
