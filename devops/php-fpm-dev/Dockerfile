FROM php:7.1-fpm

RUN apt-get update \
    && apt-get install -y libpq-dev \
    libpcre3-dev \
    zlib1g-dev

RUN pecl install xdebug-2.5.3 \
    && docker-php-ext-enable xdebug

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


COPY devops/php-fpm-dev/99-xdebug.ini.tpl /usr/local/etc/php/conf.d/
COPY devops/php-fpm-dev/boot.sh           /usr/local/bin/php_boot

CMD ["sh", "/usr/local/bin/php_boot"]