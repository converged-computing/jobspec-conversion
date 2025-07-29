#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu
#SBATCH --mem=6144
#SBATCH --time=01:00:00
#SBATCH --qos=short

export WANDB_API_KEY='5627524443770cf7995a564065ff75a9522b1a48'

module use /opt/insy/modulefiles
module load cuda/11.2 cudnn/11.2-8.1.1.33
echo 'conda activate vphys'
conda activate vphys
export WANDB_API_KEY="5627524443770cf7995a564065ff75a9522b1a48"
srun python Figures/init_exp.py
