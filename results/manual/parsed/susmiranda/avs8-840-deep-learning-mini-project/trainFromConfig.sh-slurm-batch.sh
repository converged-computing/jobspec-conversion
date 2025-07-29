#!/bin/bash
#SBATCH --job-name=train_${1}
#SBATCH --output=train_${1}.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=16:00:00

sbatch <<EOT
echo "The config file used is KWT_configs/${1}.cfg"
srun --gres=gpu:1 singularity exec --nv ~/pytorch-24.01 python train.py --conf "KWT_configs/${1}.cfg"
EOT
