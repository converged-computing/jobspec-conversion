#!/bin/bash
#SBATCH --job-name=MFC-PARAVIEW-1
#SBATCH --account=CFD154
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --partition=gpu

cd $SLURM_SUBMIT_DIR
date
module load paraview/5.10.0-egl
srun -n 28 pvbatch render1.py -W 7680 -H 4320 -o frames1 -i /ccs/home/henrylb/project/aradhakr34/master/MFC-develop/samples/3D_bubbles_monopole_many/silo_hdf5
