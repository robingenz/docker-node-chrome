FROM ubuntu:18.04

LABEL MAINTAINER="Robin Genz <mail@robingenz.dev>"

ARG NODEJS_VERSION="12"
ARG CHROME_VERSION="81.0.4044.122-1"

WORKDIR /tmp

RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get upgrade -qy && apt-get install -qy \
    gnupg2 \
    wget \
    git \
    #install chrome
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -q && apt-get install -qy google-chrome-stable=${CHROME_VERSION} \
    # install nodejs
    && wget -q -O - https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
    && apt-get update -q && apt-get install -qy nodejs \
    # clean up
    && apt-get clean -y

WORKDIR /workdir