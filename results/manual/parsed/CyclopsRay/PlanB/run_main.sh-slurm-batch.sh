#!/bin/bash
#SBATCH --job-name=run_main
#SBATCH --output=Run_main-%J.out
#SBATCH --error=Run_main-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=48G
#SBATCH --time=1-08:00:00
#SBATCH --partition=gpu

module load cuda/11.3.1
module load cudnn/8.2.0
module load anaconda/3-5.2.0 gcc/10.2
source activate vae_att
/gpfs/data/rsingh47/ylei29/anaconda/vae_att/bin/python ./main.py
