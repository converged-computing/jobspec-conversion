#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=output.log
#SBATCH --nodes=1
#SBATCH --ntasks=96
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=12

ns=(768)
rs=(96)
module purge
module load openmpi/3.1.6-gcc-12.2.0-d2gmn55
for n in "${ns[@]}"
do
    for r in "${rs[@]}"
    do
      mpiexec -np $r ./bin/heat_stencil_2D_mpi $n
    done
done
