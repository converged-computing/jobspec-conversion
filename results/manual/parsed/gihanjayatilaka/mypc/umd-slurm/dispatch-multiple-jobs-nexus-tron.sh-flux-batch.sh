#!/bin/bash
#FLUX: --job-name=pytorchjob
#FLUX: -c=8
#FLUX: --queue=tron
#FLUX: -t=21600
#FLUX: --priority=16

export TORCH_HOME='/vulcanscratch/gihan/torch-hub/'

CONDA_ENV_NAME="longtails"
DIRECTORY="/vulcanscratch/gihan/long-tails/"
source ~/.bashrc
export TORCH_HOME=/vulcanscratch/gihan/torch-hub/
conda activate $CONDA_ENV_NAME
cd $DIRECTORY
sed -n "${SLURM_ARRAY_TASK_ID}p" < /vulcanscratch/gihan/umd-slurm/list-of-commands.sh
sed -n "${SLURM_ARRAY_TASK_ID}p" < /vulcanscratch/gihan/umd-slurm/list-of-commands.sh >&2
echo "------"
echo "------" >&2
eval $(sed -n "${SLURM_ARRAY_TASK_ID}p" < /vulcanscratch/gihan/umd-slurm/list-of-commands.sh)
echo "END of SLURM commands"
echo "END of SLURM commands" >&2
