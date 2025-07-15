#!/bin/bash
#FLUX: --job-name=lipid
#FLUX: --queue=long
#FLUX: -t=604800
#FLUX: --urgency=16

INPUT_FILE="1pga_autopsf_wb_ionized_config.conf"
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
