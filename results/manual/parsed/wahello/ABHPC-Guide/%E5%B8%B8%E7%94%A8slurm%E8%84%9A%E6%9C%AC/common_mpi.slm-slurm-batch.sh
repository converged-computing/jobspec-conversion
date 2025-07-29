#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=20

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
