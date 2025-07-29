#!/bin/bash
#SBATCH --job-name=SDSH_pam2adc2ww3_SETUP
#SBATCH --account=coastal
#SBATCH --output=SDSH_pam2adc2ww3_SETUP.out.log
#SBATCH --error=SDSH_pam2adc2ww3_SETUP.err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

set -e
if [ -e "${MOD_FILE}" ]; then
  source ${MOD_FILE}
  module list
else
  echo "The module file: <${MOD_FILE}> is not found"
  echo "Will continue without loading any OS defined modules"
fi
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}adcprep --np 5 --partmesh
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}adcprep --np 5 --prepall
