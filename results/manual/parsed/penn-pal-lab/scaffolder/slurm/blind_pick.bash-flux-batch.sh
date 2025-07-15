#!/bin/bash
#FLUX: --job-name=arid-truffle-4313
#FLUX: --queue=dineshj-compute
#FLUX: -t=43200
#FLUX: --urgency=16

export WANDB_RUN_GROUP='$EXPERIMENT; '
export WANDB__SERVICE_WAIT='600;'
export MUJOCO_GL='egl; '
export CUDA_VISIBLE_DEVICES='0; '
export MUJOCO_EGL_DEVICE_ID='$CUDA_VISIBLE_DEVICES;'

QOS="dj-high"
if [[ "$QOS" == "dj-med" ]]; then
    TIMEOUT=11h
elif [[ "$QOS" == "dj-high" ]]; then
    TIMEOUT=23h
else
    TIMEOUT=23h
fi
MODEL_SIZE="small"
EXPERIMENT="asym-fixedtoblind32px-DecodeAll-NoCritic-${MODEL_SIZE}"; 
export WANDB_RUN_GROUP=$EXPERIMENT; 
export WANDB__SERVICE_WAIT=600;
export MUJOCO_GL=egl; 
export CUDA_VISIBLE_DEVICES=0; 
export MUJOCO_EGL_DEVICE_ID=$CUDA_VISIBLE_DEVICES;
SEED=$SLURM_ARRAY_TASK_ID
conda activate dreamerv3
CONFIG="gymnasium_blindpick,${MODEL_SIZE}"
timeout $TIMEOUT python -u dreamerv3/train.py --logdir ~/logdir/${EXPERIMENT}_s$SEED --configs $CONFIG --seed $SEED   >> "${EXPERIMENT}_s${SEED}.out"
if [[ $? == 124 ]]; then 
  echo "Asking slurm to requeue this job.\n" >> "${EXPERIMENT}_s${SEED}.out"
  scontrol requeue $SLURM_JOB_ID
fi
exit 0
