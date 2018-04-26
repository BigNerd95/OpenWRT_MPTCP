#!/bin/sh

# 1) download openwrt

git clone https://github.com/openwrt/openwrt.git openwrt -b master
cd openwrt



# 2) apply MPTCP kernel patches

wget https://multipath-tcp.org/patches/mptcp-v4.4.110-645011515197.patch -O target/linux/generic/pending-4.4/690-mptcp-v4.4.110-645011515197.patch
wget https://multipath-tcp.org/patches/mptcp-v4.9-c88d1d56809e.patch -O target/linux/generic/pending-4.9/690-mptcp-v4.9-c88d1d56809e.patch
wget https://multipath-tcp.org/patches/mptcp-v4.14-559409607f41.patch -O target/linux/generic/pending-4.14/690-mptcp-v4.14-559409607f41.patch



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
