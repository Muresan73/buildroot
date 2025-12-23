# chain-boot.cmd - chain-load newer U-Boot from microSD (FAT)
#
# Stock LEGO EV3 firmware ships with U-Boot 2009.11. It can load and execute
# boot.scr from the FAT partition. This script chain-loads a newer U-Boot
# (u-boot.bin) from the same partition.
#
# IMPORTANT:
#  - u-boot.bin must be linked for the same address as ubootaddr below.
#    (CONFIG_SYS_TEXT_BASE must match ubootaddr)
#
# Create boot.scr:
#   mkimage -c none -A arm -T script -d chain-boot.cmd boot.scr

setenv ubootaddr 0xC10C0000
setenv newuboot  u-boot.bin

setenv loaduboot 'fatload mmc 0 ${ubootaddr} ${newuboot}'

echo "boot.scr: attempting chainload of ${newuboot} to ${ubootaddr} ..."
if run loaduboot; then
    echo "boot.scr: starting new U-Boot (go ${ubootaddr})"
    go ${ubootaddr}
fi

echo "boot.scr: ERROR: ${newuboot} not found or load failed"
reset
