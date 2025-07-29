#!/bin/bash
#SBATCH --job-name=liquid
#SBATCH --output=output.out1
#SBATCH --error=error.err1
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=NVIDIAGeForceRTX4090
#SBATCH --nodelist=node30

module load compiler/gcc/7.3.1
module load compiler/intel/2021.3.0
module load mpi/intelmpi/2021.3.0
module swap apps/gromacs/intelmpi/2021.7-4090
module load mathlib/fftw/intelmpi/3.3.9_single
i=1.0
gmx_mpi grompp -f MDP/eq.mdp -c em/$i.gro -p em/$i.top -o eq/$i -maxwarn 3 
gmx_mpi mdrun -ntomp 16 -v -pin on -deffnm ./eq/$i -gpu_id 0 -pme gpu -nb gpu
gmx_mpi grompp -f MDP/prd.mdp -c eq/$i.gro -p em/$i.top -o md/$i -maxwarn 3 
gmx_mpi mdrun -ntomp 16 -v -pin on -deffnm ./md/$i -gpu_id 0 -pme gpu -nb gpu
