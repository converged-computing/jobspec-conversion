#!/bin/bash
#SBATCH --job-name=tsr
#SBATCH --account=comsm0018
#SBATCH --output=tsr_%j.out
#SBATCH --error=tsr_%j.err
#SBATCH --mail-user=<ab12345>@bristol.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --time=00:02:00

module add libs/tensorflow/1.2
srun python tsr.py
wait
