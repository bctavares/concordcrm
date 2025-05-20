FROM php:8.2-fpm

# Instala dependências do sistema e extensões PHP obrigatórias e recomendadas
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
    libimap-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
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

# Habilita funções PHP que podem estar desabilitadas
RUN { \
    echo "memory_limit = 256M"; \
    echo "disable_functions ="; \
    } > /usr/local/etc/php/conf.d/custom.ini

# Instala o Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

CMD ["php-fpm"]
