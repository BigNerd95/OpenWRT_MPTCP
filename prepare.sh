#!/bin/sh

# 1) download openwrt

git clone https://github.com/openwrt/openwrt.git openwrt -b master
cd openwrt



# 2) apply MPTCP kernel patches

cp ../mptcp_patches/699-mptcp_v0.92.2.patch target/linux/generic/patches-4.4/
cp ../mptcp_patches/690-mptcp_v0.93_b674162.patch target/linux/generic/hack-4.9/
cp ../mptcp_patches/690-mptcp_v0.94.patch target/linux/generic/hack-4.14/


config=$(cat <<EOL
CONFIG_TCP_CONG_LIA=y 
CONFIG_TCP_CONG_OLIA=y
CONFIG_TCP_CONG_WVEGAS=y
CONFIG_TCP_CONG_BALIA=y
CONFIG_DEFAULT_TCP_CONG="olia"
CONFIG_MPTCP=y"
EOL
)

echo "$config" >> target/linux/generic/config-4.4
echo "$config" >> target/linux/generic/config-4.9
echo "$config" >> target/linux/generic/config-4.14



# 3) add MPTCP packages

cp feeds.conf.default feeds.conf
echo "src-git openmptcprouter https://github.com/ysurac/openmptcprouter-feeds.git" >> feeds.conf

scripts/feeds update -a
scripts/feeds install -a



# 4) choose your build target and settings

make defconfig
make menuconfig
