#!/bin/bash
#FLUX: --job-name=FLSH_adc_SETUP
#FLUX: -t=1800
#FLUX: --urgency=16

set -e
if [ -e "${MOD_FILE}" ]; then
  source ${MOD_FILE}
  module list
else
  echo "The module file: <${MOD_FILE}> is not found"
  echo "Will continue without loading any OS defined modules"
fi
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}adcprep --np 11 --partmesh
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}adcprep --np 11 --prepall
