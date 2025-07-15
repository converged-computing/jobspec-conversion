#!/bin/bash
#FLUX: --job-name=joyous-staircase-0495
#FLUX: --urgency=16

set -e
if [ -e "${MOD_FILE}" ]; then
  source ${MOD_FILE}
  module list
else
  echo "The module file: <${MOD_FILE}> is not found"
  echo "Will continue without loading any OS defined modules"
fi
ulimit -s unlimited
ulimit -c 0
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}ww3_multi
