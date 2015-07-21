FROM centos:7
MAINTAINER Noel Jarencio <njarencio@gmail.com>

RUN yum update -y
RUN yum install -y epel-release
RUN yum clean all

# Install httpd
RUN yum install -y httpd

# Install mysql
RUN yum install -y mysql mysql-server 

# Install supervisor 
RUN yum install -y python-setuptools
RUN easy_install supervisor

# Install php
RUN yum install -y php php-mysql php-gd php-fpm php-mcrypt php-mbstring

RUN yum install -y wget

# Download and use browscap
RUN wget -q http://browscap.org/stream?q=Lite_PHP_BrowsCapINI -O /var/www/browscap.ini

ADD configs/supervisord.conf /etc/
ADD configs/php.ini /etc/
ADD configs/httpd.conf /etc/httpd/conf/

# Add our source code
ADD app /var/www/html/

EXPOSE 80

CMD ["supervisord", "-n"]
