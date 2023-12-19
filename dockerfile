FROM php:8.1-apache

RUN apt-get update \
    && apt-get install -y \
        libzip-dev \
        unzip \
        libonig-dev \
        libxml2-dev \
        curl \
    && docker-php-ext-install pdo_mysql zip mbstring exif pcntl bcmath opcache \
    && a2enmod rewrite

COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/storage

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-scripts --no-dev --prefer-dist --optimize-autoloader

EXPOSE 80

CMD ["apache2-foreground"]
