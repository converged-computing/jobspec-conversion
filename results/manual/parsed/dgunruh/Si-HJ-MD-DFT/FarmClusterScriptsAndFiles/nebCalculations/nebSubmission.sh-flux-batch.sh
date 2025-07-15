#!/bin/bash
#FLUX: --job-name=mergeSi2
#FLUX: -n=64
#FLUX: --queue=med2                 # Use the high partition
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export j='$SLURM_JOB_ID'
export t='$SLURM_ARRAY_TASK_ID'

export OMP_NUM_THREADS=1
export j=$SLURM_JOB_ID
export t=$SLURM_ARRAY_TASK_ID
module load openmpi
s=$j   # 124248+$j+$t
temp=aSi${t}
log=aSi/${temp}
addendum=55
beginning=inputs/neb_input_${temp}.out
ending=inputs/neb_end_${temp}.out
idfile=inputs/neb_atoms_${temp}.out
dump=neb_calc_result_${temp}_${s}_${t}
pNum=32
srun ../lammps_3Mar2020/build/lmp_mpi -var i $beginning -var f $ending -var pNum $pNum -var idfile $idfile -var dumpfile $dump -log logfiles/${log}/log.lammps -screen screenfiles/screen${temp} -partition ${pNum}x2 -in nebGAP.in
