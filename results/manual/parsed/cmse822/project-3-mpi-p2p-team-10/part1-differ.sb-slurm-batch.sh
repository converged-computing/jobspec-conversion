#!/bin/bash
#SBATCH --job-name=HW3-BLOCKING-DIFFER
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:01:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1,amd20

module purge
module load intel/2021a
cd /mnt/home/kamalida/cmse822/project-3-mpi-p2p-team-10                   ### change to the directory where your code is located
mpicxx ./ping-ping-blocking.c -o ping-ping-blocking.out
mpiexec -n 2 ./ping-ping-blocking.out
scontrol show job $SLURM_JOB_ID     ### write job information to output file
