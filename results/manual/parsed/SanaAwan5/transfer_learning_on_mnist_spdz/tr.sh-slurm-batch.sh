#!/bin/bash
#SBATCH --output=slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1

module load Python/3.6.9
source /scratch/sanaawan/PySyft/venv/bin/activate
which python
cd examples/tutorials/
python transfer_learning1.py
