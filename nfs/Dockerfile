FROM --platform=${TARGETPLATFORM} alpine:3.19

RUN apk --no-cache add bash nfs-utils libcap \
 && rm -v /etc/idmapd.conf /etc/exports \
 && mkdir -p /var/lib/nfs/rpc_pipefs \
 && mkdir -p /var/lib/nfs/v4recovery \
 && echo "rpc_pipefs  /var/lib/nfs/rpc_pipefs  rpc_pipefs  defaults  0  0" >> /etc/fstab \
 && echo "nfsd        /proc/fs/nfsd            nfsd        defaults  0  0" >> /etc/fstab

EXPOSE 2049

# setup entrypoint
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
