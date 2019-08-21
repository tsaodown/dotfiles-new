#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install xorg
package_install xorg-server
cleanup_installer
