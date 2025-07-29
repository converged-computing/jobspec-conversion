#!/bin/bash
#SBATCH --mail-user=dokter@tugraz.at
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:34:56
#SBATCH --nodelist=nvcluster-node2

cd ~/local
pwd; hostname; date
source ~/daphne/venv/bin/activate
cd ~/daphne/experiments
time python3 resnet20-training.py dataset=sen2 datadir=~/local 
date
