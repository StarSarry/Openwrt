#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/kernel package/firmware/ipq-wifi target/linux/qualcommax target/linux/generic

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax target/linux/generic package/boot package/qca package/firmware/ipq-wifi
git_clone_path main https://github.com/openwrt/openwrt package/kernel

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.12 -P include/

wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/package/kernel/bpf-headers/Makefile -P package/kernel/bpf-headers/

sed -i "s/wpad-openssl/wpad-mbedtls/" target/linux/qualcommax/Makefile

sed -i "/ECM_INTERFACE_MAP_T_ENABLE/d"  package/qca/qca-nss-ecm/Makefile

rm -rf feeds/kiddin9/xtables-wgobfs package/devel/perf package/feeds/packages/{ovpn-dco,xr_usb_serial_common,openvswitch,xtables-addons}


