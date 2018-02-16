FROM	ubuntu:16.04

RUN	apt-get update && \
      apt-get install -y  unzip wget hercules mc screen && \
      cd /opt && \
      mkdir hercules && \
      cd hercules && \
      mkdir vm370 && \
      cd vm370 && \
      wget http://www.smrcc.org.uk/members/g4ugm/vm-370/vm370sixpack-1_2.zip && \
      unzip vm370sixpack-1_2.zip && \
      rm vm370sixpack-1_2.zip && \
      sed -i s/Disks/disks/g sixpack.conf && \
      sed -i s/Shadow/shadow/g sixpack.conf && \
      sed -i "s/0009/# 0009/g" sixpack.conf && \
      sed -i "s/# 0010/0010/g" sixpack.conf && \
      echo "HTTPPORT       8038" >> /opt/hercules/vm370/sixpack.conf && \
      apt-get -y autoclean && apt-get -y autoremove && \
      echo "#!/bin/bash" > start_vm370.sh && \
      echo "cd /opt/hercules/vm370"  >> start_vm370.sh && \
      echo "hercules -f sixpack.conf > Log.txt"  >> start_vm370.sh && \
      chmod 755 start_vm370.sh && \
      apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
      rm -rf /var/lib/apt/lists/*

EXPOSE      3270 8038
WORKDIR     /opt/hercules/vm370
ENTRYPOINT  ["/opt/hercules/vm370/start_vm370.sh"]
#ENTRYPOINT  ["/usr/bin/screen","-dm","-S","herc","./start_vm370.sh"]
