#!/bin/bash
#FLUX: --job-name=FEP
#FLUX: --queue=short_mdbf
#FLUX: -t=7200
#FLUX: --priority=16

INPUT_FILE="tmpp_i94l-a26t-w30g_150ns_eq.conf"
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
