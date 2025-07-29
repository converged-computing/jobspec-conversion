#!/bin/bash
#SBATCH --job-name=train-chess
#SBATCH --account=bii_dsc_community
#SBATCH --output=%u-%j.out
#SBATCH --error=%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:2
#SBATCH --mem=256G
#SBATCH --time=3-00:00:00

date
nvidia-smi
module purge
module load singularity tensorflow cuda cudatoolkit cudnn gcc openmpi python
source ./ENV/bin/activate
time singularity exec --nv $CONTAINERDIR/tensorflow-2.10.0.sif \
    python train.py --save-dir saved_model # --load-dir saved_model\
date
