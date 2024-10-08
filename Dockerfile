#FROM	ubuntu:18.04
#FROM	ubuntu:20.04
#FROM	ubuntu:22.04
FROM	ubuntu


ENV DEBIAN_FRONTEND noninteractive

RUN	apt-get update && \
      apt-get install -y  unzip wget hercules mc screen && \
      cd /opt && \
      mkdir hercules && \
      cd hercules && \
      mkdir config && \
      cd config && \
      wget http://www.smrcc.org.uk/members/g4ugm/vm-370/vm370sixpack-1_3.zip && \
      unzip vm370sixpack-1_3.zip && \
      rm vm370sixpack-1_3.zip && \
      sed -i s/Disks/disks/g sixpack.conf && \
      sed -i s/Shadow/shadow/g sixpack.conf && \
      sed -i "s/0009/# 0009/g" sixpack.conf && \
      sed -i "s/# 0010/0010/g" sixpack.conf && \
      echo "HTTPPORT       8038" >> /opt/hercules/config/sixpack.conf && \
      echo "#!/bin/bash" > start.sh && \
      echo "cd /opt/hercules/config" >> start.sh && \
      echo "/usr/bin/screen -dm -S herc hercules -f sixpack.conf" >> start.sh && \
      echo "/bin/sh" >> start.sh && \
      chmod 755 start.sh && \
      apt-get -y autoclean && apt-get -y autoremove && \
      apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
      rm -rf /var/lib/apt/lists/*

EXPOSE      3270 8038
WORKDIR     /opt/hercules/config
ENTRYPOINT  ["/opt/hercules/config/start.sh"]
