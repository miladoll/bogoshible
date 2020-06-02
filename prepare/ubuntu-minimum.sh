#!/bin/sh

cd ~root

apt -y install \
    wget \
    apt-utils \
    bash \
    coreutils \
    sed \
    gawk \
    git \

wget https://raw.githubusercontent.com/miladoll/bogoshible/master/bogoshible
chmod +x bogoshible
mv bogoshible /usr/local/bin/bogoshible
