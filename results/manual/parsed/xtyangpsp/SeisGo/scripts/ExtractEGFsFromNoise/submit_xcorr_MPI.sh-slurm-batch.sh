#!/bin/bash
#SBATCH --job-name=xc
#SBATCH --account=xtyang
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16000
#SBATCH --time=5-00:00:00

module load rcac
module use /depot/xtyang/etc/modules
module load conda-env/seisgo-py3.7.6
mpirun -n $SLURM_NTASKS python 2_xcorr_MPI.py
