# widgento/magento-behat
Container to run behat tests on magento1

Uses [MageTest/BehatMage](https://github.com/MageTest/BehatMage) as base to create magento scenarios/

#### List of installed drivers

* Goutte
* Zombie
* Selenium

#### Pulling docker image

```bash
docker pull widgento/magento-behat
```

#### Example docker-compose configuration

```yaml
magentodb:
  image: mysql
  volumes:
    - ./var/lib/mysql:/var/lib/mysql
  expose:
    - 3306
  environment:
    MYSQL_USER: magento
    MYSQL_PASS: magento
    MYSQL_DBNAME: magento
    MYSQL_DATABASE: magento
    MYSQL_PASSWORD: magento
    MYSQL_ROOT_PASSWORD: magento

magentoapp:
  image: widgento/magento-debug
  links:
    - magentodb:db
  expose:
    - 80
    - 443
  environment:
    WORKSPACE: /var/www/magento/repo_volume
    MAGENTO_DB_HOST: db
    MAGENTO_DB_USER: magento
    MAGENTO_DB_PASS: magento
    MAGENTO_DB_NAME: magento
    VIRTUAL_HOST: magento.dev
  volumes:
    - ./htdocs:/var/www/magento/repo_volume
    - ./shared/media:/var/www/magento/shared/media
    - ./shared/var:/var/www/magento/shared/var

magentobehat:
  image: widgento/magento-behat
  name: 
  links:
    - magentodb:db
    - magentoapp:magento.dev
  environment:
    MAGENTOBASEURL: http://magento.dev/
    BEHATFEATURESPATH: /var/www/magento/htdocs/features
  volumes:
    - ./htdocs:/var/www/magento/htdocs
```

#### Run behat tests

On existing container with name `magento_magentobehat_1`

```yaml
docker exec -it magento_magentobehat_1 bash -c "cd /var/www/magento && ./bin/behat"
```