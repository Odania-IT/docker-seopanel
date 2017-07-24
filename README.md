# docker-seopanel

SeoPanel Docker Version. You should extend the Docker Image with your config after first install.

## Example

Just execute

```
docker-compose up -d
```

Afterwords goto http://lvh.me:8080 and follow the install wizard with these settings:

```
Database type: Mysql
Database server hostname: mariadb
Database name: seopanel
Database username: root
Database password: testpw
```

For the next startup you can modify the docker-compose.yml and change SP_INSTALLED from false to true.


### Why is the config in environment files but i still need to make the initial setup?

Unfortunately i did not find an easy way to execute the setup. So the database migration is missing.
