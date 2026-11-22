FROM php:8.6-fpm

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl zip unzip libonig-dev libzip-dev lp-solve \
  && docker-php-ext-install mbstring zip \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN curl -fsSL https://github.com/Kerigard/lp-solve-php-docker/archive/8.x.tar.gz -o lp-solve.tar.gz \
  && tar -xf lp-solve.tar.gz -C /tmp --strip-components=1 \
  && rm lp-solve.tar.gz \
  && docker-php-ext-install /tmp/lp-solve/extra/PHP \
  && rm -r /tmp/lp-solve
