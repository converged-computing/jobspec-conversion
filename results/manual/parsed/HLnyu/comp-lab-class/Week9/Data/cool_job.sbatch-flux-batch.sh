#!/bin/bash
#FLUX: --job-name=LAMMPS
#FLUX: -t=86400
#FLUX: --urgency=16

source /scratch/work/courses/CHEM-GA-2671-2022fa/software/lammps-gcc-30Oct2022/setup_lammps.bash
temperatures=('1.5' '1.0' '0.9' '0.8' '0.7' '0.65' '0.6' '0.55' '0.5' '0.475' '0.45')
for T in "${temperatures[@]}"
do
	echo "cooling down to T_$T"
	mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T$T.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
done
