#!/bin/bash

OWRT_PCS_GENERIC="https://raw.githubusercontent.com/openwrt/openwrt/e90f3f1f"
OWRT_PCS_AIROHA="https://raw.githubusercontent.com/openwrt/openwrt/c5427d4c"
OWRT_MAIN="https://raw.githubusercontent.com/openwrt/openwrt/main"

rm -rf target/linux/airoha/patches-6.12/{910-01-v7.0-net-airoha-npu-Init-BA-memory-region-if.patch,910-02-v7.0-net-airoha-npu-Add-the-capability-to-read-firmware-n.patch}

# openwrt-25.12 ships airoha phylink/PCS patches that depend on the PCS
# standalone framework (linux/pcs/pcs.h), which was only backported later.
rm -f target/linux/airoha/patches-6.12/310-08-net-phylink-add-.pcs_link_down-PCS-OP.patch
rm -f target/linux/airoha/patches-6.12/310-09-net-pcs-airoha-add-PCS-driver-for-Airoha-SoC.patch
rm -f target/linux/airoha/patches-6.12/310-10-net-airoha-add-phylink-support.patch

for p in \
	target/linux/generic/backport-6.12/650-v6.13-net-phylink-allow-mac_select_pcs-to-remove-a-PCS.patch \
	target/linux/generic/backport-6.12/651-v6.14-net-phylink-add-support-for-PCS-supported_interfaces.patch \
	target/linux/generic/backport-6.12/652-v6.15-net-phylink-force-link-down-on-major_config-failure.patch \
	target/linux/generic/backport-6.12/653-01-v7.0-net-phylink-simplify-phylink_resolve-phylink_major_c.patch \
	target/linux/generic/backport-6.12/653-02-v7.0-net-phylink-introduce-helpers-for-replaying-link-cal.patch \
	target/linux/generic/backport-6.12/702-v7.0-net-phylink-fix-NULL-pointer-deref-in-phylink_major_.patch \
	target/linux/generic/pending-6.12/770-01-net-phylink-keep-and-use-MAC-supported_interfaces-in.patch \
	target/linux/generic/pending-6.12/770-02-net-phylink-introduce-internal-phylink-PCS-handling.patch \
	target/linux/generic/pending-6.12/770-03-net-phylink-add-phylink_release_pcs-to-externally-re.patch \
	target/linux/generic/pending-6.12/770-04-net-pcs-implement-Firmware-node-support-for-PCS-driv.patch \
	target/linux/generic/pending-6.12/770-05-net-phylink-support-late-PCS-provider-attach.patch \
	target/linux/generic/pending-6.12/770-06-dt-bindings-net-ethernet-controller-permit-to-define.patch \
	target/linux/generic/pending-6.12/770-07-net-phylink-add-.pcs_link_down-PCS-OP.patch
do
	mkdir -p "$(dirname "$p")"
	wget -N "$OWRT_PCS_GENERIC/$p" -O "$p"
done

for p in \
	target/linux/airoha/patches-6.12/310-09-net-pcs-airoha-add-PCS-driver-for-Airoha-AN7581-SoC.patch \
	target/linux/airoha/patches-6.12/310-10-net-airoha-add-phylink-support-for-GDM2-3-4.patch \
	target/linux/airoha/patches-6.12/604-01-net-pcs-airoha-add-support-for-AN7583.patch \
	target/linux/airoha/patches-6.12/605-net-pcs-airoha-add-support-for-optional-xfi-reset-li.patch \
	target/linux/airoha/patches-6.12/606-net-airoha-disable-external-phy-code-if-PCS_AIROHA-i.patch
do
	mkdir -p "$(dirname "$p")"
	wget -N "$OWRT_PCS_AIROHA/$p" -O "$p"
done

mkdir -p target/linux/airoha/dts
wget -N "$OWRT_MAIN/target/linux/airoha/dts/an7581.dtsi" -O target/linux/airoha/dts/an7581.dtsi
