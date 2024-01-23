# Store possible args
TOTAL_ARGS=$#
INCLUDE_VERSIONS=( "$@" )


function _output_build() {
  PHP_VERSION=$1
  EXACT_PHP_VERSION=$2
  DOCKERFILE=$3
  VERSION_SUFFIX=$4

  echo "echo 'Publishing version: ${PHP_VERSION}${VERSION_SUFFIX}'"
  echo "docker build --platform=linux/amd64 -t elephantcs/ci-php:${PHP_VERSION}${VERSION_SUFFIX} -t elephantcs/ci-php:${EXACT_PHP_VERSION}${VERSION_SUFFIX} - < ${PHP_VERSION}/${DOCKERFILE} \\"
  echo "  && docker push elephantcs/ci-php:${PHP_VERSION}${VERSION_SUFFIX} \\"
  echo "  && docker push elephantcs/ci-php:${EXACT_PHP_VERSION}${VERSION_SUFFIX}"
}

for PHP_VERSION_DIR in *; do
  PHP_VERSION=$(basename "$PHP_VERSION_DIR")

  # Check if it's a valid PHP version
  if ! [[ "$PHP_VERSION" =~ ^[7,8]\.[0-9]$ ]]; then
    continue;
  fi

  # Check if we should run commands for this version
  if [[ "$TOTAL_ARGS" -gt 0 ]]; then
    if ! ( echo "${INCLUDE_VERSIONS[@]}" | grep -q "$PHP_VERSION" ); then
       echo "# Skipping version, not included in script args: ${PHP_VERSION}";
       continue;
    fi
  fi

  EXACT_PHP_VERSION=$(grep "apt-get install -y php${PHP_VERSION}=" "${PHP_VERSION}/Dockerfile" | sed -E "s~.+(${PHP_VERSION}.[0-9]+).+~\1~g")
  if ! [[ "$EXACT_PHP_VERSION" =~ ^[7,8]\.[0-9].[0-9]+$ ]]; then
    echo "Failed to find exact PHP version for: ${PHP_VERSION}";
    continue;
  fi

  echo "# === Commands for PHP ${PHP_VERSION}";
  _output_build "$PHP_VERSION" "$EXACT_PHP_VERSION" "Dockerfile" ""

  # Find special versions
  for DF in ./"${PHP_VERSION}"/*
  do
    if [[ "$DF" =~ Node[0-9]+\.Dockerfile ]]; then
      NODE_VERSION=$(echo "$DF" | sed -E "s~.+Node([0-9]+).Dockerfile~\1~g")
      echo "# => Node v${NODE_VERSION}"
      _output_build "$PHP_VERSION" "$EXACT_PHP_VERSION" "Node${NODE_VERSION}.Dockerfile" "-node${NODE_VERSION}"
    fi
  done


done