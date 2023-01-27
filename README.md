# PHP CI Docker Image

Available on Docker Hub: [elephantcs/ci-php](https://hub.docker.com/r/elephantcs/ci-php/tags).

## Available tags
- [`8.2` (_Dockerfile_)](https://github.com/elephantcs/docker-ci-php/blob/master/8.2/Dockerfile)
- [`8.1` (_Dockerfile_)](https://github.com/elephantcs/docker-ci-php/blob/master/8.1/Dockerfile)
- [`8.0` (_Dockerfile_)](https://github.com/elephantcs/docker-ci-php/blob/master/8.0/Dockerfile)

## System information
  * Ubuntu 20.x

## Installed packages
  * ssh
  * openssh-client
  * rsync
  * curl
  * wget
  * PHP
    * mysql
    * pgsql
    * memcached
    * sqlite
    * bz2
    * zip
    * mbstring
    * curl
    * gd
    * xml
    * bcmath
    * intl
    * imap
  * Composer
  * PHPUnit

## Release new versions

(Make sure you're logged in with the correct account first `docker login`.)

- Bump the version of the `apt-get install -y php8.x=....` line
  - Check the version string @ [launchpad.net](https://launchpad.net/~ondrej/+archive/ubuntu/php/+index?batch=75&direction=backwards&start=225)
  - Search for the correct PHP version
  - Copy the version string
- Build a new version with the given tags
  - `cd` to the folder with the modified `Dockerfile`
  - Run `docker build -t elephantcs/ci-php:8.x -t elephantcs/ci-php:8.x.x .`, replace the major & minor versions
- Push the new versions to Docker Hub
  - `docker push elephantcs/ci-php:8.x`
  - `docker push elephantcs/ci-php:8.x.x`

Make sure to add `--platform=linux/amd64` to the build command when running on M1.

For the lazy: run `versions.sh` to output a one-liner per PHP version that you can copy & run. 

If you've modified all PHP versions: `./versions.sh > run.sh && chmod +x run.sh && ./run.sh && rm run.sh`

## Credits

Originally forked from [vyuldashev/docker-ci-php-node](https://github.com/vyuldashev/docker-ci-php-node).