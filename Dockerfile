FROM rdehuyss/docker-ubuntu-14.04.2

#Add Oracle Installation Files
ADD chkconfig /sbin/chkconfig
ADD init.ora /
ADD initXETemp.ora /
ADD oracle-xe_11.2.0-1.0_amd64.debaa /
ADD oracle-xe_11.2.0-1.0_amd64.debab /
ADD oracle-xe_11.2.0-1.0_amd64.debac /
RUN chmod 755 /sbin/chkconfig

# Concat binaries && Install Oracle
RUN cat /oracle-xe_11.2.0-1.0_amd64.deba* > /oracle-xe_11.2.0-1.0_amd64.deb && \
	dpkg --install /oracle-xe_11.2.0-1.0_amd64.deb && \
	rm /oracle-xe_11.2.0-1.0_amd64.deb*

RUN mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts && \
	mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

RUN printf 8080\\n1521\\nadmin\\nadmin\\ny\\n | /etc/init.d/oracle-xe configure

RUN echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/bash.bashrc && \
	echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc && \
	echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc

# Remove tmp files
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 1521
EXPOSE 8080

CMD sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora; \
	service oracle-xe start; \
	/usr/sbin/sshd -D
