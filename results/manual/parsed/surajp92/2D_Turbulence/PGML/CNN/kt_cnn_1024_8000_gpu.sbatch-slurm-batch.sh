#!/bin/bash
#SBATCH --mail-user=supawar@okstate.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=20

module load cuda/11.0
python DHIT_CNN_apriori_sgs_TF2.py 
