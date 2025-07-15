#!/bin/bash
#FLUX: --job-name=colorspace_exp
#FLUX: -t=43200
#FLUX: --urgency=16

export WANDB_CONSOLE='off'

if [ -f /etc/bashrc ]; then
. /etc/bashrc
fi
module load anaconda3/2022.05.0.1
conda activate unet
export WANDB_CONSOLE=off
DATASET=instagram
EPOCH=500
TSPLIT=train[:25%]
VSPLIT=train[26%:28%]
F=(arcface vggface)
BATCH_SIZE=32
N_FILTERS=32
DEPTH=5
L=ssim
L_W=(0.5 1.0)
COL=(rgb hsv yuv)
TB_LOGS=/storage/home/hcoda1/0/plogas3/tb-logs/$SLURM_JOB_NAME/$SLURM_ARRAY_TASK_ID/
SEED=IAMGROOT
L_W_IDX=$(( (($SLURM_ARRAY_TASK_ID - 1) / 3) ))
COL_IDX=$(( (($SLURM_ARRAY_TASK_ID - 1) % 3) ))
echo Running task $SLURM_ARRAY_TASK_ID, which will train with a loss weight of ${L_W[$L_W_IDX]} and using the ${COL[$COL_DIX]} colorspace.
echo Training against F = ${F[@]}
echo srun python -u train.py --no-note -v 0 -E $EPOCH --t-split $TSPLIT --v-split $VSPLIT -F ${F[@]} -B $BATCH_SIZE --n-filters $N_FILTERS --depth $DEPTH -L $L -l ${L_W[$L_W_IDX]} --color-space ${COL[$COL_IDX]} -S $SEED
srun python -u train.py --no-note -v 0 -E $EPOCH --t-split $TSPLIT --v-split $VSPLIT -F ${F[@]} -B $BATCH_SIZE --n-filters $N_FILTERS --depth $DEPTH -L $L -l ${L_W[$L_W_IDX]} --color-space ${COL[$COL_IDX]} -S $SEED
date
