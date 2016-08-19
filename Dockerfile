FROM hellosworldos/webserver:wheezy

MAINTAINER widgento

VOLUME ["/var/www/magento/htdocs"]

ENV MAGENTOBASEURL "http://magento.dev/"
ENV BEHATFEATURESPATH "htdocs/features"
ENV SELENIUMDRIVERURL "http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar"

ADD composer.json /var/www/magento/composer.json
ADD magento-behat.sh /usr/local/bin/magento-behat.sh
ADD init.sh /usr/local/bin/init.sh
ADD behat.yml /var/www/magento/behat.yml

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y \
    openjdk-7-jre \
    && chmod +x /usr/local/bin/magento-behat.sh \
    && cd /var/www/magento \
    && mkdir -p /opt/selenium \
    && export SELENIUMDRIVERFILE=${SELENIUMDRIVERURL##*/} \
    && cd /opt/selenium \
    && wget $SELENIUMDRIVERURL \
    && ln -s "/opt/selenium/${SELENIUMDRIVERFILE}" /usr/local/bin/selenium-server-standalone.jar \
    && composer install --prefer-dist

CMD ["/usr/local/bin/init.sh"]
