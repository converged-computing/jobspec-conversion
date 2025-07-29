#!/bin/bash
#SBATCH --job-name=MRP_dke
#SBATCH --output=output_%J_mrprun.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module switch intel gcc
module load python/3.6.8
module load cuda/100
module load cudnn/7.4
pip install --user -r requirements.txt
python application/grid_search.py --epochs 50
