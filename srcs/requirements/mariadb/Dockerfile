# srcs/requirements/mariadb/Dockerfile
FROM debian:buster

# Installation des paquets nécessaires
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copie des fichiers de configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/init_db.sh /usr/local/bin/

# Configuration des permissions
RUN chmod +x /usr/local/bin/init_db.sh

# Configuration de MariaDB pour écouter sur toutes les interfaces
RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

CMD ["sh", "/usr/local/bin/init_db.sh"]
