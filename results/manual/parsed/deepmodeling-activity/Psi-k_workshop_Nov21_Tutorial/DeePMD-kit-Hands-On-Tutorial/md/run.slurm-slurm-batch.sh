#!/bin/bash
#SBATCH --job-name=water_run
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=20:00:00

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load anaconda3
conda activate mpi-test
out_path=`pwd`
cd $out_path
mpirun -np 16 lmp -in in.lammps
