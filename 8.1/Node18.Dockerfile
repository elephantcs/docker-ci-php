FROM elephantcs/ci-php:8.1

# Fetch & Install Node & NPM
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 18.20.3

RUN mkdir $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
  && . $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default