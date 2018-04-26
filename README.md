# OpenWRT MPTCP

This is a cleaner version of [OpenMPTCProuter](https://github.com/ysurac/openmptcprouter).
For more info see the original project.



## Build

### Dependencies

```sh
$ sudo apt update
$ sudo apt install build-essential git unzip ncurses-dev libz-dev libssl-dev python subversion gettext gawk wget curl rsync perl
```

### Prepare and build

```sh
git clone https://github.com/BigNerd95/OpenWRT_MPTCP.git
cd OpenWRT_MPTCP
./prepare.sh
```

Once you have selected your preferences in menuconfig run `make -j9` (where 9 is the number of cores + 1).

## Credits

* [OpenMPTCProuter](https://github.com/ysurac/openmptcprouter)
* [OpenWRT](https://openwrt.org)
* [MultiPath TCP (MPTCP)](https://multipath-tcp.org)
