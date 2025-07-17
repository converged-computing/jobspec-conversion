#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=4
#FLUX: --queue=E5-2640V4
#FLUX: --urgency=16

LMP_EXE="/opt/MD/lammps/bin/lammps-cpu-12Dec18"
ADD_ARGS="-sf omp"
CURDIR=`pwd`
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
NODES=`scontrol show hostnames $SLURM_JOB_NODELIST`
for i in $NODES
do
	echo "$i:$SLURM_NTASKS_PER_NODE" >> $CURDIR/nodelist.$SLURM_JOB_ID
done
mpirun -genv I_MPI_FABRICS=tcp -machinefile $CURDIR/nodelist.$SLURM_JOB_ID $LMP_EXE -in $SLURM_JOB_NAME.in -l $SLURM_JOB_NAME.log $ADD_ARGS > $SLURM_JOB_NAME.sta
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
