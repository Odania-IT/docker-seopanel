# docker-seopanel

SeoPanel Docker Version. You should extend the Docker Image with your config after first install.

## Example

Go to the "test" folder and execute

```
docker-compose up -d
```

Afterwords goto http://lvh.me:8080 and follow the install wizzard with these settings:

```
Database Type: Mysql
Database Host: mariadb
Database Name: seopanel
Database User: root
Database Password: testpw
```

You can set the rest to your own preferences.

Afterwords you get into seo panel. Now you can retrieve the sp-config.php with the following command:

```
docker exec -ti test_seopanel_1 cat /var/www/html/config/sp-config.php
```

If you copy the content of the file to the test/sp-config.php you have a working image.
You should copy the modified contents of "test" to your own repository and build your image from there.
