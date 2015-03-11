FROM rdehuyss/docker-ubuntu-14.04.2

#Add Oracle Installation Files
ADD chkconfig /sbin/chkconfig
ADD init.ora /
ADD initXETemp.ora /
ADD oracle-xe_11.2.0-1.0_amd64.debaa /
ADD oracle-xe_11.2.0-1.0_amd64.debab /
ADD oracle-xe_11.2.0-1.0_amd64.debac /
RUN cat /oracle-xe_11.2.0-1.0_amd64.deba* > /oracle-xe_11.2.0-1.0_amd64.deb
RUN chmod 755 /sbin/chkconfig

# Install Oracle
RUN dpkg --install /oracle-xe_11.2.0-1.0_amd64.deb

RUN mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts
RUN mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

RUN printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure

RUN echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/bash.bashrc
RUN echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc
RUN echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc

# Remove installation files
RUN rm /oracle-xe_11.2.0-1.0_amd64.deb*

EXPOSE 1521
EXPOSE 8080

CMD sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora; \
	service oracle-xe start;
