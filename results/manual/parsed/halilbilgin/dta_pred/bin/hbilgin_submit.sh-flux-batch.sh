#!/bin/bash
#FLUX: --job-name=Keras
#FLUX: --queue=cuda
#FLUX: -t=36000
#FLUX: --priority=16

export PATH='$HOME/.local/bin:$PATH'

INPUT_FILE="$@"
source /etc/profile.d/zzz_cta.sh
echo "source /etc/profile.d/zzz_cta.sh"
echo "CompecTA Pulsar..."
module load singularity/pulsar
echo ""
echo "============================== ENVIRONMENT VARIABLES ==============================="
env
echo "===================================================================================="
echo ""
echo ""
echo "======================================================================================"
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo "======================================================================================"
PULSAR=/cta/capps/singularity/pulsar
export PATH=$HOME/.local/bin:$PATH
source ~/.bashrc
module load cuda/9.0
conda activate dta_pred
echo "Running Tensorflow command..."
echo "===================================================================================="
nvidia-smi
 /cta/users/hbilgin/.conda/envs/dta_pred/bin/python $INPUT_FILE --mongodb="192.168.12.1:80:DTA_PRED"
RET=$?
echo ""
echo "===================================================================================="
echo "Solver exited with return code: $RET"
exit $RET
