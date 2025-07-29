#!/bin/bash
#SBATCH --job-name=kpc-dask-2node
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=3

module purge
module load gnu11 openmpi3  
source /home/znazari/.bashrc
conda activate Zainab-env #you have to change this with your environment
cd $SLURM_SUBMIT_DIR
mpirun -n 6 python main_dask_algorithm.py 
