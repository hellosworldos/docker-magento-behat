FROM hellosworldos/webserver:wheezy

MAINTAINER widgento

VOLUME ["/var/www/magento/features"]
VOLUME ["/var/www/magento/htdocs"]

ADD composer.json /var/www/magento/composer.json

