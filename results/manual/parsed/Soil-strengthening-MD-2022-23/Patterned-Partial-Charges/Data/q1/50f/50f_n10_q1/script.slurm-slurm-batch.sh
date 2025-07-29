#!/bin/bash
#SBATCH --job-name=50f_n10_q1
#SBATCH --output=output.txt
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=27

module load shared
module load mvapich2/gcc/64/2.2rc1
module load lammps/gcc/3Mar2020-bigbig
cd $HOME/50f_n10_q1
mpirun lmp_bigbig < hydrogel_test.in > output.txt 
