#!/bin/bash

/usr/local/bin/magento-behat.sh && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf