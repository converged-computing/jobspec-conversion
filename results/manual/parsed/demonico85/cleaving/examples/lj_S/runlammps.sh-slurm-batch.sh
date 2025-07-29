#!/bin/bash
#SBATCH --job-name=ljbulk
#SBATCH --account=a12-vfl
#SBATCH --mail-user=ndp8@le.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-04:00:00
#SBATCH --constraint=ntasks-per-node=28

module purge
module load gcc/6.3.0/1 openmpi/3.0.1/01 
lmp="./lmp_mpi"
    rm -r ./dump/ 2> /dev/null
    rm -r ./restart/ 2> /dev/null
    mkdir dump
    mkdir restart
mpirun -np 28 $lmp  < bulk.in 
exit $?
