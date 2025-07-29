#!/bin/bash
#SBATCH --job-name=water_se_run
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=4-04:00:00

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load anaconda3
conda activate dpdev
out_path=`pwd`
cd $out_path
mpirun -np 8 lmp -in in.lammps -p 8x1 -log log -screen screen
