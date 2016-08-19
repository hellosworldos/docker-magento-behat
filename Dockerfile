FROM hellosworldos/webserver:wheezy

MAINTAINER widgento

VOLUME ["/var/www/magento/htdocs"]

ENV MAGENTO_BASE_URL "http://magento.dev/"
ENV BEHAT_FEATURES_PATH "htdocs/features"

ADD composer.json /var/www/magento/composer.json
ADD magento-behat.sh /usr/local/bin/magento-behat.sh
ADD behat.yml /var/www/magento/behat.yml

RUN chmod +x /usr/local/bin/magento-behat.sh \
    && cd /var/www/magento \
    && composer install --prefer-dist

#CMD ["/usr/local/bin/magento-behat.sh"]