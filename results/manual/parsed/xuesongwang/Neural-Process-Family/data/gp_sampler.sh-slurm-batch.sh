#!/bin/bash
#SBATCH --account=OD-228587
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=4

module load pytorch/1.8.1-py39-cuda112-mpi
source /scratch1/wan410/venv/bin/activate                                             # use the virtual environment
python3 GP_sampler_NPF.py
