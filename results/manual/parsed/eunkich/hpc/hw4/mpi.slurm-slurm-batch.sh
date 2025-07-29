#!/bin/bash
#SBATCH --job-name=mpi
#SBATCH --account=amath
#SBATCH --output=mpi.csv
#SBATCH --error=mpi.err
#SBATCH --mail-user=eunkich@uw.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=0
#SBATCH --mem=5G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=40

module load ompi
mpic++ -std=c++14 -o mpi.o mpi.cpp;
echo "func,val,logerr,time,n,n_process";
for i in {1..40}
do
    mpirun -np $i mpi.o $((10 ** 8));
done
for i in {1..6}
do
    mpirun -np 8 mpi.o $((10 ** $i));
done
rm *.o
