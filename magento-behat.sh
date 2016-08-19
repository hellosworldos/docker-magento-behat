#!/bin/bash

cd /var/www/magento
sed -i "s/{{MAGENTO_BASE_URL}}/${MAGENTOBASEURL}/g" ./behat.yml
sed -i "s/{{BEHAT_FEATURES_PATH}}/${BEHATFEATURESPATH}/g" ./behat.yml
bin/behat --init

#bin/behat