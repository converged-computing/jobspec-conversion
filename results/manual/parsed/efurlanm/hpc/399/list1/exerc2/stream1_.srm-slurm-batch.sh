#!/bin/bash
#SBATCH --job-name=list06
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
module load intel_psxe/2019
EXEC1=/scratch/padinpe/____/stream
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "SLURM_CPUS_PER_TASK" $SLURM_CPUS_PER_TASK
srun -N 1 -c $SLURM_CPUS_PER_TASK $EXEC1
