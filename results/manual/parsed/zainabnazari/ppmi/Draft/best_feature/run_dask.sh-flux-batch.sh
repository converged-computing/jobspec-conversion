#!/bin/bash
#FLUX: --job-name=kpc-dask-2node
#FLUX: -N=2
#FLUX: --queue=regular2
#FLUX: -t=14400
#FLUX: --priority=16

module purge
module load gnu11 openmpi3  
source /home/znazari/.bashrc
conda activate Zainab-env #you have to change this with your environment
cd $SLURM_SUBMIT_DIR
mpirun -n 6 python main_dask_algorithm.py 
