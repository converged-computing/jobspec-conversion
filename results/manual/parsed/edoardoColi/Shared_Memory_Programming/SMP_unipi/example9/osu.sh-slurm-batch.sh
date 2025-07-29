#!/bin/bash
#SBATCH --output=./log/osu.log
#SBATCH --error=./err/osu.err
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

echo "Test executed on: $SLURM_JOB_NODELIST"
mpirun -n 2 --report-bindings /opt/ohpc/pub/mpi/osu-7.4/pt2pt/osu_bw 2>&1
echo "done"
