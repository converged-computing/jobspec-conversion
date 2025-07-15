#!/bin/bash
#FLUX: --job-name=DHFR
#FLUX: --queue=midst
#FLUX: -t=1296000
#FLUX: --priority=16

INPUT_FILE="tmpp_w30g_l28r.conf"
source /etc/profile.d/modules.sh
echo "source /etc/profile.d/modules.sh"
echo "Loading NAMD..."
module load namd/2.13/multicore-cuda
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
COMMAND="namd2 +p$SLURM_NTASKS +idlepoll +devices $CUDA_VISIBLE_DEVICES $INPUT_FILE "
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
