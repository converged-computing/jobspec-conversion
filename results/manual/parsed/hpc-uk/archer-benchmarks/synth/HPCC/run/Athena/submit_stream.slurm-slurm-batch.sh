#!/bin/bash
#SBATCH --job-name=hpcc_test
#SBATCH --account=a17-benchmarking
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=28

module load gcc/6.3.0/1
module load intel/mpi/64/2017.2.174
module load intel/runtime/64/2016.3.210 
module load intel/mkl/64/2017.2.174
mpilaunch=mpirun
corespn=28
if [ -f hpccoutf.txt ] 
then 
  rm hpccoutf.txt
fi
cp hpccinf_stream.txt hpccinf.txt
timestamp=$(date '+%Y%m%d%H%M')
${mpilaunch} -n ${corespn}  -ppn ${corespn} ./hpcc
mv hpccoutf.txt ${timestamp}_hpccoutf.txt
