FROM hellosworldos/webserver:wheezy

MAINTAINER widgento

VOLUME ["/var/www/magento/htdocs"]

ENV MAGENTOBASEURL "http://magento.dev/"
ENV BEHATFEATURESPATH "htdocs/features"
ENV SELENIUMDRIVERURL "http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar"

ADD composer.json /var/www/magento/composer.json
ADD magento-behat.sh /opt/widgento/magento-behat/magento-behat.sh
ADD init.sh /opt/widgento/magento-behat/init.sh
ADD behat.yml /var/www/magento/behat.yml
ADD /etc/supervisor/conf.d/selenium.conf /etc/supervisor/conf.d/selenium.conf

RUN apt-get update --fix-missing \
    && apt-get -y upgrade \
    && apt-get install -y \
    openjdk-7-jre \
    && chmod +x /opt/widgento/magento-behat/*.sh \
    && mkdir -p /opt/selenium \
    && export SELENIUMDRIVERFILE=${SELENIUMDRIVERURL##*/} \
    && cd /opt/selenium \
    && wget $SELENIUMDRIVERURL \
    && ln -s "/opt/selenium/${SELENIUMDRIVERFILE}" /usr/local/bin/selenium-server-standalone.jar

RUN cd /var/www/magento \
    && composer install --prefer-dist

CMD ["/opt/widgento/magento-behat/init.sh"]
