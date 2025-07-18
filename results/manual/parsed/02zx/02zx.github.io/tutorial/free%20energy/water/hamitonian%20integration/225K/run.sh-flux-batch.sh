#!/bin/bash
#FLUX: --job-name=liquid
#FLUX: -n=16
#FLUX: --queue=NVIDIAGeForceRTX4090
#FLUX: --urgency=16

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
