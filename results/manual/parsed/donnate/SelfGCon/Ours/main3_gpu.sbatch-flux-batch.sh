#!/bin/bash
#FLUX: --job-name=gpu-job
#FLUX: --queue=gpu
#FLUX: -t=126000
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load python
module load cuda
source activate pytorch_env  
cd $SCRATCH/$USER/SelfGCon
echo $1
echo $2
python3 Ours/main3.py
conda deactivate
~
~
