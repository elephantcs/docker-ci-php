for PHP_VERSION_DIR in *; do
  PHP_VERSION=$(basename "$PHP_VERSION_DIR")

  # Check if it's a valid PHP version
  if ! [[ "$PHP_VERSION" =~ ^[7,8]\.[0-9]$ ]]; then
    continue;
  fi

  EXACT_PHP_VERSION=$(grep "apt-get install -y php${PHP_VERSION}=" "${PHP_VERSION}/Dockerfile" | sed -E "s~.+(${PHP_VERSION}.[0-9]+).+~\1~g")
  if ! [[ "$EXACT_PHP_VERSION" =~ ^[7,8]\.[0-9].[0-9]+$ ]]; then
    echo "Failed to find exact PHP version for: ${PHP_VERSION}";
    continue;
  fi

  echo "=== Commands for PHP ${PHP_VERSION}";
  echo "cd ${PHP_VERSION} && docker build -t elephantcs/ci-php:${PHP_VERSION} -t elephantcs/ci-php:${EXACT_PHP_VERSION} . && docker push elephantcs/ci-php:${PHP_VERSION} && docker push elephantcs/ci-php:${EXACT_PHP_VERSION}"
done