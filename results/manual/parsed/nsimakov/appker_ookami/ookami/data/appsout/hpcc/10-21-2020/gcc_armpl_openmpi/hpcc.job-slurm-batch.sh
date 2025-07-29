#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=48

pwd
module load slurm
spack load hpcc@develop fft=fftw3 %gcc ^armpl ^openmpi
EXE=${EXE:-$(which hpcc)}
echo $EXE
mpirun -n 48 $EXE 
