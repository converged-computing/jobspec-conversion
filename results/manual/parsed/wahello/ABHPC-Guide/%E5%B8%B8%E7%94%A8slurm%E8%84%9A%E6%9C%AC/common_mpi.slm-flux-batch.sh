#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=4
#FLUX: --queue=E5-2640V4
#FLUX: --priority=16

MPI_CMD="a.out -in xxx.in"
CURDIR=`pwd`
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
NODES=`scontrol show hostnames $SLURM_JOB_NODELIST`
for i in $NODES
do
	echo "$i:$SLURM_NTASKS_PER_NODE" >> $CURDIR/nodelist.$SLURM_JOB_ID
done
mpirun -genv I_MPI_FABRICS=tcp -machinefile $CURDIR/nodelist.$SLURM_JOB_ID $MPI_CMD > $SLURM_JOB_NAME.sta
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
