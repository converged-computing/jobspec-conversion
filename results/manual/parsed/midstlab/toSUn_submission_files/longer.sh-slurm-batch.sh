#!/bin/bash
#SBATCH --job-name=DHFR
#SBATCH --account=mdbf
#SBATCH --output=%j-log.out
#SBATCH --mail-user=ebrucetin@sabanciuniv.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=15-00:00:00
#SBATCH --partition=longer_mdbf
#SBATCH --qos=longer_mdbf

INPUT_FILE="dhf-l28r-i94l.conf"
source /etc/profile.d/modules.sh
echo "source /etc/profile.d/modules.sh"
echo "Loading NAMD..."
module load namd/2.13/multicore
echo
echo
echo "============================== ENVIRONMENT VARIABLES ==============================="
env
echo "===================================================================================="
echo
echo
echo "=================================== STACK SIZE ====================================="
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo "===================================================================================="
echo
COMMAND="namd2 $INPUT_FILE +p$SLURM_NTASKS"
echo "Running NAMD command..."
echo $COMMAND
echo "===================================================================================="
NAMD_OUTPUT="namd.out-$SLURM_JOB_ID"
echo "Redirecting output to file: $NAMD_OUTPUT"
echo "-------------------------------------------"
$COMMAND > $NAMD_OUTPUT 2>&1
RET=$?
echo
echo "Solver exited with return code: $RET"
exit $RET
