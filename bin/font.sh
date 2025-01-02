#!/bin/zsh
set -eu

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
. $SCRIPT_DIR/_common.sh

exit_if_not_macos

mkdir -p /tmp/font
pushd /tmp/font

# PlemolJP
curl -LO https://github.com/yuru7/PlemolJP/releases/download/v2.0.0/PlemolJP_v2.0.0.zip
curl -LO https://github.com/yuru7/PlemolJP/releases/download/v2.0.0/PlemolJP_HS_v2.0.0.zip
curl -LO https://github.com/yuru7/PlemolJP/releases/download/v2.0.0/PlemolJP_NF_v2.0.0.zip
unzip PlemolJP_v2.0.0.zip
unzip PlemolJP_HS_v2.0.0.zip
unzip PlemolJP_NF_v2.0.0.zip
mv PlemolJP_v2.0.0/**/*.ttf ~/Library/fonts/
mv PlemolJP_HS_v2.0.0/**/*.ttf ~/Library/fonts/
mv PlemolJP_NF_v2.0.0/**/*.ttf ~/Library/fonts/

# UDEV Gothic
curl -LO https://github.com/yuru7/udev-gothic/releases/download/v2.1.0/UDEVGothic_v2.1.0.zip
curl -LO https://github.com/yuru7/udev-gothic/releases/download/v2.1.0/UDEVGothic_NF_v2.1.0.zip
curl -LO https://github.com/yuru7/udev-gothic/releases/download/v2.1.0/UDEVGothic_HS_v2.1.0.zip
unzip UDEVGothic_v2.1.0.zip
unzip UDEVGothic_NF_v2.1.0.zip
unzip UDEVGothic_HS_v2.1.0.zip
mv UDEVGothic_v2.1.0/**/*.ttf ~/Library/fonts/
mv UDEVGothic_NF_v2.1.0/**/*.ttf ~/Library/fonts/
mv UDEVGothic_HS_v2.1.0/**/*.ttf ~/Library/fonts/

popd
rm -rf /tmp/font
