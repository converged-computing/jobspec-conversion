#!/bin/bash
#FLUX: --job-name=cSiaSiMD
#FLUX: -n=32
#FLUX: -c=8
#FLUX: -t=600
#FLUX: --priority=16

export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='1'
export j='$SLURM_JOB_ID'

export OMP_PROC_BIND=true
export OMP_PLACES=threads
export OMP_NUM_THREADS=1
export j=$SLURM_JOB_ID
s=$j
dumpA=aSi-GAP-$j.xyz
dumpsnapA=aSiBox-GAP-$j.xyz
srun --cpu_bind=cores /global/common/software/m3634/lammps_3Mar2020/gnubuild_KNL/lmp_gnu_knl -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSi.in
