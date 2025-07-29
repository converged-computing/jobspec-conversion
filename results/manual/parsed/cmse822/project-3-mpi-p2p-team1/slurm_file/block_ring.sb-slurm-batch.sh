#!/bin/bash
#SBATCH --job-name=block_ring
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=128

module purge
module load GCC/6.4.0 OpenMPI/2.1.2
for i in $(seq 1 8); do 
    let ntasks=2**$i
    mpiexec -n $ntasks block_ring > block_ring_${ntasks}processors.csv
    echo "processes=$i is finished"
done
