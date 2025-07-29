#!/bin/bash
#SBATCH --job-name=parallelFDTD
#SBATCH --output=parallelFDTD.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=128000
#SBATCH --time=00:10:00
#SBATCH --partition=gpu
#SBATCH --constraint=volta|ampere|pascal

mkdir -p return
module load anaconda gcc/6.5.0 cuda/10.2.89 matlab/r2019b
source activate PFDTD
srun python testBench.py
mv ./*.log ./return/
mv ./*.hdf5 ./return/
mv ./*.out ./return/
