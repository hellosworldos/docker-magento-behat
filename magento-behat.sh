#!/bin/bash

cd /var/www/magento
sed -i "s/{{MAGENTO_BASE_URL}}/${MAGENTO_BASE_URL}/g" ./behat.yml
sed -i "s/{{BEHAT_FEATURES_PATH}}/${BEHAT_FEATURES_PATH}/g" ./behat.yml
bin/behat --init
bin/behat