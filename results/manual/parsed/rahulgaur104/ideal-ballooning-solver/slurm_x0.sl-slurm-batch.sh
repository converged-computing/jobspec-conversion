#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:04:00
#SBATCH --qos=debug
#SBATCH --constraint=ntasks-per-node=1

PMIX_MCA_psec=native srun -n 1 --mpi=pmix_v3 singularity run simsopt_v0.13.0.sif /venv/bin/python set_x0.py 
