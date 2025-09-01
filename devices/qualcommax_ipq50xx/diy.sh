#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/kernel package/firmware/ipq-wifi target/linux/qualcommax target/linux/generic

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax target/linux/generic package/kernel package/boot package/qca package/firmware/ipq-wifi

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.12 -P include/

sed -i "s/wpad-openssl/wpad-mbedtls/" target/linux/qualcommax/Makefile

sed -i "/ECM_INTERFACE_MAP_T_ENABLE/d"  package/qca/qca-nss-ecm/Makefile

rm -rf feeds/kiddin9/xtables-wgobfs package/devel/perf package/feeds/packages/{ovpn-dco,xr_usb_serial_common,openvswitch,xtables-addons}


