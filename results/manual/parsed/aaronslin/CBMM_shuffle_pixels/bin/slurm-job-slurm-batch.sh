#!/bin/bash
#SBATCH --job-name=shuffle_pixels
#SBATCH --output=slurm_out/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --array=1-20

set -euxo pipefail
${SLURM_ARRAY_TASK_ID:=3}
source ${MODULESHOME}/init/bash
module add openmind/singularity/2.2.1
singularity exec --bind /om:/om /om/user/aaronlin/py35-tf.img python -u conv_shuffle.py -s $SLURM_ARRAY_TASK_ID -o 1 -d cifar
