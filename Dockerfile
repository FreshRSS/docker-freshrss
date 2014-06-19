FROM centos:centos6
MAINTAINER Marien Fressinaud <dev@marienfressinaud.fr>

# Install packages
RUN yum update -y
RUN yum install -y vim httpd mysql-server php php-mysql php-pdo php-xml

# Configure the database
ADD init.sh /tmp/init.sh
ADD dump_freshrss.sql /tmp/dump_freshrss.sql
RUN chmod 775 /tmp/init.sh
RUN service mysqld start ; ./tmp/init.sh ; service mysqld stop
RUN rm /tmp/dump_freshrss.sql
RUN rm /tmp/init.sh

# apache user has UID 1000 and GID 100
# You may have to change these values to match with your current "host" user
RUN usermod -u 1000 -g 100 apache

ADD start.sh /start.sh

ENTRYPOINT ["/bin/bash", "-e", "/start.sh"]

EXPOSE 80
