#!/bin/bash

set -e

# 时区
if [ -f package/base-files/files/etc/config/system ]; then
    sed -i "s#option timezone 'UTC'#option timezone 'CST-8'#" package/base-files/files/etc/config/system
    sed -i "s#option zonename 'UTC'#option zonename 'Asia/Shanghai'#" package/base-files/files/etc/config/system
fi

echo "CONFIG_PACKAGE_luci-app-attendedsysupgrade=n" > $GITHUB_WORKSPACE/Config/GENERAL.txt
echo "CONFIG_PACKAGE_luci-app-wol=n" >> $GITHUB_WORKSPACE/Config/GENERAL.txt

#git clone --depth=1 https://github.com/mufeng05/openwrt-sonic-fullcone.git feeds/fullcone

#rm -rfv package/libs/libnftnl/patches/001-libnftnl-add-fullcone-expression-support.patch
#rm -rfv package/network/utils/nftables/patches/004-nftables-add-fullcone-expression-support.patch
#rm -rfv target/linux/generic/hack-6.18/952-net-conntrack-events-support-multiple-registrant.patch
#rm -rfv package/network/config/firewall4/patches/130-firewall4-add-support-for-fullcone-nat.patch
# openwrt-sonic-fullcone
#sh feeds/fullcone/add_sonic_fullcone.sh

PROJECT_MIRRORS_FILE="./scripts/projectsmirrors.json"
if [ -f "$PROJECT_MIRRORS_FILE" ]; then
    perl -0pi -e 's/,\s*([\]}])/$1/g' $PROJECT_MIRRORS_FILE
    python3 -m json.tool $PROJECT_MIRRORS_FILE >/dev/null && echo "JSON OK"
fi
echo "[PRIVATE.sh] 完成"
