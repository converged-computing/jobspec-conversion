#!/bin/bash
#SBATCH --job-name=ParrLO
#SBATCH --output=./run.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:4
#SBATCH --mem=8gb
#SBATCH --nodelist=ice[192,193]

module load cuda/11.1.1
module load cmake/3.20.3
module load magma/2.7.1
module load gcc/8.3.0
module load mpich/gcc/3.2.1
module load boost/1.72
BUILDDIR=../../build/src
EXE=$BUILDDIR/main
srun $EXE -c $BUILDDIR/../../benchmarks/main/input.cfg
