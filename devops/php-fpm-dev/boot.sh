#!/usr/bin/env bash

/usr/local/bin/composer.phar install -d /var/www/html
/usr/local/bin/composer.phar dump-autoload -d /var/www/html

vars='\$REMOTE_DEBUG_HOST \$REMOTE_DEBUG_PORT'

export REMOTE_DEBUG_HOST=${REMOTE_DEBUG_HOST} \
       REMOTE_DEBUG_PORT=${REMOTE_DEBUG_PORT}

envsubst "$vars" < "/usr/local/etc/php/conf.d/99-xdebug.ini.tpl" > "/usr/local/etc/php/conf.d/99-xdebug.ini"

# Wait for database
timeout 30 bash <<HEALTHCHECK
    until php /var/www/html/artisan migrate:status &>/dev/null; do
        sleep 0.1
        echo "Retry to connect to database"
    done
HEALTHCHECK

php /var/www/html/artisan migrate

php /var/www/html/artisan cache:clear
php /var/www/html/artisan view:clear
php /var/www/html/artisan route:clear
php /var/www/html/artisan clear-compiled
php /var/www/html/artisan config:cache
php /var/www/html/artisan optimize

php-fpm --allow-to-run-as-root