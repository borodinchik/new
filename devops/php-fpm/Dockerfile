FROM php:7.1-fpm

RUN apt-get update \
    && apt-get install -y libpq-dev \
    libpcre3-dev \
    zlib1g-dev

RUN docker-php-ext-install \
    pdo pdo_pgsql \
    bcmath \
    mbstring \
    zip \
    opcache

RUN apt-get update \
    && apt-get install -y gettext \
    && apt-get install -y git

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin \
    && php -r "unlink('composer-setup.php');"

COPY devops/php-fpm/boot.sh           /usr/local/bin/php_boot
COPY . /var/www/html

CMD ["sh", "/usr/local/bin/php_boot"]