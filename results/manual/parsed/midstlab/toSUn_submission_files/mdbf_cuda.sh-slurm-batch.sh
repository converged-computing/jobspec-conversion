#!/bin/bash
#SBATCH --job-name=DHFR
#SBATCH --account=cuda
#SBATCH --output=%j-apoa1.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla_v100:1
#SBATCH --time=15-00:00:00
#SBATCH --qos=cuda
#SBATCH --constraint=ntasks-per-node=8

INPUT_FILE="apo-dhfr-lom-min1.conf"
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
