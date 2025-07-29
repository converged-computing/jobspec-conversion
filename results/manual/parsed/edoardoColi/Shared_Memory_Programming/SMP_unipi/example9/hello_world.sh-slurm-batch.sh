#!/bin/bash
#SBATCH --output=%j.log
#SBATCH --error=%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=1

srun /bin/hostname
echo "running with srun on 4 nodes:"
srun --mpi=pmix ./hello_world
echo "running with mpirun on two nodes:"
mpirun -n 2 --report-bindings ./hello_world
