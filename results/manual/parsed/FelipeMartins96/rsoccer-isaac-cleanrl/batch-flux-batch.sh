#!/bin/bash
#FLUX: --job-name=rsoccer-isaac-training
#FLUX: --exclusive
#FLUX: --queue=all
#FLUX: --urgency=16

eval "$('/usr/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
conda activate rlgpu
__GL_SHADER_DISK_CACHE_PATH=/tmp/fbm2/.nv/GLCache
CUDA_CACHE_PATH=/tmp/fbm2/.nv/ComputeCache
cd /home/CIN/fbm2/rsoccer-isaac-cleanrl
mkdir -p /tmp/fbm2/$SLURM_ARRAY_JOB_ID-$SLURM_ARRAY_TASK_ID
cd /tmp/fbm2/$SLURM_ARRAY_JOB_ID-$SLURM_ARRAY_TASK_ID
git clone https://github.com/FelipeMartins96/rsoccer-isaac-cleanrl.git
cd rsoccer-isaac-cleanrl
git checkout main
./run_slurm.sh $SLURM_ARRAY_TASK_ID
rm -rf /tmp/fbm2/$SLURM_ARRAY_JOB_ID-$SLURM_ARRAY_TASK_ID
