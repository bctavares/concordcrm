FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    cron \
    git \
    unzip \
    libzip-dev \
    zip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libmcrypt-dev \
    libssl-dev \
    libmagickwand-dev \
    libimap-dev \
    && docker-php-ext-install \
    bcmath ctype mbstring openssl pdo pdo_mysql tokenizer curl iconv gd fileinfo dom zip \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap



CMD ["php-fpm"]
