#!/bin/bash

set -eu -o pipefail

if [[ ! -f /app/data/env ]]; then
  echo "==> Copying default configuration"
  cp /app/pkg/env /app/data/env
fi

export JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8"

if [[ -f /sys/fs/cgroup/cgroup.controllers ]]; then # cgroup v2
    ram=$(cat /sys/fs/cgroup/memory.max)
    [[ "${ram}" == "max" ]] && ram=$(( 2 * 1024 * 1024 * 1024 )) # "max" means unlimited
else
    ram=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes) # this is the RAM. we have equal amount of swap
fi

if (( ram <= 17179869184 )); then
    ram_mb=$(numfmt --to-unit=1048576 --format "%fm" $ram)
    export JAVA_OPTS="${JAVA_OPTS} -Xmx${ram_mb}"
fi

# Load the end-user configuration
source /app/data/env

chown -R cloudron:cloudron /app/data

echo "==> Starting Reader"
cd /app/data
exec gosu cloudron:cloudron java ${JAVA_OPTS} -jar /app/code/reader.jar
