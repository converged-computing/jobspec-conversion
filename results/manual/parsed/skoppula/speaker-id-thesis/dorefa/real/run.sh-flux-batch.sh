#!/bin/bash
#FLUX: --job-name=dorefa
#FLUX: --queue=sm
#FLUX: -t=172800
#FLUX: --urgency=16

echo "$(hostname) $CUDA_VISIBLE_DEVICES"
echo "SLURM_JOBID="$SLURM_JOBID 
echo "SLURM_TASKID="$SLURM_ARRAY_TASK_ID
source /data/sls/r/u/skanda/home/envs/tf2gpu/bin/activate
cd /data/sls/u/meng/skanda/home/thesis/dorefa/real
MODELS=(buffer fcn1 fcn2 cnn lcn)
srun --gres=gpu:1 sharegpu_run.sh ${MODELS[$SLURM_ARRAY_TASK_ID]}
wait
