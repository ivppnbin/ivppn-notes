#!/bin/sh
echo Config swap----------------------------------------------------------------------

#check currently swap
swapon -s

dd if=/dev/zero of=/swapfile bs=1M count=2048
mkswap -f /swapfile
swapon /swapfile

#check currently swap
swapon -s

echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

cat /etc/fstab

echo End!