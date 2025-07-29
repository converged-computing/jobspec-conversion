#!/bin/bash
#SBATCH --job-name=rt_mpi
#SBATCH --output=rt_mpi%t.out
#SBATCH --error=rt_mpi%t.err
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000M

module load openmpi
srun -n $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/box.xml -p static_cycles_vertical -cs 1
