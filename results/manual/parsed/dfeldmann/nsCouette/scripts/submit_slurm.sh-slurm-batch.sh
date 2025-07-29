#!/bin/bash
#SBATCH --job-name=ns_SMALL-0032-12
#SBATCH --output=ns_SMALL-0032-12.%j.out
#SBATCH --error=ns_SMALL-0032-12.%j.err
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export OMP_NUM_THREADS='12'
export OMP_SCHEDULE='static'
export OMP_WAIT_POLICY='active'
export OMP_PROC_BIND='true'
export OMP_PLACES='cores'
export OMP_STACKSIZE='256M'

module switch PrgEnv-cray PrgEnv-intel
export OMP_NUM_THREADS=12
export OMP_SCHEDULE=static
export OMP_WAIT_POLICY=active
export OMP_PROC_BIND=true
export OMP_PLACES=cores
export OMP_STACKSIZE=256M
TASKS=$(($SLURM_NNODES*$SLURM_CPUS_ON_NODE/$OMP_NUM_THREADS))
TPN=$(($TASKS/$SLURM_NNODES))
echo "NODES: $SLURM_NNODES, TASKS: $TASKS, TPN: $TPN, THREADS: $OMP_NUM_THREADS"
aprun -n $TASKS -d $OMP_NUM_THREADS -N $TPN -S $(($TPN/2)) -ss  -cc numa_node ./nsCouette.x < input_nsCouette
