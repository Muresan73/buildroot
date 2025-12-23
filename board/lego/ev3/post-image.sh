#!/bin/sh

BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

rm -rf "${GENIMAGE_TMP}"

genimage \
    --rootpath "${TARGET_DIR}" \
    --tmppath "${GENIMAGE_TMP}" \
    --inputpath "${BINARIES_DIR}" \
    --outputpath "${BINARIES_DIR}" \
    --config "${GENIMAGE_CFG}"

set -eu

BOARD_DIR="$(dirname "$0")"

echo "Generating boot.scr from boot.cmd"

mkimage -c none -A arm -T script \
    -d "${BOARD_DIR}/boot.cmd" \
    "${BINARIES_DIR}/boot.scr"
