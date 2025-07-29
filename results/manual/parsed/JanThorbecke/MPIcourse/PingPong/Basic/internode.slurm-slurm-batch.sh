#!/bin/bash
#SBATCH --job-name=PingPing-Internode
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:01:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'

set -x
echo $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=1
srun --mpi=pmix --cpu_bind=verbose,core -c $OMP_NUM_THREADS -n 2 ./a.out > inter_node.dat
