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

setenv ubootaddr 0xc10c0000
setenv loaduboot fatload mmc 0 ${ubootaddr} u-boot.bin

# try to run u-boot.bin from MMC if present
if run loaduboot; then
    go ${ubootaddr}
fi
