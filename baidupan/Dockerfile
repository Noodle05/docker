FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt

RUN curl -L -o /tmp/baidunetdisk.deb "https://issuecdn.baidupcs.com/issue/netdisk/LinuxGuanjia/3.5.0/baidunetdisk_3.5.0_amd64.deb" \
 && dpkg -i /tmp/baidunetdisk.deb \
 && rm -f /tmp/baidunetdisk.deb

VOLUME [ "/root/Downloads" ]
