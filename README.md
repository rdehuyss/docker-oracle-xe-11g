docker-oracle-xe-11g
============================

Dockerfile based on wnameless/docker-oracle-xe-11g and updated for Ubuntu 14.04.2 LTS
Oracle Express Edition 11g Release 2 on Ubuntu 14.04.2 LTS

### Installation
```
docker pull rdehuyss/oracle-xe-11g
```

Run with 22 and 1521 ports opened:
```
docker run -d -p 49160:22 -p 49161:1521 rdehuyss/oracle-xe-11g
```

Connect database with following setting:
```
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
```

Password for SYS & SYSTEM
```
oracle
```

Login by SSH
```
ssh root@localhost -p 49160
password: admin
```
