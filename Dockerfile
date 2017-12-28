FROM	ubuntu:16.04

RUN	apt-get update && \
      apt-get install -y  unzip wget hercules && \
      cd /opt && \
      mkdir hercules && \
      cd hercules && \
      mkdir vm370 && \
      cd vm370 && \
      wget http://www.smrcc.org.uk/members/g4ugm/vm-370/vm370sixpack-1_2.zip && \
      unzip vm370sixpack-1_2.zip && \
      apt-get -y autoclean && apt-get -y autoremove && \
      apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g) && \
      rm -rf /var/lib/apt/lists/*

EXPOSE      3270 8038
WORKDIR     /opt/hercules/vm370
ENTRYPOINT  ["/opt/hercules/vm370/hercules -f sixpack.conf > Log.txt"]
