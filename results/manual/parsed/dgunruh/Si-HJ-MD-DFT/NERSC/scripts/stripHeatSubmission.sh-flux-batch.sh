#!/bin/bash
#FLUX: --job-name=mergeSi2
#FLUX: -n=64
#FLUX: --queue=med2                 # Use the high partition
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export j='$SLURM_JOB_ID'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export j=$SLURM_JOB_ID
module load openmpi
s=$j   # 124248+$j+$t
displacement=2.97
change=3.14
dumpA=bulk_heatstrip-$displacement-$change.xyz
dumpsnapA=box_heatstrip-$displacement-$change.xyz
srun ../lammps_3Mar2020/build/lmp_mpi -var s $s -var disp $displacement -var cng $change -var d $dumpA -var ds $dumpsnapA -in heatStrip.in
