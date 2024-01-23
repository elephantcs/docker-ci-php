FROM ubuntu:20.04

ENV TZ=Europe/Amsterdam

RUN export LC_ALL=C.UTF-8
RUN DEBIAN_FRONTEND=noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y \
    sudo \
    autoconf \
    autogen \
    language-pack-en-base \
    wget \
    zip \
    unzip \
    curl \
    rsync \
    ssh \
    openssh-client \
    git \
    build-essential \
    apt-utils \
    software-properties-common \
    nasm \
    libjpeg-dev \
    libpng-dev \
    libpng16-16

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# PHP
RUN LC_ALL=en_US.UTF-8 \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php8.2=8.2.15-1+ubuntu20.04.1+deb.sury.org+1
RUN apt-get install -y \
    php8.2-curl \
    php8.2-gd \
    php8.2-dev \
    php8.2-xml \
    php8.2-bcmath \
    php8.2-mysql \
    php8.2-pgsql \
    php8.2-mbstring \
    php8.2-zip \
    php8.2-bz2 \
    php8.2-sqlite \
    php8.2-soap \
    php8.2-intl \
    php8.2-imap \
    php8.2-imagick \
    php-memcached
RUN update-alternatives --set php /usr/bin/php8.2 \
    && command -v php

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update
RUN command -v composer

# Other
RUN mkdir ~/.ssh
RUN touch ~/.ssh_config

# Display versions installed
RUN php -v
RUN composer --version
