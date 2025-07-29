#!/bin/bash
#SBATCH --job-name=0220_bitfit
#SBATCH --output=0220_bitfit.out
#SBATCH --error=0220_bitfit.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=32GB
#SBATCH --time=04:00:00

ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python /scratch/jh7956/hw2/train_model_use_bitfit.py
"
