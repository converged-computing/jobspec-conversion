#!/bin/bash
#SBATCH --job-name=kt_cnn_1024_128_8000
#SBATCH --mail-user=supawar@okstate.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=4

module load cuda
module load anaconda3/2020.07
python DHIT_CNN_apriori_sgs_TF2.py 
