#!/bin/bash
#SBATCH --job-name=FLOFS_ww3_multi_RUN
#SBATCH --account=coastal
#SBATCH --output=FLOFS_ww3_multi_RUN.out.log
#SBATCH --error=FLOFS_ww3_multi_RUN.err.log
#SBATCH --nodes=1
#SBATCH --ntasks=180
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00

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
