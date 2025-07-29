#!/bin/bash
#SBATCH --job-name=hier_search
#SBATCH --output=logs/slurm_%j.log
#SBATCH --error=logs/slurm_%j.log
#SBATCH --mail-user=bishal.santra@iitkgp.ac.in
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=23000
#SBATCH --time=2-00:00:00

export CUDA_VISIBLE_DEVICES='0,1'

module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
export CUDA_VISIBLE_DEVICES=0,1
nvidia-smi
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python search_params_acts.py -e 5 -model HIER++
