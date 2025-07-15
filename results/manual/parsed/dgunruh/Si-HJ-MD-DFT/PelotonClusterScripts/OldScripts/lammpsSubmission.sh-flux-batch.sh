#!/bin/bash
#FLUX: --job-name=cSiaSiMD
#FLUX: -c=32
#FLUX: --queue=med2
#FLUX: -t=86400
#FLUX: --priority=16

export t='$SLURM_ARRAY_TASK_ID'

export t=$SLURM_ARRAY_TASK_ID
module load lammps
s=21248+100*$t
dumpA=aSi-$t.xyz
dumpsnapA=aSiBox-$t.xyz
dumpI=cSiaSiInterface-$t.xyz
dumpsnapI=cSiaSiInterfaceSnapshot-$t.xyz
mpirun lmp_mpi -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSi.in
mpirun lmp_mpi -var s $s -var d $dumpI -var dA $dumpA -var ds $dumpsnapI -in mergeAmorphousCrystalline.in
