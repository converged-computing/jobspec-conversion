#!/bin/bash
#SBATCH --job-name=mood
#SBATCH --output=/home/bme001/s144823/output/other/output_%j.out
#SBATCH --mail-user=e.m.c.huijben@tue.nl
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=41-16:00:00
#SBATCH --nodelist=bme-gpuB001

source /home/bme001/s144823/conda/etc/profile.d/conda.sh
conda activate mood
cd /home/bme001/shared/mood/code/ddpm-ood/post_processing
srun python create_gt_hull_objects.py
