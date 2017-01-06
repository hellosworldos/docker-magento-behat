FROM hellosworldos/webserver:wheezy

MAINTAINER widgento

VOLUME ["/var/www/magento/htdocs"]

ENV MAGENTOBASEURL "http://magento.dev/"
ENV BEHATFEATURESPATH "/var/www/magento/htdocs/features"
ENV SELENIUMDRIVERURL "http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar"
ENV NODEJSVERSION "6.x"

ADD composer.json /var/www/magento/composer.json
ADD magento-behat.sh /opt/widgento/magento-behat/magento-behat.sh
ADD init.sh /opt/widgento/magento-behat/init.sh
ADD behat.yml /var/www/magento/behat.yml
ADD /etc/supervisor/conf.d/selenium.conf /etc/supervisor/conf.d/selenium.conf

RUN chmod +x /opt/widgento/magento-behat/*.sh

# Install Selenium Driver
RUN apt-get update --fix-missing \
    && apt-get -y upgrade \
    && apt-get install -y \
    openjdk-7-jre \
    && mkdir -p /opt/selenium \
    && export SELENIUMDRIVERFILE=${SELENIUMDRIVERURL##*/} \
    && cd /opt/selenium \
    && wget $SELENIUMDRIVERURL \
    && ln -s "/opt/selenium/${SELENIUMDRIVERFILE}" /usr/local/bin/selenium-server-standalone.jar

# Install Zombie Driver
RUN apt-get update --fix-missing \
    && apt-get -y upgrade \
    && curl -sL https://deb.nodesource.com/setup_{$NODEJSVERSION} | bash - \
    && apt-get install -y \
    nodejs \
    build-essential \
    && npm install -g zombie \
    && echo "export NODE_PATH=$(npm root -g)" >> /root/.bashrc

# Install Behat Mink
RUN cd /var/www/magento \
    && composer install --prefer-dist

CMD ["/opt/widgento/magento-behat/init.sh"]
