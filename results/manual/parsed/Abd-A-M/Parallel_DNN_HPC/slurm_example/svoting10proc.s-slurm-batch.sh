#!/bin/bash
#SBATCH --job-name=Voting
#SBATCH --output=output.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=02:10:00
#SBATCH --constraint=ntasks-per-node=4

module load anaconda3/2021.11
conda activate backup_venv
module load  mpich/ge/gcc/64/3.3.2
module load tensorflow2-py39-cuda11.2-gcc9/2.7.0
module load tensorflow2-py37-cuda10.2-gcc8/2.5.2
module load keras-py37-cuda10.2-gcc/2.3.1
NUM_MPI_PROCESSES=10
mpirun -host au-prd-cnode011 -n $NUM_MPI_PROCESSES ~/.conda/envs/backup_venv/bin/python ~/scripts/cfai10_wo_consensus/CIFAR10/CIFAR10.py
