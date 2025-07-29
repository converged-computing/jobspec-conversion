#!/bin/bash
#SBATCH --job-name=SCI_atm2fvc2ww3_RUN
#SBATCH --account=coastal
#SBATCH --output=SCI_atm2fvc2ww3_RUN.out.log
#SBATCH --error=SCI_atm2fvc2ww3_RUN.err.log
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

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
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}NEMS.x
