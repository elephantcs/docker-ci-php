FROM elephantcs/ci-php:8.2

# Fetch & Install Node & NPM
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 20.11.0

RUN mkdir $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
  && . $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default