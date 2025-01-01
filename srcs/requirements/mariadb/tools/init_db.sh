# srcs/requirements/mariadb/tools/init_db.sh
#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialisation de mysql
    mysql_install_db --datadir=/var/lib/mysql --user=mysql

    # Démarrage du service MySQL temporairement
    mysqld_safe --datadir=/var/lib/mysql --user=mysql &
    
    # Attente que MySQL soit prêt
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done

    # Configuration de la base de données
    mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Arrêt propre de MySQL
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
fi

# Démarrage de MySQL en avant-plan
exec mysqld --user=mysql --console