#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install xfce4
cleanup_installer