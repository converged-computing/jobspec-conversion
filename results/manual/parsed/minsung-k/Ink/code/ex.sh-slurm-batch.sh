#!/bin/bash
#SBATCH --job-name=train_w3_half
#SBATCH --output=/blue/xxian/minsung.kang/Ink/logs/%j.log
#SBATCH --mail-user=minsung.kang@ufl.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=9gb
#SBATCH --time=8-08:00:00

pwd; hostname; date
module purge
module load tensorflow
python ex.py 3 5 50 # data_num weight epochs 
date
