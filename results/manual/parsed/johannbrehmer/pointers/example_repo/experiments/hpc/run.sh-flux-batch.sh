#!/bin/bash
#FLUX: --job-name=imagenet
#FLUX: -t=432000
#FLUX: --priority=16

module load cuda/10.1.105
conda activate crow
dir=/path/to/experiment/directory
seed=$((SLURM_ARRAY_TASK_ID + 129363))
setup=$((SLURM_ARRAY_TASK_ID))
which python
nvcc --version
nvidia-smi
cd $dir
case ${setup} in
0) python images.py with config1 seed=$seed;;
1) python images.py with config2 seed=$seed;;
*) echo "Nothing to do for job ${SLURM_ARRAY_TASK_ID}" ;;
esac
