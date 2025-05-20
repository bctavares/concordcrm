FROM php:8.2-fpm

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    cron \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libc-client2007e-dev \
    libkrb5-dev \
    libpam0g-dev \
    libxpm-dev \
    libtool \
    autoconf \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
        --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install \
        bcmath \
        ctype \
        mbstring \
        openssl \
        pdo \
        pdo_mysql \
        tokenizer \
        curl \
        iconv \
        gd \
        fileinfo \
        dom \
        zip \
        imap

# Desbloquear funções PHP comuns e ajustar memória
RUN echo "memory_limit = 256M\n" \
    "disable_functions =" > /usr/local/etc/php/conf.d/custom.ini

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

CMD ["php-fpm"]
