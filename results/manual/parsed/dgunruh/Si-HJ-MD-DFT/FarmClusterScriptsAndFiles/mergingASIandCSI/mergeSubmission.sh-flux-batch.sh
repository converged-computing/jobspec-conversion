#!/bin/bash
#FLUX: --job-name=cSiaSiGAP
#FLUX: -n=16
#FLUX: --queue=high                 # Use the high partition
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export j='$SLURM_JOB_ID'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export j=$SLURM_JOB_ID
module load openmpi
s=$j   # 124248+$j+$t
dumpA=aSi-GAP-$j.xyz
dumpsnapA=aSiBox-GAP-$j.xyz
srun ../src/lammps-stable_3Mar2020/build/lmp_mpi -var s $s -var d $dumpA -var ds $dumpsnapA -in mergeAmorphousCrystallineGAP.in
