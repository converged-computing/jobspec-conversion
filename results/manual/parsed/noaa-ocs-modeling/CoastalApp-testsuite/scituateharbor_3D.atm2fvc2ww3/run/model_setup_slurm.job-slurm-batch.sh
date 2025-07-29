#!/bin/bash
#SBATCH --job-name=SCI_atm2fvc2ww3_SETUP
#SBATCH --account=coastal
#SBATCH --output=SCI_atm2fvc2ww3_SETUP.out.log
#SBATCH --error=SCI_atm2fvc2ww3_SETUP.err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

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
echo "Preparing WW3 inputs..."
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}ww3_grid ww3_grid.inp > ww3_grid.out
cp -fp mod_def.ww3 mod_def.inlet
cp -fp mod_def.ww3 mod_def.points
${BATCH_RUNEXE} ${BIN_DIR:+${BIN_DIR}/}ww3_bounc  > ww3_bounc.out
mv -f nest.ww3 nest.inlet
