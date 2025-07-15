#!/bin/bash
#FLUX: --job-name=ssl-mamba
#FLUX: -c=24
#FLUX: --queue=gpu_p2
#FLUX: -t=72000
#FLUX: --urgency=16

export TORCH_NCCL_BLOCKING_WAIT='1'
export MASTER='$(hostname --ip-address)'
export MASTER_PORT='$((RANDOM%1000+20000))'

set -ex # activer l’echo des commandes
cd ${SLURM_SUBMIT_DIR}
export TORCH_NCCL_BLOCKING_WAIT=1
export MASTER=$(hostname --ip-address)
export MASTER_PORT=$((RANDOM%1000+20000))
srun run_mamba_bidirectional.sh
