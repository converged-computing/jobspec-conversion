#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=E5-2630V2
#SBATCH --constraint=ntasks-per-node=12

module load lammps/12Dec18
HW="cpu"
CURDIR=`pwd`
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
NODES=`scontrol show hostnames $SLURM_JOB_NODELIST`
for i in $NODES
do
echo "$i:$SLURM_NTASKS_PER_NODE" >> $CURDIR/nodelist.$SLURM_JOB_ID
done
if [ "$HW" = "cpu" ];then
	mpirun -genv I_MPI_FABRICS=ofi -machinefile $CURDIR/nodelist.$SLURM_JOB_ID lammps-$HW -in $SLURM_JOB_NAME.in -sf omp -pk omp 1 -l $SLURM_JOB_NAME.log > $SLURM_JOB_NAME.sta
elif [ "$HW" = "gpu" ];then
	if [ "$SLURM_JOB_PARTITION" = "E5-2678V3" ]; then
		PK_NUM=2
	elif [ "$SLURM_JOB_PARTITION" = "E5-2630V2" ]; then
		PK_NUM=3
	else
		PK_NUM=2
		echo "Unkown partition, set gpu package number to 2" > $SLURM_JOB_NAME.slm.error
	fi
	mpirun -machinefile $CURDIR/nodelist.$SLURM_JOB_ID GPU-PRERUN
	mpirun -genv I_MPI_FABRICS=ofi -machinefile $CURDIR/nodelist.$SLURM_JOB_ID lammps-$HW -in $SLURM_JOB_NAME.in -sf gpu -pk gpu $PK_NUM  -l $SLURM_JOB_NAME.log > $SLURM_JOB_NAME.sta
else
	echo "Error: The hardware should be defined as cpu or gpu in slurm scripts!" > $SLURM_JOB_NAME.slm.error
fi
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
