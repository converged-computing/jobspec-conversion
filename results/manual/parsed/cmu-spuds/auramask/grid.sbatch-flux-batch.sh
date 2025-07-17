#!/bin/bash
#FLUX: --job-name=lfw-multiembed-unet
#FLUX: --queue=inferno
#FLUX: -t=28800
#FLUX: --urgency=16

if [ -f /etc/bashrc ]; then
. /etc/bashrc
fi
module load anaconda3/2022.05.0.1
conda activate unet
DATASET=lfw
EPOCH=500
TSPLIT=train[:80%]
VSPLIT=train[81%:100%]
F=(arcface vggface deepface facenet512 deepid)
BATCH_SIZE=32
N_FILTERS=(32)
DEPTH=(5)
L=none
TB_LOGS=/storage/home/hcoda1/0/plogas3/tb-logs/$SLURM_JOB_NAME/$SLURM_ARRAY_TASK_ID/
RUN_IDX=$(( ($SLURM_ARRAY_TASK_ID - 1) ))
echo Running task $SLURM_ARRAY_TASK_ID, which will train with ${N_FILTERS[$RUN_IDX]} starting filters and depth of ${DEPTH[$RUN_IDX]}
echo Training against F = ${F[@]}
echo srun python -u train.py --no-note -v 0 -E $EPOCH --t-split $TSPLIT --v-split $VSPLIT -F ${F[@]} -B $BATCH_SIZE --n-filters ${N_FILTERS[$RUN_IDX]} --depth ${DEPTH[$RUN_IDX]} -L $L --log-dir $TB_LOGS
srun python -u train.py --no-note -v 0 -E $EPOCH --t-split $TSPLIT --v-split $VSPLIT -F ${F[@]} -B $BATCH_SIZE --n-filters ${N_FILTERS[$RUN_IDX]} --depth ${DEPTH[$RUN_IDX]} -L $L --log-dir $TB_LOGS
date
