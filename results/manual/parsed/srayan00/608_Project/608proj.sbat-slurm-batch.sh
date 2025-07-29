#!/bin/bash
#SBATCH --job-name=v200h3
#SBATCH --account=stats_dept1
#SBATCH --mail-user=srayan@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=96000m
#SBATCH --time=1-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

eval "$(conda shell.bash hook)"
conda activate 608proj
python3 test_vi.py --seed 44 --horizon 200 --episode 5
