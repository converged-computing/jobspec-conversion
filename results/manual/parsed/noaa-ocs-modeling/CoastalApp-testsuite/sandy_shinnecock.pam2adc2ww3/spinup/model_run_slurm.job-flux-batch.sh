#!/bin/bash
#FLUX: --job-name=SDSH_pam2adc2ww3_RUN
#FLUX: -n=5
#FLUX: -t=7200
#FLUX: --urgency=16

set -e
if [ -e "${MOD_FILE}" ]; then
  source ${MOD_FILE}
  module list
else
  echo "The module file: <${MOD_FILE}> is not found"
  echo "Will continue without loading any OS defined modules"
fi
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}NEMS.x
