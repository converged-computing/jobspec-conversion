#!/bin/bash
#FLUX: --job-name=render_data
#FLUX: -c=28
#FLUX: -t=360
#FLUX: --urgency=16

export PATH='$PATH:/mnt/storage/scratch/gp14958/blender-2.79-linux-glibc219-x86_64/'
export SCENE_DIR='/mnt/storage/scratch/gp14958/scene_data_final'
export PREFIX='10000'

module unload Python/2.7.11-foss-2016a
module load libGLU/9.0.0-foss-2016a-Mesa-11.2.1
module load libs/cudnn/8.0-cuda-8.0
export PATH=$PATH:/mnt/storage/scratch/gp14958/blender-2.79-linux-glibc219-x86_64/
export SCENE_DIR=/mnt/storage/scratch/gp14958/scene_data_final
export PREFIX=10000
srun python runner.py --arr=$SLURM_ARRAY_TASK_ID
