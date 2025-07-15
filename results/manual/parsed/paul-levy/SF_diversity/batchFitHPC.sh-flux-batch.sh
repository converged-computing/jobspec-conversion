#!/bin/bash
#FLUX: --job-name=modresp
#FLUX: -t=7200
#FLUX: --priority=16

export PATH='/scratch/pl1465/SF_diversity/pytorch/bin:$PATH'

module purge
module load anaconda3/2020.02/
source /share/apps/anaconda3/2020.02/etc/profile.d/conda.sh
conda activate /scratch/pl1465/SF_diversity/pytorch/
export PATH=/scratch/pl1465/SF_diversity/pytorch/bin:$PATH
EXP_DIR=$1
EXC_TYPE=$2
LOSS=$3
srun -n1 --nodes=1 --input none  python model_responses_pytorch.py $SLURM_ARRAY_TASK_ID $EXP_DIR $EXC_TYPE $LOSS 1 1 0 1 0.10 1 1 -1 4 &
srun -n2 --nodes=1 --input none  python model_responses_pytorch.py $SLURM_ARRAY_TASK_ID $EXP_DIR $EXC_TYPE $LOSS 2 1 0 1 0.10 1 1 -1 4 &
srun -n3 --nodes=1 --input none  python model_responses_pytorch.py $SLURM_ARRAY_TASK_ID $EXP_DIR $EXC_TYPE $LOSS 5 1 0 1 0.10 1 1 -1 4 &
wait
