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
    apt-get install -y php8.1=8.1.29-1+ubuntu20.04.1+deb.sury.org+1
RUN apt-get install -y \
    php8.1-curl \
    php8.1-gd \
    php8.1-dev \
    php8.1-xml \
    php8.1-bcmath \
    php8.1-mysql \
    php8.1-pgsql \
    php8.1-mbstring \
    php8.1-zip \
    php8.1-bz2 \
    php8.1-sqlite \
    php8.1-soap \
    php8.1-intl \
    php8.1-imap \
    php8.1-imagick \
    php-memcached
RUN update-alternatives --set php /usr/bin/php8.1 \
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
