#!/bin/bash
#SBATCH --job-name=PingPing-Internode
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:01:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=40

set -x
echo $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
ulimit -s unlimited
srun --mpi=pmix --cpu_bind=verbose,core -n $SLURM_NTASKS ping_pong_advanced2_ssend > ssend.dat
srun --mpi=pmix --cpu_bind=verbose,core -n $SLURM_NTASKS ping_pong_advanced2_send > send.dat
