#!/bin/bash
#SBATCH --job-name=myImageLoader
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=grivam01@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python3/intel/3.5.3
module load pytorch/python3.5/0.2.0_3
source ~/scripts/deep_learning_hw2/dl_env/bin/activate
python model_loader.py
