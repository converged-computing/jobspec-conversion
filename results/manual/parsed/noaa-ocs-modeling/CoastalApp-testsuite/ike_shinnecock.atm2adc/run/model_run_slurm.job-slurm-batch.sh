#!/bin/bash
#SBATCH --job-name=IKSH_atm2adc_RUN
#SBATCH --account=coastal
#SBATCH --output=IKSH_atm2adc_RUN.out.log
#SBATCH --error=IKSH_atm2adc_RUN.err.log
#SBATCH --nodes=1
#SBATCH --ntasks=12
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
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}NEMS.x
