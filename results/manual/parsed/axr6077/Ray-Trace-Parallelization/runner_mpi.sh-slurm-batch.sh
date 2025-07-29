#!/bin/bash
#SBATCH --job-name=rt_mpi
#SBATCH --output=rt_mpi_%j.out
#SBATCH --error=rt_mpi_%j.err
#SBATCH --mail-user=ayushrout96@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000M
#SBATCH --time=00:02:00

srun -n $SLURM_NPROCS raytrace_mpi -h 5000 -w 5000 -c configs/box.xml -p dynamic -bh 100 -bw 100 
