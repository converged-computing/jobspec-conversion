#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

module load foss/2022a 
module load PyTorch/1.12.1
python3 quickstart_tutorial.py
sleep 60
python3 tensorqs_tutorial.py 
my-job-stats -a -n -s
