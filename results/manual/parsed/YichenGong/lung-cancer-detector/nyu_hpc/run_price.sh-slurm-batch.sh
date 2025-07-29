#!/bin/bash
#SBATCH --job-name=DSB17
#SBATCH --output=DSB_%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=05:00:00

module purge
module load scikit-learn/intel/0.18.1
module load tensorflow/python2.7/20170218
module list
cd $SCRATCH
cd lung-cancer-detector
python run.py
