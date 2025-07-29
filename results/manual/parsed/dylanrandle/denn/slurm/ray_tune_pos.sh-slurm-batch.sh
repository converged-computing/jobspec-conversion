#!/bin/bash
#SBATCH --job-name=ray_tune_pos
#SBATCH --output=logs.out
#SBATCH --error=logs.err
#SBATCH --mail-user=jbullwinkel@fas.harvard.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=96000
#SBATCH --time=00:08:00
#SBATCH --partition=test

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
python ray_tune.py --pkey pos --loss MSELoss --ncpu 48 --nsample 200
python ray_tune.py --pkey pos --loss L1Loss --ncpu 48 --nsample 200
python ray_tune.py --pkey pos --loss SmoothL1Loss --ncpu 48 --nsample 200
