#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=00:10:00

MEMORY_PER_TASK=$(( $SLURM_CPUS_PER_TASK*$SLURM_MEM_PER_CPU ))
echo SLURM_NTASKS: $SLURM_NTASKS  
echo SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE
echo SLURM_CPUS_PER_TASK: $SLURM_CPUS_PER_TASK 
echo SLURM_NNODES: $SLURM_NNODES
echo SLURM_MEM_PER_CPU: $SLURM_MEM_PER_CPU
module load cesga/2020 gcc/system openmpi/4.0.5_ft3_cuda dask/2022.2.0
SCHED_FILE="./scheduler_info.json"
srun -n $SLURM_NTASKS \
    -c $SLURM_CPUS_PER_TASK \
    --mem=$MEMORY_PER_TASK \
	--resv-ports=$SLURM_NTASKS -l \
    python ./dask_cluster.py \
        -local $LUSTRE_SCRATCH \
        --worker \
        -scheduler_file $SCHED_FILE \
        --ib \
        #-preload  ./PreLoad.py
