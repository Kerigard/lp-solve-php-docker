FROM php:7.4-fpm

RUN sed -i '/debian.org/s/^/#/' /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian bullseye main" >> /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl zip unzip lp-solve \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN curl -fsSL https://github.com/Kerigard/lp-solve-php-docker/archive/7.x.tar.gz -o lp-solve.tar.gz \
  && tar -xf lp-solve.tar.gz -C /tmp --strip-components=1 \
  && rm lp-solve.tar.gz \
  && docker-php-ext-configure /tmp/lp-solve/extra/PHP \
  && docker-php-ext-install /tmp/lp-solve/extra/PHP \
  && rm -r /tmp/lp-solve
