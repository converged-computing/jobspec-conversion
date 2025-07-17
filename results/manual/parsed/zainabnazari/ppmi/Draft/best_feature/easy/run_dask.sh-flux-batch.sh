#!/bin/bash
#FLUX: --job-name=kpc-dask-2node
#FLUX: -c=3
#FLUX: --queue=regular2
#FLUX: -t=21600
#FLUX: --urgency=16

module purge
module load  gnu8/8.3.0  openmpi3/3.1.4 
source /home/znazari/.bashrc
conda activate Zainab-env #you have to change this with your environment
cd $SLURM_SUBMIT_DIR
mpirun -n 3 python  main_dask_algorithm.py > time.txt
