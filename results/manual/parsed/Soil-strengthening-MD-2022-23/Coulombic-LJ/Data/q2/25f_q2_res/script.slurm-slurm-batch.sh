#!/bin/bash
#SBATCH --job-name=25f_q2_res
#SBATCH --output=output.txt
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=long-28core
#SBATCH --constraint=ntasks-per-node=27

module load shared
module load mvapich2/gcc/64/2.2rc1
module load lammps/gcc/3Mar2020-bigbig
cd $HOME/25f_q2_res
mpirun lmp_bigbig < hydrogel_test.in > output.txt 
