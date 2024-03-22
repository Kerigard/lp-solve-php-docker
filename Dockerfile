FROM php:8.3-fpm

RUN apt-get update && apt-get install -y curl zip lp-solve

RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN curl -fsSL https://github.com/Kerigard/lp-solve-php-docker/archive/8.x.tar.gz -o lp-solve.tar.gz \
  && tar -xf lp-solve.tar.gz -C /tmp --strip-components=1 \
  && rm lp-solve.tar.gz \
  && docker-php-ext-configure /tmp/lp-solve/extra/PHP \
  && docker-php-ext-install /tmp/lp-solve/extra/PHP \
  && rm -r /tmp/lp-solve
