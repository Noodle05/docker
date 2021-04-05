FROM alpine:3.13

RUN apk --no-cache --no-progress add stress-ng
ADD entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/bin/stress-ng" ]
