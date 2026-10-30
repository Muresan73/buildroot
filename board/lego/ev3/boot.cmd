#
# The U-Boot that ships with the official firmware for LEGO MINDSTORMS EV3 is
# U-Boot 2009.11, which doesn't have support for device tree, etc. It will,
# however, load boot.scr from the FAT partition of a microSD card, so if we
# use this script, we can chain-load a newer U-Boot from the microSD card
# as well.
#
# NOTE: CONFIG_SYS_TEXT_BASE in u-boot.bin needs to be set to the same value as
# ubootaddr in this script.
# Verify it with `readelf -h output/build/uboot-*/u-boot | grep -i 'Entry point'`
#
# Regenerate boot.scr by running ( `post-image.sh` ):
# `make host-uboot-tools-rebuild`
#


if test "${ver}" = "U-Boot 2009.11 (Oct 26 2012 - 10:30:38)"; then
    echo "Old U-Boot detected, chain-loading 2026"
    setenv ubootaddr 0xc10c0000
    setenv loaduboot fatload mmc 0 ${ubootaddr} u-boot.bin
    if run loaduboot; then
        go ${ubootaddr}
    fi
else
    echo "U-Boot 2026.10 detected, booting kernel"

    fatload mmc 0:1 0xC0007FC0 uImage
    fatload mmc 0:1 0xC0800000 da850-lego-ev3.dtb
    bootm 0xC0007FC0 - 0xC0800000


fi
