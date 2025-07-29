#!/bin/bash
#SBATCH --job-name=GMX
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --no-requeue

export OMP_NUM_THREADS='1'

(( ncores = SLURM_NNODES * 24 ))
export OMP_NUM_THREADS=1
module load gromacs/2018 # change to the desired version
aprun -n $ncores gmx mdrun_mpi -s topol -dlb yes -maxh 0.5
