#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/kernel package/firmware/ipq-wifi target/linux/qualcommax target/linux/generic

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax target/linux/generic package/kernel package/boot package/qca package/firmware/ipq-wifi

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/kernel-version.mk -P include/
wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/target.mk -P include/

sed -i "s/DEFAULT_PACKAGES:=/DEFAULT_PACKAGES:=luci-app-advancedplus luci-app-firewall luci-app-package-manager luci-app-upnp luci-app-syscontrol luci-proto-wireguard \
luci-app-wizard luci-base luci-compat luci-lib-ipkg luci-lib-fs luci-app-log-viewer \
coremark wget-ssl curl autocore htop nano zram-swap kmod-lib-zstd kmod-tcp-bbr bash openssh-sftp-server block-mount resolveip ds-lite swconfig luci-app-fan luci-app-filemanager /" include/target.mk
sed -i "s/procd-ujail//" include/target.mk

sed -i "s/wpad-openssl/wpad-mbedtls/" target/linux/qualcommax/Makefile

sed -i "/ECM_INTERFACE_MAP_T_ENABLE/d"  package/qca/qca-nss-ecm/Makefile

rm -rf feeds/kiddin9/xtables-wgobfs package/devel/perf package/feeds/packages/{ovpn-dco,xr_usb_serial_common,openvswitch,xtables-addons}


