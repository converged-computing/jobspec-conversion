#!/bin/bash
#FLUX: --job-name=adorable-snack-4804
#FLUX: -t=604800
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/workspace/.mujoco/mujoco210/bin'
export MUJOCO_PY_MUJOCO_PATH='/workspace/.mujoco/mujoco210/'
export MUJOCO_GL='egl'

sleep $(( (RANDOM%10) + 1 )) # to avoid issues when submitting large amounts of jobs
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load singularity
echo "Job ID: ${SLURM_ARRAY_TASK_ID}"
singularity exec -B /scratch/$USER/sing/REDQ-fall22-student:/workspace/REDQ -B /scratch/$USER/sing/mujoco-sandbox/opt/conda/lib/python3.8/site-packages/mujoco_py/:/opt/conda/lib/python3.8/site-packages/mujoco_py/ /scratch/$USER/sing/mujoco-sandbox bash -c "
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/workspace/.mujoco/mujoco210/bin
export MUJOCO_PY_MUJOCO_PATH=/workspace/.mujoco/mujoco210/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/nvidia/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/workspace/.mujoco/mujoco210/bin
export MUJOCO_GL=egl
cd /workspace/REDQ/experiments/
python proj1.py --setting ${SLURM_ARRAY_TASK_ID}
"
