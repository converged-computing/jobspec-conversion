#!/bin/bash
#SBATCH --job-name=Z
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=20

for i in {1..10}; do
RAND=$(echo $RANDOM)  # random initial velocity seed
mpirun lmp_mpi < X -var random $RAND -var iter $i -var name Z
done
