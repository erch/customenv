#!/bin/sh

hosts="/etc/hosts"

prex="89.30.126.12 www.bestofmedia.com www.bestofmicro.com admin.bestofmicro.com admin.bestofmedia.com www.presence-pc.com www.infos-du-net.com www.tatetesurbestof.com www.tomsguide.com www.tomshardware.com www.tomshardware.co.uk ads.bestofmedia.com img.tomshardware.com"
prexMedia="89.30.126.119 m.bestofmedia.com"

if grep '89.30.126.12' $hosts > /dev/null
then
    sed -i '/89.30.126.12/d' $hosts
    sed -i '/89.30.126.119/d' $hosts
    echo 'You work on production servers'
else
    echo $prex >> $hosts
    echo $prexMedia >> $hosts
    echo 'You work on QA servers'
fi
