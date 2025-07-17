#!/bin/bash
#FLUX: --job-name=aSiGAP
#FLUX: -N=4
#FLUX: -c=2
#FLUX: -t=87120
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
j=$SLURM_JOB_ID
t=$SLURM_ARRAY_TASK_ID
pe=${PE_ENV,,}
if [ $pe != "gnu" ]; then
	module swap PrgEnv-$pe PrgEnv-gnu
fi
s=$((j+100*t))
dumpA=aSi-GAP-$j-$t.xyz
dumpsnapA=aSiBox-GAP-$j-$t.xyz
srun --cpu_bind=cores /global/common/software/m3634/lammps_3Mar2020/gnubuild_haswell/lmp_gnu_haswell -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSi.in
