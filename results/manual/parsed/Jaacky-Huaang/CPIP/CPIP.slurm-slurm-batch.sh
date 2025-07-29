#!/bin/bash
#SBATCH --job-name=0401_CPIP
#SBATCH --output=0401_CPIP.out
#SBATCH --error=0401_CPIP.err
#SBATCH --mail-user=jh7956@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=05:00:00
#SBATCH --partition=a100_1,a100_2,v100
#SBATCH --constraint=ntasks-per-node=1

ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif
cd /scratch/jh7956/CPIP
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python main.py"
