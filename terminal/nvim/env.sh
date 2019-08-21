#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

add_env_var "XDG_CONFIG_HOME=/etc"
add_env_var "XDG_DATA_HOME=/etc"
