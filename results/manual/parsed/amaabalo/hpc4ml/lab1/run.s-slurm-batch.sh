#!/bin/bash
#SBATCH --job-name=lab1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --constraint=ntasks-per-node=1

SRCDIR=$HOME/hpc4ml/lab1
cd $SRCDIR
module purge
module load python3/intel/3.5.3
module load numpy/python3.5/intel/1.13.1
module load valgrind/gnu/3.12.0
module load intel/17.0.1
$SRCDIR/lab1-c1-c2
python3 lab1-c3-c4.py
$SRCDIR/lab1-c5-c6
